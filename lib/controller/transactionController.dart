import 'package:block_pay/api/postTransactionDetail.dart';
import 'package:block_pay/model/cardModel.dart' as card;
import 'package:block_pay/model/transactionModel.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TransactionController extends ChangeNotifier {
  TextEditingController? accountNumber;
  TextEditingController? ifscCode;
  TextEditingController? receiverName;
  TextEditingController? mobileNumber;
  TextEditingController? amount;
  card.Data? cardData;
  bool isTransfered = false;
  FirebaseAuth? auth;

  TransactionController({@required card.Data? card}) {
    auth = FirebaseAuth.instance;
    accountNumber = TextEditingController();
    ifscCode = TextEditingController();
    receiverName = TextEditingController();
    mobileNumber = TextEditingController();
    amount = TextEditingController();
    changeCardDetails(card: card!);
  }

  sendMoneyToAccount() async {
    try {
      var firebaseUser = auth!.currentUser;
      var transaction = model.Data(
        amount: int.parse(amount!.text),
        sentFrom: "${cardData!.cardNumber}",
        sentTo: "${accountNumber!.text}",
        ifsc: "${ifscCode!.text}",
        holderName: "${receiverName!.text}",
        userId: firebaseUser!.uid,
        isSuccess: true,
        isFailure: false,
      );
      int statusCode = await PostTransactionDetails.postTransactionDetails(
        transaction.toJson(),
      );
      if (statusCode == 200) {
        isTransfered = true;
        clearAllController();
        notifyListeners();
        return 200;
      }
    } catch (e) {}
  }

  sendMoneyToMobile() async {
    try {
      var firebaseUser = auth!.currentUser;
      var transaction = model.Data(
        amount: int.parse(amount!.text),
        sentFrom: "${cardData!.cardNumber}",
        sentTo: "${mobileNumber!.text}",
        ifsc: "",
        holderName: "",
        userId: firebaseUser!.uid,
        isSuccess: true,
        isFailure: false,
      );
      int statusCode =
          await PostTransactionDetails.postTransactionDetails(transaction.toJson());
      if (statusCode == 200) {
        isTransfered = true;
        clearAllController();
        notifyListeners();
      }
    } catch (e) {}
  }

  changeCardDetails({card.Data? card}) {
    if (card != null) {
      cardData = card;
    }
    notifyListeners();
  }

  clearAllController() {
    accountNumber!.clear();
    ifscCode!.clear();
    receiverName!.clear();
    mobileNumber!.clear();
    amount!.clear();
  }
}
