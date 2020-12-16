import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/model/transactionModel.dart';
import 'package:block_pay/view/balance/balance.dart';
import 'package:block_pay/view/history/historyPage.dart';
import 'package:block_pay/view/transfer/transferPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:block_pay/view/constant.dart';

class PinPage extends StatefulWidget {
  PAGES page;
  List<CardModel> cardModel;
  List<TransactionModel> transactionModel;

  PinPage({@required this.page,@required List<CardModel> model,@required List<TransactionModel> tModel}){
    if(model!=null && tModel!=null){
      cardModel = model;
      transactionModel = tModel;
    }else{
      model = [];
      tModel = [];
    }
  }

  @override
  _PinPageState createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  bool obsecureText = true;
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Text(
                          "Enter Your Security Code",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.shortestSide * 0.05,
                    left: MediaQuery.of(context).size.shortestSide * 0.25,
                    right: MediaQuery.of(context).size.shortestSide * 0.25,
                  ),
                  child: PinCodeTextField(
                    obsecureText: true,
                    controller: password,
                    length: 6,
                    textInputType: TextInputType.number,
                    selectedColor: Colors.white,
                    activeColor: Colors.white,
                    inactiveFillColor: Colors.transparent,
                    fieldWidth: 14,
                    enableActiveFill: true,
                    activeFillColor: Colors.white,
                    onChanged: (value) {
                      print(value);
                      print(value.runtimeType);
                    },
                    onCompleted: (value) {
                      if (int.parse(value) == 123456) {
                        switch (widget.page) {
                          case PAGES.PAYMENT:
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TransferPage(model: widget.cardModel)));
                            break;
                          case PAGES.BALANCE:
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BalancePage(model: widget.cardModel)));
                            break;
                          case PAGES.HISTORY:
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryPage(model: widget.transactionModel,)));
                            break;
                        }
                      }
                    },
                    shape: PinCodeFieldShape.circle,
                    backgroundColor: Colors.transparent,
                    inactiveColor: Colors.white,
                    textStyle: GoogleFonts.lato(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1.5),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "1";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "1",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "2";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "2",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "3";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "3",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "4";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "4",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "5";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "5",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "6";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "6",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "7";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "7",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "8";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "8",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "9";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "9",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              password.text += "0";
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
//                          border: Border.all(color: Colors.black12),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                              child: Text(
                                "0",
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (password.text != null &&
                                  password.text.length > 0) {
                                password.text = password.text
                                    .substring(0, password.text.length - 1);
                              }
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              password.clear();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            width:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            height:
                                MediaQuery.of(context).size.shortestSide * 0.05,
                            child: Center(
                                child: Icon(
                              Icons.backspace,
                              color: Colors.black,
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
