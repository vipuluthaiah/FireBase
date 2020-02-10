

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();


String _email,_password, _name;

checkauthencation()async{
  _auth.onAuthStateChanged.listen((user){
    if (user == null) {
     Navigator.pushReplacementNamed(context, "/");
    }
  });
}


navigatetosignnpage()async{
  Navigator.pushReplacementNamed(context, "/SignInPage");
}

  @override
void initState(){
  super.initState();
  this.checkauthencation();
}

signup()async{
 if ( _formkey.currentState.validate()) {
   _formkey.currentState.save();


   try {
     FirebaseUser user = await _auth.signInWithEmailAndPassword(
       email: _email, 
       password: _password);

if (user !=null) {
  UserUpdateInfo userupdate =UserUpdateInfo();
  userupdate.displayName =_name;
  user.updateProfile(userupdate);
}

       
   } catch (e) {
     showError(e.errorMessage);
   }
 }
}


  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text('Sign Up'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                child: Image(
                  image: AssetImage("assets/mascot.png"),
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      //Name text Box
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide your real Name';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => _name = input,
                        ),
                      ),
                      //E-mail Text box
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Provide an E-mail.';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onSaved: (input) => _email = input,
                        ),
                      ),
                      //Password Text Box
                      Container(
                        padding: EdgeInsets.only(top: 8.0),
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
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          onPressed: signup,
                          child: Text(
                            'Sign Up',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigatetosignnpage,
                        child: Text(
                          'Already have an Account, Sign In',
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


// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();



// String _name,_email,_password;

// checkAuthencation()async{
//   _auth.onAuthStateChanged.listen((user){
//     if (user != null) {
//       Navigator.pushReplacementNamed(context, "/");
//     }
//   });
// }

// naviagateToSignIn(){
//   Navigator.pushReplacementNamed(context, "/SignInPage");
// }

// void initState(){
//   super.initState();
//   this.checkAuthencation();
// }


// showError(String message){
//   showDialog(context: context,
  
//   builder: (BuildContext context ){
//     return AlertDialog(
//       title: Text("Error"),
//       content: Text(message),
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
  
//   );
// }

// signup()async{
//   if (_formkey.currentState.validate()) {
//     _formkey.currentState.save();

//     try {
//       FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
//        if (user !=null) {
//          UserUpdateInfo updateuser = UserUpdateInfo();
//          updateuser.displayName = _name;
//          user.updateProfile(updateuser);

//        }
//     } catch (e) {
//       showError(e.message);
//     }
//   }
// }






//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5.0,
//         title: Text('Sign Up'),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         child: Center(
//           child: ListView(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
//                 child: Image(
//                   image: AssetImage("assets/logo.png"),
//                   width: 100.0,
//                   height: 100.0,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(15.0),
//                 child: Form(
//                   key: _formkey,
//                   child: Column(
//                     children: <Widget>[
//                       //Name text Box
//                       Container(
//                         padding: EdgeInsets.only(top: 5.0),
//                         child: TextFormField(
//                           validator: (input) {
//                             if (input.isEmpty) {
//                               return 'Provide your real Name';
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Name',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                           ),
//                           onSaved: (input) => _name = input,
//                         ),
//                       ),
//                       //E-mail Text box
//                       Container(
//                         padding: EdgeInsets.only(top: 8.0),
//                         child: TextFormField(
//                           validator: (input) {
//                             if (input.isEmpty) {
//                               return 'Provide an E-mail.';
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                           ),
//                           onSaved: (input) => _email = input,
//                         ),
//                       ),
//                       //Password Text Box
//                       Container(
//                         padding: EdgeInsets.only(top: 8.0),
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
//                           onPressed: signup,
//                           child: Text(
//                             'Sign Up',
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 20.0),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap:naviagateToSignIn,
//                         child: Text(
//                           'Already have an Account, Sign In',
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
