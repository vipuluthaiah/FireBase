import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:three_things_today/models/note.dart';
// import 'package:three_things_today/utils/database_helper.dart';
// import 'package:three_things_today/screens/note_detail.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'package:todo/models/note.dart';
// import 'package:todo/utils/database_helper.dart';
// import 'package:todo/screens/note_detail.dart';
import '../models/note.dart';
import '../utils/database_helper.dart';
import '../screens/note_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';



class NoteList extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
return NoteListState();
  }
  

}
class NoteListState extends State<NoteList>{
  final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
  bool isSignedIn = false;

    checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "/SigninPage");
      }
    });
  }
  getUser() async {
    FirebaseUser firebaseUser = await _auth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isSignedIn = true;
      });
    }
  }

    @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }



  
DatabaseHelper databaseHelper = DatabaseHelper();
List<Note> noteList;
int count = 0;
  @override

Widget build(BuildContext context){
  if (noteList == null) {
    noteList = List<Note>();
    updateListView();
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('Three Things Today'),
        elevation: 5.0,
        backgroundColor: Colors.black,
      ),
      body: getNoteList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetails(Note('', 2, ''), 'Add Note');
        },
        tooltip: 'Add Tasks',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

  
}

ListView getNoteList(){

    return ListView.builder(
      itemCount: count,
    itemBuilder: (BuildContext context,int position){
return Card(
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0)
),
color: Colors.black,
elevation: 5.0,
child: ListTile(
  leading: CircleAvatar(
    backgroundImage: AssetImage("imahes/s1.gif"
    ),
    backgroundColor: Colors.transparent,
    radius: 32.0,
  ),
  title: Text(
    this.noteList[position].title,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 25.0
    ),
  ),
  subtitle: Text(
    this.noteList[position].date,
    style: TextStyle(color: Colors.white),
  ),
  onLongPress: (){
                _delete(context, noteList[position]);

  },
trailing: GestureDetector(
  child: Icon(
    Icons.remove_circle,
    color: Colors.white,
    
  ),
  onTap:(){
  debugPrint("ListTile Tapped");
              navigateToDetails(this.noteList[position], 'Edit Things');
  }
)
),


);
    },
    );
  }
//  Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

void _delete(BuildContext context,Note note) async{
  int result = await databaseHelper.deleteNote(note.id);
  if (result !=0) {
    _showSnackBar(context ,"Your List Deleted Succesfully..");
    updateListView();
  }
}

void _showSnackBar(BuildContext context,String message){
  final snackbar = SnackBar(content: Text(message));
  Scaffold.of(context).showSnackBar(snackbar);
}


void navigateToDetails(Note note,String title)async{
  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
    return NoteDetail(note,title);
  }));
  if (result == true) {
    updateListView();
  }

}

void updateListView(){
final Future<Database> dbFuture = databaseHelper.initializedatabase();
dbFuture.then((database){
Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
noteListFuture.then((noteList){
  setState(() {
    this.noteList = noteList;
    this.count = noteList.length;
  });
});
});
  

}
}

class NoteDetails {
}