import 'package:block_pay/controller/authenticationController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool isObsecureText = true;
  final formKey = GlobalKey<FormState>();

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
                          "Register",
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
            Container(
              margin: EdgeInsets.only(
                left: 40,
                right: 40,
                top: 50,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Consumer<AuthenticationController>(
                  builder: (context, authenticationController, _) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: authenticationController.name,
                              validator: (value) {
                                print(value);
                                if (value == null || value.isEmpty) {
                                  return 'Name field required';
                                }
                                return null;
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Name',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller:
                                  authenticationController.emailController,
                              validator: (value) {
                                print(value);
                                if (value == null || value.isEmpty) {
                                  return 'Email field required';
                                }
                                return null;
                              },
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller:
                                  authenticationController.passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password field required';
                                }
                                return null;
                              },
                              obscureText: isObsecureText,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    (isObsecureText)
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isObsecureText = !isObsecureText;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: Size(150, 35),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await authenticationController
                                      .signUpWithEmail(context);
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
