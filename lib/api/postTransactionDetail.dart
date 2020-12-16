import 'dart:convert';

import 'package:http/http.dart' as http;

/// json({"name":"Subramanya"})   ---> "{"name":"Subramanya"}" 


class PostTransactionDetails {

  static postTransactionDetails(Map<String,dynamic> transaction) async {
    try{
      http.Request request = http.Request("POST", Uri.parse("https://block-chain-api.herokuapp.com/transaction"));
      request.body = json.encode(transaction);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      http.StreamedResponse response = await request.send();
      switch(response.statusCode){
        case 200:
          return 200;
        case 400:
          return 400;
        case 500:
          return 500;
      }
    }catch(error){

    }
  }
}