import 'package:block_pay/controller/balanceController.dart';
import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/view/atmCards/atmCards.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  List<CardModel>? cardModel;

  BalancePage({List<CardModel>? model}) {
    if (model != null) {
      cardModel = model;
    } else {
      model = [];
    }
  }

  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  int currentPageValue = 0;

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BalanceController>(
      create: (context) => BalanceController(cardData: widget.cardModel!.first.data),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
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
                            "Balance",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Consumer<BalanceController>(
                    builder: (context, balanceController,_) {
                      return Container(
                        width: MediaQuery.of(context).size.shortestSide * 0.9,
                        height: MediaQuery.of(context).size.shortestSide * 0.5,
                        child: Stack(
                          children: <Widget>[
                            PageView.builder(
                              itemCount: widget.cardModel!.length,
                            itemBuilder: (context, index) {
                              return AtmCards(
                                data: widget.cardModel![index].data,
                              );
                            },
                            onPageChanged: (int page) {
                              getChangedPageAndMoveBar(page);
                              balanceController.changeCard(model: widget.cardModel![page].data);
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          for (int i = 0; i < widget.cardModel!.length; i++)
                                          if (i == currentPageValue) ...[circleBar(true)] else circleBar(false),
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
                    }
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.shortestSide*0.05,left: MediaQuery.of(context).size.shortestSide*0.05,),
                      child: Text(
                        "Available Balance",
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.shortestSide*0.15,left: MediaQuery.of(context).size.shortestSide*0.25),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "\u20B9",
                            style: GoogleFonts.inconsolata(
                              color: Colors.black,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Consumer<BalanceController>(
                            builder: (context, balanceController,_) {
                              return Text(
                                "${balanceController.cardData!.amountAvailable}",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            );
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
