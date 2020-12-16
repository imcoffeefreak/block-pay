import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:block_pay/model/cardModel.dart' as c;

class AtmCards extends StatefulWidget {
  c.Data cards;
  AtmCards({c.Data data}){
    if(data!=null){
      cards = data;
    }else{
      data = c.Data();
    }
  }
  @override
  _AtmCardsState createState() => _AtmCardsState();
}

class _AtmCardsState extends State<AtmCards> {
  @override
  Widget build(BuildContext context) {
    print("*********************** ${widget.cards}");
    return Padding(
      padding: EdgeInsets.all(
          MediaQuery.of(context).size.shortestSide * 0.05),
      child: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.8,
        height: MediaQuery.of(context).size.shortestSide * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0XFF05AA44).withOpacity(0.5),
                    Color(0XFF39449D),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "PREMIUM",
                      style: GoogleFonts.inconsolata(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${widget.cards.holderName}",
                      style: GoogleFonts.inconsolata(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "CARD NUMBER",
                          style: GoogleFonts.inconsolata(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          " ${widget.cards.cardNumber}",
                          style: GoogleFonts.inconsolata(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "\u20B9",
                              style: GoogleFonts.inconsolata(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "${widget.cards.amountAvailable}",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${widget.cards.cardType}",
                          style: GoogleFonts.inconsolata(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
