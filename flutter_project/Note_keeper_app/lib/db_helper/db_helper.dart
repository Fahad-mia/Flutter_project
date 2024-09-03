import 'dart:async';

import 'package:fahad_note_app/model/Note_Model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Note_DB {
  static Database? _database;
  // get the database
  static Future<Database> get DB async {
    if (_database != null) _database;
    _database = await _InitializieDB();
    return _database!;
  }
  // for initializing the database to the disk
  static Future<Database> _InitializieDB() async {
    final dir = await getDatabasesPath();
    final path = join(dir, '_CreateDb.db');
    return openDatabase(path, version: 1, onCreate: _CreateDb);
  }
//for creating the table
  static FutureOr<void> _CreateDb(Database db, int version) async {
    await db.execute('''CREATE TABLE IF NOT EXISTS note_table(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    date TEXT, 
    title TEXT,
    description TEXT
    )
    ''');
  }
  //method for getting all the rows from the database
  static Future<List<Note_Model>> getAllData() async{
    final get_instance = await DB;
    List<Map<String, dynamic>> result = await get_instance.query('note_table');
     return result.map((e) => Note_Model.fromMap(e)).toList();
  }
  // get single row based on wthe id
  static Future<Note_Model?> singleData(Note_Model note_model)async{
    final get_instanceDb = await DB;
    var map= await get_instanceDb.query('note_table', where: ' id = ?',whereArgs: [note_model.id], limit: 1);
    return map.isNotEmpty ? Note_Model.fromMap(map.first) : null;
  }
  // for inserting the data to the database
  static Future<int> insertData(Note_Model note_model) async{
    final get_instance = await DB;
    note_model.setDate();
     return await get_instance.insert('note_table', note_model.toMap());
     print("inserted");
  }
  // delete the item
static Future<int> deleteData(Note_Model note_model) async {
    final get_instance = await DB;
    int result = await get_instance.delete('note_table', where: ' id = ?', whereArgs: [note_model.id]);
    return result;
}
// for updating the existing item
static Future<int> updatData(Note_Model note_model) async {
    note_model.setDate();
    final get_instance = await DB;
    int result = await get_instance.update('note_table',note_model.toMap(), where: ' id = ?', whereArgs: [note_model.id]);
    return result;
}
}