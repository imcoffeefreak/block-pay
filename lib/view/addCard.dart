import 'package:block_pay/controller/homePageController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'package:bot_toast/bot_toast.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _formKey = GlobalKey<FormState>();
  ProgressDialog progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<HomePageController>(context, listen: false);
    return Scaffold(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Add Card",
                      style: GoogleFonts.breeSerif(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.05),
                      child: Text(
                        "Holder's Name",
                        style: GoogleFonts.breeSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length <= 0) {
                            return "holders name required";
                          }
                          return null;
                        },
                        controller: controller.holderName,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Holder's Name",
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.05),
                      child: Text(
                        "Card Number",
                        style: GoogleFonts.breeSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length <= 0) {
                            return "card number required";
                          }
                          return null;
                        },
                        controller: controller.cardNumber,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Card Number",
                          hintText: "xxxx xxxx xxxx xxxx",
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.05),
                      child: Text(
                        "Expiry Period",
                        style: GoogleFonts.breeSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length <= 0) {
                            return "expiry date is required";
                          }
                          return null;
                        },
                        controller: controller.expiryDate,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Expiry Period",
                          hintText: "10/23",
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.05),
                      child: Text(
                        "Card Type",
                        style: GoogleFonts.breeSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: DropdownButtonFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length <= 0) {
                            return "card type required";
                          }
                          return null;
                        },
                        value: controller.cardType,
                        decoration: InputDecoration(
                          labelText: "Card Type",
                          hintText: "VISA ... etc.",
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        items: cardType.map((cards) {
                          return DropdownMenuItem(
                            value: cards,
                            child: Text(
                              "$cards",
                              style: GoogleFonts.lato(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (cardType) {
                          controller.selectCard(cardType);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left:
                              MediaQuery.of(context).size.shortestSide * 0.05),
                      child: Text(
                        "Amount Available",
                        style: GoogleFonts.breeSerif(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value.trim().length <= 0) {
                            return "amount required";
                          }
                          return null;
                        },
                        controller: controller.amountAvailable,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Amount Availbale",
                          hintText: "1000",
                          labelStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.shortestSide * 0.05),
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            progressDialog.style(
                              message: "Adding Card ...",
                              progressWidget: Container(
                                child: CircularProgressIndicator(
                                  backgroundColor:  Color(0XFF152562),
                                ),
                                width: 100,
                                height: 100,
                              ),
                            );
                            progressDialog.show();
                            var statusCode = await controller.addCard();
                            if (statusCode == 200) {
                              progressDialog.hide();
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0XFF39449D),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              "Add Card",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
