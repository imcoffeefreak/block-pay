import 'package:block_pay/controller/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
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
                    left: MediaQuery.of(context).size.shortestSide * 0.1,
                    top: MediaQuery.of(context).size.shortestSide * 0.1,
                  ),
                  child: Consumer<AuthenticationController>(
                      builder: (context, authenticationController, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Authentication",
                          style: GoogleFonts.breeSerif(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Signin",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Switch(
                              value: authenticationController.isSignin,
                              onChanged: (value) {
                                authenticationController.changeAuth(value);
                              },
                              activeTrackColor: Color(0XFF39449D),
                              activeColor: Colors.greenAccent,
                              inactiveThumbColor: Colors.orangeAccent,
                            ),
                            Text(
                              "Signup",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<AuthenticationController>(
                builder: (context, authenticationController, _) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      color: Colors.white,
                    ),
                    child: (!authenticationController.isSignin)
                        ? ListView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  left:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  right:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  bottom:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05,
                                ),
                                child: Text(
                                  "Enter Phone Number",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.02,
                                  left:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  right:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  bottom:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05,
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                    hintText: "Phone Number",
                                  ),
                                  keyboardType: TextInputType.phone,
                                  controller:
                                      authenticationController.phoneNumber,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.02,
                                  left:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  right:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.1,
                                  bottom:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.05,
                                ),
                                child: Center(
                                  child: RaisedButton(
                                    onPressed: () {
                                      authenticationController
                                          .checkNumberValid();
                                    },
                                    child: Text(
                                      "Send OTP",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    color: Color(0XFF152562),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                              ),
                              (authenticationController.isPhoneValid)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.02,
                                        left: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        right: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        bottom: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.05,
                                      ),
                                      child: Text(
                                        "Enter OTP sent to +91 ${authenticationController.phoneNumber!.text}",
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              (authenticationController.isPhoneValid)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.02,
                                        left: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        right: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        bottom: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.05,
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Colors.orangeAccent,
                                            ),
                                          ),
                                          hintText: "Enter OTP",
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller:
                                            authenticationController.otp,
                                        maxLength: 6,
                                      ),
                                    )
                                  : Container(),
                              (authenticationController.isPhoneValid)
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        top: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.02,
                                        left: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        right: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.1,
                                        bottom: MediaQuery.of(context)
                                                .size
                                                .shortestSide *
                                            0.05,
                                      ),
                                      child: Center(
                                        child: RaisedButton(
                                          onPressed: () {
                                            authenticationController
                                                .signIn();
                                          },
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          color: Color(0XFF152562),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.01,
                          ),
                          child: Text(
                            "Name",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.02,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              hintText: "Name of account holder",
                            ),
                            keyboardType: TextInputType.text,
                            controller:
                            authenticationController.name,
                          ),
                        ),

                        /**
                         * Email Address
                         */
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.01,
                          ),
                          child: Text(
                            "Email Address",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.02,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              hintText: "Email Address",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller:
                            authenticationController.email,
                          ),
                        ),

                        /**
                         * Phone Number
                         */
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.01,
                          ),
                          child: Text(
                            "Phone number",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.02,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              hintText: "Phone number",
                            ),
                            keyboardType: TextInputType.phone,
                            controller:
                            authenticationController.phoneNumber,
                          ),
                        ),
                        /**
                         * OTP Button
                         */
                        Padding(
                          padding: EdgeInsets.only(
                            top:
                            MediaQuery.of(context).size.shortestSide *
                                0.02,
                            left:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            right:
                            MediaQuery.of(context).size.shortestSide *
                                0.1,
                            bottom:
                            MediaQuery.of(context).size.shortestSide *
                                0.05,
                          ),
                          child: Center(
                            child: RaisedButton(
                              onPressed: () {
                                authenticationController
                                    .checkNumberValid();
                              },
                              child: Text(
                                "Send OTP",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              color: Color(0XFF152562),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                        /**
                         * Entering OTP
                         */
                        (authenticationController.isPhoneValid)
                            ? Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.02,
                            left: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            right: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            bottom: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.05,
                          ),
                          child: Text(
                            "Enter OTP sent to +91 ${authenticationController.phoneNumber!.text}",
                                        style: GoogleFonts.lato(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                        )
                            : Container(),
                        (authenticationController.isPhoneValid)
                            ? Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.02,
                            left: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            right: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            bottom: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.05,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              hintText: "Enter OTP",
                            ),
                            keyboardType: TextInputType.number,
                            controller:
                            authenticationController.otp,
                            maxLength: 6,
                          ),
                        )
                            : Container(),
                        (authenticationController.isPhoneValid)
                            ? Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.02,
                            left: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            right: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.1,
                            bottom: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.05,
                          ),
                          child: Center(
                            child: RaisedButton(
                              onPressed: () {
                                authenticationController
                                    .signIn();
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              color: Color(0XFF152562),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15)),
                            ),
                          ),
                        )
                            : Container(),
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
