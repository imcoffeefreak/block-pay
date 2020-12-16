import 'dart:convert';

import 'package:http/http.dart' as http;


class PostCardDetails {

  static postCardDetails(Map<String,dynamic> card) async {
    try{
      http.Request request = http.Request("POST", Uri.parse("https://block-chain-api.herokuapp.com/card"));
      request.body = json.encode(card);
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      http.StreamedResponse response = await request.send();
      switch(response.statusCode){
        case 200:
          var data = await utf8.decodeStream(response.stream);
          return 200;
        case 400:
          var data = await utf8.decodeStream(response.stream);
          return 400;
        case 500:
          var data = await utf8.decodeStream(response.stream);
          return 500;
      }
    }catch(error){
      print(error);
    }
  }
}