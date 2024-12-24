import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:note_app/Model/Note_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favoriteprovider with ChangeNotifier{
  List<Note_Model> _favoriteNote = [];
  List<Note_Model> get favoriteList => _favoriteNote;
  Favoriteprovider() {
    LoadFavoriteList();
  }
  //load data from the shared preference
  Future<void> LoadFavoriteList() async{
    final preference = await SharedPreferences.getInstance();
    List<String>? jsonString = preference.getStringList('favoriteList');
    if(jsonString != null)
      {
      	 //jsonDecode takes a jsonString and convert into a map object
        _favoriteNote = jsonString.map((e) => Note_Model.fromMap(jsonDecode(e))).toList();
      }
    notifyListeners();
  }
  Future<void> addFavoriteItem(Note_Model note) async{
    _favoriteNote.add(note);
    await saveFavoriteNote();
    notifyListeners();
  }
  //this code is for save the item to the shared preference
  Future<void> saveFavoriteNote() async{
    final preference = await SharedPreferences.getInstance();
          	 //jsonEncode takes a map object and convert into a jsonString object
    List<String>? jsonString = _favoriteNote.map((e) => jsonEncode(e.toMap())).toList();
    preference.setStringList('favoriteList', jsonString);
  }
  //this code is for deleting an item from the favorite list
  Future<void> deletefavItem(int index) async{
    _favoriteNote.removeAt(index);
    await saveFavoriteNote();
    notifyListeners();
  }

}
