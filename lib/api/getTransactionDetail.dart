import 'dart:convert';

import 'package:http/http.dart' as http;


class GetTransactionDetails {

  static getTransactionDetails() async {
    try{

      http.Request request = http.Request("GET", Uri.parse("https://block-chain-api.herokuapp.com/history"));
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      http.StreamedResponse response = await request.send();
      switch(response.statusCode){
        case 200:
          var data = await utf8.decodeStream(response.stream);
          return json.decode(data);
        case 400:
          var data = await utf8.decodeStream(response.stream);
          return json.decode(data);
        case 500:
          var data = await utf8.decodeStream(response.stream);
          return json.decode(data);
      }
    }catch(error){

    }
  }
}