import 'package:block_pay/controller/history_controller.dart';
import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/model/transactionModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  List<TransactionModel> card;

  HistoryPage({@required List<TransactionModel> model}) {
    if (model != null) {
      card = model;
    } else {
      model = [];
    }
  }

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryController>(
      create: (context) =>HistoryController(),
      child: Consumer<HistoryController>(
        builder: (context, historyController,_) {
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
                            "History",
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
                    child: (historyController.transaction.length > 0)
                        ? ListView.builder(
                            itemCount: widget.card.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 8.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: ListTile(
                                    dense: true,
                                    leading: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.shortestSide *
                                              0.1,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0XFF152562),
                                            Color(0XFF39449D),
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        "${index + 1}",
                                        style: GoogleFonts.breeSerif(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${widget.card[index].data.holderName}",
                                      style: GoogleFonts.lato(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "${widget.card[index].hash}",
                                      style: GoogleFonts.roboto(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "No Transaction History",
                              style: GoogleFonts.breeSerif(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
