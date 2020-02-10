import 'package:flutter/material.dart';
import 'SigninPage.dart';
import 'SignupPage.dart';
import 'package:google_auth/todo/lib/screens/note_list.dart';

// import 'homePage.dart';
void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "FireBase",
    debugShowCheckedModeBanner: true,

    home:NoteList(),
    routes: <String,WidgetBuilder>{
      "/SignInPage":(BuildContext context) => SignInPage(),
      "/SignUpPage":(BuildContext context) => SignUpPage(),

    }
    );
    
  }
}
