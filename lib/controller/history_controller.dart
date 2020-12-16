import 'package:block_pay/api/getTransactionDetail.dart';
import 'package:block_pay/api/postCardDetails.dart';
import 'package:block_pay/model/cardModel.dart';
import 'package:block_pay/model/transactionModel.dart';
import 'package:block_pay/view/maskControllerClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:block_pay/model/cardModel.dart' as c;
import 'package:google_sign_in/google_sign_in.dart';



class HistoryController extends ChangeNotifier{
  List<CardModel> cardDetails = [];
  List<TransactionModel> transaction = [];
  FirebaseUser firebaseUser;
  FirebaseAuth auth;
  HistoryController(){
    auth = FirebaseAuth.instance;
    getAuthenticatedUser();
    getTransactionDetails();
  }

  void getAuthenticatedUser() async {
    try{
      firebaseUser = await auth.currentUser();
      notifyListeners();
    }catch(e){

    }
  }

  getTransactionDetails() async {
    try {
      transaction.clear();
      cardDetails.clear();
      var transactionDetails =
      await GetTransactionDetails.getTransactionDetails();
      print(transactionDetails);
      transactionDetails['chain'].forEach((data){
        if(data['userId'] == firebaseUser.uid){
          transaction.add(TransactionModel.fromJson(data,firebaseUser.uid));
        }
      });
      transactionDetails['card'].forEach((data){
        if(data['userId'] == firebaseUser.uid){
          cardDetails.add(CardModel.fromJson(data,firebaseUser.uid));
        }
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}