import 'package:block_pay/controller/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthenticationV2 extends StatefulWidget {
  @override
  _AuthenticationV2State createState() => _AuthenticationV2State();
}

class _AuthenticationV2State extends State<AuthenticationV2> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthenticationController>(
      create: (context) => AuthenticationController(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0XFF152562),
                    Color(0XFF39449D),
                  ],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.1),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.shortestSide * 0.05,
                    top: MediaQuery.of(context).size.shortestSide * 0.1,
                  ),
                  child: Consumer<AuthenticationController>(
                    builder: (context, authenticationController, _) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Authenticate",
                          style: GoogleFonts.breeSerif(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<AuthenticationController>(
                builder: (context, authenticationController, _) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.shortestSide * 0.06),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.09,
                            child: SignInButton(
                              Buttons.Google,
                              onPressed: () async {
                                await authenticationController.signInWithGoogle();
                                var user = authenticationController.auth!.currentUser;
                                if (user != null) {
                                  Navigator.pushReplacementNamed(context, "/");
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: BorderSide(
                                  color: Color(0XFF152562),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
