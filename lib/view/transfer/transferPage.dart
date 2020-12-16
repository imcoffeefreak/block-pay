import 'package:block_pay/controller/transactionController.dart';
import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/view/atmCards/atmCards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class TransferPage extends StatefulWidget {
  List<CardModel> cardModel;

  TransferPage({@required List<CardModel> model}) {
    if (model != null) {
      cardModel = model;
    } else {
      model = [];
    }
  }

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  int currentPageValue = 0;
  bool switched = true;
  ProgressDialog progressDialog;

  @override
  initState(){
    super.initState();
    progressDialog = ProgressDialog(context);
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.grey : Color(0XFF152562),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransactionController>(
      create: (context) =>
          TransactionController(card: widget.cardModel.first.data),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
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
                              color: Colors.black,
                              size: 20,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: 45,
                          ),
                          Text(
                            "Transfer",
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.shortestSide * 0.05,
                        bottom: MediaQuery.of(context).size.shortestSide * 0.02,
                        left: MediaQuery.of(context).size.shortestSide * 0.1,
                      ),
                      child: Text(
                        "Choose Your Card",
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Consumer<TransactionController>(
                      builder: (context, transactionController, _) {
                    return Container(
                      width: MediaQuery.of(context).size.shortestSide * 0.9,
                      height: MediaQuery.of(context).size.shortestSide * 0.5,
                      child: Stack(
                        children: <Widget>[
                          PageView.builder(
                            itemCount: widget.cardModel.length,
                            itemBuilder: (context, index) {
                              return AtmCards(
                                data: widget.cardModel[index].data,
                              );
                            },
                            onPageChanged: (int page) {
                              getChangedPageAndMoveBar(page);
                              transactionController.changeCardDetails(
                                  card: widget.cardModel[page].data);
                            },
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 108.0),
                                child: Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0; i < widget.cardModel.length; i++)
                                          if (i == currentPageValue) ...[
                                            circleBar(true)
                                          ] else
                                            circleBar(false),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<TransactionController>(
                  builder: (context, transactionController, _) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Color(0XFF152562),
                        Color(0XFF39449D),
                      ],
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
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Send to",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "Mobile",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Switch(
                                  value: switched,
                                  onChanged: (value) {
                                    setState(() {
                                      switched = value;
                                      print(switched);
                                    });
                                  },
                                  activeTrackColor: Color(0XFF39449D),
                                  activeColor: Colors.greenAccent,
                                ),
                                Text(
                                  "Account",
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      (switched)
                          ? Form(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller:
                                          transactionController.accountNumber,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        hintText: "Account No.",
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Color(0XFF39449D),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller:
                                          transactionController.ifscCode,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        hintText: "IFSC Code",
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Color(0XFF39449D),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller:
                                          transactionController.receiverName,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        hintText: "Name",
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Color(0XFF39449D),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.25,
                                      right: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.25,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Payment",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor:
                                                  Color(0XFF39449D),
                                              actions: <Widget>[
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Card(
                                                    elevation: 5.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                    ),
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0XFF39449D),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: Text(
                                                        "Cancel",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  25,
                                                ),
                                              ),
                                              content: ListView(
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                      bottom: 8.0,
                                                      top: 30.0,
                                                    ),
                                                    child: TextFormField(
                                                      controller:
                                                          transactionController
                                                              .amount,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            25,
                                                          ),
                                                        ),
                                                        hintText: "Amount",
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                        hintStyle:
                                                            GoogleFonts.roboto(
                                                          fontSize: 20,
                                                          color: Color(
                                                            0XFF39449D,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.15,
                                                      right: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide *
                                                          0.15,
                                                    ),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        progressDialog.style(
                                                          message: "Transfering please wait.....",
                                                          progressWidget: CircularProgressIndicator(
                                                            backgroundColor: Color(0XFF152562),
                                                          ),
                                                        );
                                                        progressDialog.show();
                                                        int code = await transactionController
                                                            .sendMoneyToAccount();
                                                        if(code == 200){
                                                          progressDialog.hide();
                                                          Navigator.pop(context);
                                                        }
                                                      },
                                                      child: Card(
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0XFF39449D),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          child: Text(
                                                            "Transfer",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ).then((value){
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0XFF39449D),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Text(
                                            "Pay Now",
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
                            )
                          : Form(
                              child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller:
                                          transactionController.mobileNumber,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        hintText: "Mobile Number",
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Color(0XFF39449D),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.25,
                                      right: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.25,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                  "Payment",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Color(0XFF39449D),
                                                actions: <Widget>[
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Card(
                                                      elevation: 5.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                      ),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 40,
                                                        width: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0XFF39449D),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                        child: Text(
                                                          "Cancel",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    25,
                                                  ),
                                                ),
                                                content: ListView(
                                                  shrinkWrap: true,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 8.0,
                                                        right: 8.0,
                                                        bottom: 8.0,
                                                        top: 30.0,
                                                      ),
                                                      child: TextFormField(
                                                        controller:
                                                            transactionController
                                                                .amount,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              25,
                                                            ),
                                                          ),
                                                          hintText: "Amount",
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white,
                                                          hintStyle: GoogleFonts
                                                              .roboto(
                                                            fontSize: 20,
                                                            color: Color(
                                                              0XFF39449D,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.15,
                                                          right: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .shortestSide *
                                                              0.15),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          progressDialog.style(
                                                            message: "Transfering please wait.....",
                                                            progressWidget: CircularProgressIndicator(
                                                              backgroundColor: Color(0XFF152562),
                                                            ),
                                                          );
                                                          progressDialog.show();
                                                          int code = await transactionController
                                                              .sendMoneyToMobile();
                                                          if(code == 200){
                                                            progressDialog.hide();
                                                            Navigator.pop(context);
                                                          }
                                                        },
                                                        child: Card(
                                                          elevation: 5.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0XFF39449D),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25),
                                                            ),
                                                            child: Text(
                                                              "Transfer",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).then((value){
                                              Navigator.pop(context);
                                        });
                                      },
                                      child: Card(
                                        elevation: 5.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0XFF39449D),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Text(
                                            "Pay Now",
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
                            )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
