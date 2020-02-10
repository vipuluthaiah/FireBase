import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:three_things_today/models/note.dart';
// import 'package:todo/models/note.dart';
import '../models/note.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;


  String noteTable = 'note_table';
  String colId ='id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority ='priority';


  DatabaseHelper._createInstance();


  factory DatabaseHelper(){
    if (_databaseHelper ==null) {
      _databaseHelper= DatabaseHelper._createInstance();
    }
    return DatabaseHelper();
  }

Future<Database> get database async {
  if (_database == null) {
    _database = await initializedatabase();
  }
  return database;
}

Future<Database> initializedatabase()async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path = directory.path + 'notes,db';

  var notesdatabase = await openDatabase(path,version: 1,onCreate: _createDb);
  return notesdatabase;
}


void _createDb(Database db,int newVersion )async{
  await db.execute(
     'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)'
  );


// Future<List<Map<String,dynamic>>> getNoteMapList()async{
//   Database db = await this.database;
//   var result  = await db.query(noteTable,orderBy: '$colPriority ASC');
//   return result;
// }

}
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }
   Future<int> insertNote(Note note)async{
  Database db = await this.database;
     var result = await db.insert(noteTable, note.toMap());
     return result;
   }

   Future<int>upDateNote(Note note)async{
  Database db = await this.database;
 var result = await db.update(noteTable, note.toMap(),
 where: '$colId = ? ',whereArgs: [note.id]
 );
 return result;
   }
   


   Future<int> deleteNote(int id)async{
  Database db = await this.database;
var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
return result;
   }


   Future<int> getCount()async{
  Database db = await this.database;
List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT(*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
 return result;
   }



  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count =
        noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}