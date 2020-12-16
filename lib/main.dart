import 'package:block_pay/generatedRoutes.dart';
import 'package:block_pay/view/authentication.dart';
import 'package:block_pay/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Block-Pay',
      theme: ThemeData(
        primaryColor: Color(0XFFB3C7DF),
        scaffoldBackgroundColor: Color(0XFF152562),
        textTheme: TextTheme(
          headline1: GoogleFonts.inconsolata(
            fontSize: 20,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0XFF152562),
          iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor:Color(0XFFB3C7DF),
        )
      ),
//      home: Transition(),
      initialRoute: "/check",
      onGenerateRoute: GeneratedRoutes.generateRoute,
    );
  }
}


class Transition extends StatefulWidget {
  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  SharedPreferences sharedPreferences;
  FirebaseAuth auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    checkUser();
  }

  checkUser() async {
    try{
      int count = 0;
      sharedPreferences = await SharedPreferences.getInstance();
      count = sharedPreferences.getInt("count");
      var user = await auth.currentUser();
      if(count==null){
        Navigator.pushReplacementNamed(context, "/auth");
      }else{
        if(user!=null){
          sharedPreferences.setInt("count", count+1);
          Navigator.pushReplacementNamed(context, "/");
        }else{
          Navigator.pushReplacementNamed(context, "/auth");
        }
      }
    }catch(error){
      print(error);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

