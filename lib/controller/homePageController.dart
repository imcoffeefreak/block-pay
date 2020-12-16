import 'package:block_pay/api/getTransactionDetail.dart';
import 'package:block_pay/api/postCardDetails.dart';
import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/model/transactionModel.dart';
import 'package:block_pay/view/maskControllerClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:block_pay/model/cardModel.dart' as c;
import 'package:google_sign_in/google_sign_in.dart';

class HomePageController extends ChangeNotifier {
  List<CardModel> cardDetails = [];
  List<TransactionModel> transaction = [];
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  Firestore firestore;
  FirebaseUser firebaseUser;
  String user = "";
  String cardType = "VISA";
  int statusCode;

  /**
   * Adding cards controller
   */
  final MaskedTextController cardNumber =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController expiryDate = MaskedTextController(mask: '00/00');
  final TextEditingController holderName = TextEditingController();
  final TextEditingController amountAvailable = TextEditingController();

  HomePageController() {
    auth = FirebaseAuth.instance;
    firestore = Firestore.instance;
    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    getAuthenticatedUser();
    getTransactionDetails();
  }

  void getAuthenticatedUser() async {
    try{
      firebaseUser = await auth.currentUser();
      user = firebaseUser.displayName;
      notifyListeners();
    }catch(e){

    }
  }

  getTransactionDetails() async {
    try {
      transaction.clear();
      cardDetails.clear();
      var transactionDetails =
          await GetTransactionDetails.getTransactionDetails();
      print(transactionDetails);
      transactionDetails['chain'].forEach((data){
        if(data['userId'] == firebaseUser.uid){
          transaction.add(TransactionModel.fromJson(data,firebaseUser.uid));
        }
      });
      transactionDetails['card'].forEach((data){
        if(data['userId'] == firebaseUser.uid){
          cardDetails.add(CardModel.fromJson(data,firebaseUser.uid));
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void selectCard(String card){
    cardType = card;
    notifyListeners();
  }

   addCard() async {
    try{
      var newCards = c.Data(
        holderName: holderName.text,
        cardNumber: cardNumber.text,
        expiryDate: expiryDate.text,
        cardType: cardType,
        amountAvailable: int.parse(amountAvailable.text),
        userId: firebaseUser.uid,
      );
      statusCode = await PostCardDetails.postCardDetails(newCards.toJson());
      if(statusCode==200){
        allControllerClear();
        getTransactionDetails();
        notifyListeners();
        return statusCode;
      }
    }catch(e){

    }
  }

  allControllerClear(){
    holderName.clear();
    cardNumber.clear();
    expiryDate.clear();
    amountAvailable.clear();
    cardType="VISA";
    notifyListeners();
  }

  signOut() async {
    await auth.signOut();
  }
}
