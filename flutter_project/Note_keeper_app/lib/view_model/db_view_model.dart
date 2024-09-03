import 'package:fahad_note_app/db_helper/db_helper.dart';
import 'package:flutter/material.dart';

import '../model/Note_Model.dart';
class DB_View_Model with ChangeNotifier{
 static bool _editMode = true;
  bool get editMode => _editMode;

  void set Edit(bool val){
    _editMode = val;
    notifyListeners();
  }
  static List<Note_Model> _notes = [];

  List<Note_Model> get notes => _notes;

  // retrieve all the note from the database and store into the _notes list
  void fetchAllData() async{
    _notes = await Note_DB.getAllData();
    notifyListeners();
  }
  // insert a note to the database
   Future<int> insertData(Note_Model note_model) async{
    int insertedId = await Note_DB.insertData(note_model);
    fetchAllData();
    return insertedId;
  }
  // delete a note from the database
   Future<int> deleteData(Note_Model note_model) async{
    int deleted = await Note_DB.deleteData(note_model);
    fetchAllData();
    return deleted;

  }
  // update an existing note to the database
  Future<int> updateData(Note_Model note_model) async{
    int updateId = await Note_DB.updatData(note_model);
    fetchAllData();
    return updateId;
  }
  // get a single note from the database
  Future<Note_Model?> getSingleRow(Note_Model note_model) async{
    Note_Model? noteRow = await Note_DB.singleData(note_model);
    return noteRow;
  }

}