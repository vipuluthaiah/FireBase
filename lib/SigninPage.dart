


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String _email,_password;

checkAuthencation()async{
  _auth.onAuthStateChanged.listen((user){
if (user != null) {
  Navigator.pushReplacementNamed(context, "/");
}
  });
}



navigateToSignUpPage()async{
    Navigator.pushReplacementNamed(context, "/SignUpPage");
}


@override
void initState(){
super.initState();
this.checkAuthencation();
}


signin()async{
if (_formKey.currentState.validate()) {
  _formKey.currentState.save();

  try {
    FirebaseUser user = await _auth.signInWithEmailAndPassword(
      email: _email,
       password: _password);
  } catch (e) {
showerror(e.message);
  }
}
}

showerror(String message)async{
showDialog(
  context: context,
  builder: (BuildContext context){
    return AlertDialog(
 title: Text("Error"),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text("OK"),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
  
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("SIGN IN"),
centerTitle: true,
backgroundColor:Colors.black,
),

body: Container(
  child: Center(
    child: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
          child: Image(image:AssetImage("assets/kk.png"),
          width: 100.0,
          height: 100.0,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key:_formKey,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top:10.0),
child: TextFormField(
  validator: (input){
    if (input.isEmpty) {
      return 'Provide An Email Firts';
    }
  },

  decoration: InputDecoration(
    labelText: 'Email',
    border:OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  ),
  onSaved: (input) => _email = input,
),
                
                ),
            // Password Text Box
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.length < 6) {
                              return 'Provide a Password which should have 6 character atleast.';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => _password = input,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 20.0, 0.0, 15.0),
                        child: RaisedButton(
                          padding:
                              EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          onPressed: signin,
                          child: Text(
                            'Sign In',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToSignUpPage,
                        child: Text(
                          'Dont have an account? Sign Up',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




























// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class SignInPage extends StatefulWidget {
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GlobalKey<FormState> _formState = GlobalKey<FormState>();


// String _email,_password;


// checkAuthencation()async{
//   _auth.onAuthStateChanged.listen((user)async{
// if (user!=null) {
//   Navigator.pushReplacementNamed(context, "/");
// }
//   });
// }
// navigatetoSignUpPage(){
//   Navigator.pushReplacementNamed(context, "/SignUpPage");
// }

//   @override
//   void initState(){
//     super.initState();
//     this.checkAuthencation();
//   }


//   showError(String errormessage){
//     showDialog(

//   context: context,
//   builder: (BuildContext context){
//     return AlertDialog(
//       title: Text("Error"),
//       content: Text(errormessage),
//       actions: <Widget>[
//         FlatButton(
//           child: Text("OK"),
//           onPressed: (){
//             Navigator.of(context).pop();
//           },
//         )
//       ],
//     );
//   }

//     );
//   }



// void signin()async{
//   if (_formState.currentState.validate()) {
//     _formState.currentState.save();
    


//     try {
//       FirebaseUser user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
   
//     } catch (e) {
//       showError(e.message);
//     }
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
// appBar: AppBar(
//   title: Text("SIGN IN"),
// centerTitle: true,
// backgroundColor:Colors.black,
// ),

// body: Container(
//   child: Center(
//     child: ListView(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 20.0),
//           child: Image(image:AssetImage("assets/kk.png"),
//           width: 100.0,
//           height: 100.0,
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(16.0),
//           child: Form(
//             key: _formState,
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.only(top:10.0),
// child: TextFormField(
//   validator: (input){
//     if (input.isEmpty) {
//       return 'Provide An Email Firts';
//     }
//   },

//   decoration: InputDecoration(
//     labelText: 'Email',
//     border:OutlineInputBorder(
//       borderRadius: BorderRadius.circular(5.0),
//     ),
//   ),
//   onSaved: (input) => _email = input,
// ),
                
//                 ),
//             // Password Text Box
//                       Container(
//                         padding: EdgeInsets.only(top: 20.0),
//                         child: TextFormField(
//                           validator: (input) {
//                             if (input.length < 6) {
//                               return 'Provide a Password which should have 6 character atleast.';
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                           ),
//                           onSaved: (input) => _password = input,
//                           obscureText: true,
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(0, 20.0, 0.0, 15.0),
//                         child: RaisedButton(
//                           padding:
//                               EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
//                           color: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(6.0),
//                           ),
//                           onPressed: signin,
//                           child: Text(
//                             'Sign In',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20.0),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: navigatetoSignUpPage,
//                         child: Text(
//                           'Dont have an account? Sign Up',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 15.0, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
