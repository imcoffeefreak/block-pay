import 'package:block_pay/model/cardModel.dart';
import 'package:flutter/foundation.dart';


class BalanceController extends ChangeNotifier{

  Data cardData;

  BalanceController({Data cardData}){
    changeCard(model: cardData);
  }

  changeCard({Data model}){
    if(model!=null){
      cardData = model;
    }
    notifyListeners();
  }

}