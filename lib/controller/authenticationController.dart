import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationController extends ChangeNotifier {
  bool isSignin = true;
  bool isPhoneValid = false;
  FirebaseAuth auth;
  Firestore firestore;
  String smsCode;
  String verificationId;
  SharedPreferences sharedPreferences;

  /**
   * Sign in details
   */
  TextEditingController phoneNumber;
  TextEditingController otp;

  /**
   * Sign up details
   */
  TextEditingController name;
  TextEditingController email;

  /**
   * Google Signin
   *
   */
  GoogleSignIn googleSignIn;
  GoogleSignInAccount currentUser;

  AuthenticationController() {
    phoneNumber = TextEditingController();
    otp = TextEditingController();
    name = TextEditingController();
    email = TextEditingController();
    auth = FirebaseAuth.instance;
    firestore = Firestore.instance;
    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  changeAuth(bool value) {
    isSignin = value;
    phoneNumber.clear();
    otp.clear();
    isPhoneValid = false;
    notifyListeners();
  }

  checkNumberValid() async {
    if (phoneNumber.text.length == 10) {
      int numb = int.parse(phoneNumber.text[0]);
      if (numb >= 6) {
        isPhoneValid = true;
        sendOTP();
      }
    }
    notifyListeners();
  }

  void sendOTP() async {
    try {
      final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String code) {
        verificationId = code;
        notifyListeners();
      };

      final PhoneCodeSent sms = (String verId, [int forceCodeSent]) {
        verificationId = verId;
      };

      final PhoneVerificationCompleted verifiedSuccess = (AuthCredential user) {
        print("verification done ${user.providerId}");
      };

      final PhoneVerificationFailed verifiedError = (AuthException user) {
        print("verification failed ${user.code} ${user.message}");
      };

      await auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneNumber.text}",
        timeout: Duration(seconds: 10),
        codeSent: sms,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedError,
      );
    } catch (error) {
      print("********* Error in sending OTP $error");
    }
  }

  void signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: otp.text);
      final firebaseUser = await auth.signInWithCredential(credential);
      if (firebaseUser.user.uid != null) {
        var data = {
          "name": name.text,
          "email": email.text,
          "phone": phoneNumber.text,
          "created_at": DateTime.now().millisecondsSinceEpoch,
          "updated_at": DateTime.now().millisecondsSinceEpoch
        };
        await firestore
            .collection("user")
            .document(firebaseUser.user.uid)
            .setData(data, merge: true);
        sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt("count", 0);
      }
    } catch (error) {
      print("********** ERROR IN SIGN IN $error");
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final AuthResult authResult = await auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setInt("count", 0);
    } catch (error) {
      print("********** ERROR IN SIGN IN $error");
    }
  }
}
