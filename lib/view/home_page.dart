import 'package:block_pay/controller/homePageController.dart';
import 'package:block_pay/view/addCard.dart';
import 'package:block_pay/view/common/pin_page.dart';
import 'package:block_pay/view/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageController>(
      create: (context) => HomePageController(),
      child: Scaffold(
        floatingActionButton: Consumer<HomePageController>(
            builder: (context, homePageController, _) {
          return FloatingActionButton(
            backgroundColor: Color(0XFF39449D),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChangeNotifierProvider<HomePageController>.value(
                    value: homePageController,
                    child: AddCard(),
                  ),
                ),
              );
            },
            child: Icon(
              Icons.credit_card,
              color: Colors.white,
            ),
          );
        }),
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
              child: Consumer<HomePageController>(
                  builder: (context, homePageController, _) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.shortestSide * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(0XFF152562),
                              action: SnackBarAction(
                                label: "Close",
                                onPressed: () {
                                  Scaffold.of(context).hideCurrentSnackBar();
                                },
                              ),
                              duration: Duration(hours: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              content: Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      homePageController.signOut();
                                      Navigator.pushReplacementNamed(context, "/auth");
                                    },
                                    label: Text(
                                      "Logout",
                                      style: GoogleFonts.breeSerif(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.shortestSide *
                                    0.1,
                                top: MediaQuery.of(context).size.shortestSide *
                                    0.1,
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: (homePageController.user != "")
                                    ? Text(
                                        "${homePageController.user[0].toUpperCase()}")
                                    : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.shortestSide *
                                    0.05,
                                top: MediaQuery.of(context).size.shortestSide *
                                    0.1,
                              ),
                              child: Text(
                                "Hi, ${homePageController.user}",
                                style: GoogleFonts.breeSerif(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right:
                              MediaQuery.of(context).size.shortestSide * 0.05,
                          top: MediaQuery.of(context).size.shortestSide * 0.1,
                        ),
                        child: Stack(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              right: 28,
                              top: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text("  "),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Consumer<HomePageController>(
                    builder: (context, homePageController, _) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.shortestSide * 0.05),
                          child: (homePageController.cardDetails.isNotEmpty && homePageController.cardDetails.length>0)
                              ? Container(
                            width: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.8,
                            height: MediaQuery.of(context)
                                .size
                                .shortestSide *
                                0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color(0XFF05AA44)
                                            .withOpacity(0.5),
                                        Color(0XFF39449D),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "PREMIUM",
                                          style:
                                          GoogleFonts.inconsolata(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${homePageController.cardDetails.first.data.holderName}",
                                          style:
                                          GoogleFonts.inconsolata(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              "CARD NUMBER",
                                              style: GoogleFonts
                                                  .inconsolata(
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              "**** **** **** ${homePageController.cardDetails.first.data.cardNumber.substring(15)}",
                                              style: GoogleFonts
                                                  .inconsolata(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "\u20B9",
                                                  style: GoogleFonts
                                                      .inconsolata(
                                                    color:
                                                    Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  "${homePageController.cardDetails.first.data.amountAvailable}",
                                                  style: GoogleFonts
                                                      .roboto(
                                                    color:
                                                    Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${homePageController.cardDetails.first.data.cardType}",
                                              style: GoogleFonts
                                                  .inconsolata(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                  ),
                                ),
                              ],
                            ),
                          )
                              : LimitedBox(
                                  maxWidth:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.8,
                                  maxHeight:
                                      MediaQuery.of(context).size.shortestSide *
                                          0.5,
                                  child: Center(
                                    child: Text(
                                      "No Card Details Found!",
                                      style: GoogleFonts.breeSerif(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Activity",
                              style: GoogleFonts.breeSerif(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Consumer<HomePageController>(
                            builder: (context, homePageController, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PinPage(
                                        page: PAGES.PAYMENT,
                                        model:
                                            homePageController.cardDetails,
                                        tModel:
                                            homePageController.transaction,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 2.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    height: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          decoration: BoxDecoration(
                                            color: Color(0XFF152562),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Transform.rotate(
                                            angle: -180 / 4,
                                            child: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Transfer",
                                          style: GoogleFonts.robotoCondensed(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PinPage(
                                        page: PAGES.BALANCE,
                                        model:
                                            homePageController.cardDetails,
                                        tModel:
                                            homePageController.transaction,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 2.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    height: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          decoration: BoxDecoration(
                                            color: Color(0XFF152562),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.account_balance,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Balance",
                                          style: GoogleFonts.robotoCondensed(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PinPage(
                                        page: PAGES.HISTORY,
                                        model:
                                            homePageController.cardDetails,
                                        tModel:
                                            homePageController.transaction,
                                      ),
                                    ),
                                  ).then((value){
                                    homePageController.getTransactionDetails();
                                    homePageController.getAuthenticatedUser();
                                  });
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 2.0,
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    height: MediaQuery.of(context)
                                            .size
                                            .shortestSide *
                                        0.3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide *
                                              0.15,
                                          decoration: BoxDecoration(
                                            color: Color(0XFF152562),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Icon(
                                            Icons.history,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "History",
                                          style: GoogleFonts.robotoCondensed(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Recent Transactions",
                              style: GoogleFonts.breeSerif(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        (homePageController.transaction.isNotEmpty &&
                                homePageController
                                        .transaction.length >0
                                    )
                            ? ListView.separated(
                                physics: ClampingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                padding: EdgeInsets.all(8.0),
                                shrinkWrap: true,
                                itemCount: homePageController
                                        .transaction.length
                                    ,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height: MediaQuery.of(context)
                                              .size
                                              .shortestSide *
                                          0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "${homePageController.transaction[index].timestamp.split(' ')[1]}",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${homePageController.transaction[index].timestamp.split(' ')[2]}/${homePageController.transaction[index].timestamp.split(' ')[1]}/${homePageController.transaction[index].timestamp.split(' ')[3]}",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "Status",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                (homePageController
                                                        .transaction[index]
                                                        .data
                                                        .isSuccess)
                                                    ? "Success"
                                                    : "Failure",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 16,
                                                  color: (homePageController
                                                          .transaction[index]
                                                          .data
                                                          .isSuccess)
                                                      ? Colors.blue
                                                      : Colors.red,
                                                ),
                                              ),
                                              Text(
                                                "Amount \u20B9 ${homePageController.transaction[index].data.amount}",
                                                style:
                                                    GoogleFonts.robotoCondensed(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20.0, right: 20.0),
                                child: Center(
                                  child: Text(
                                    "No recent transactions!",
                                    style: GoogleFonts.breeSerif(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
