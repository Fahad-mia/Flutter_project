import 'package:fahad_note_app/view/home_sceen.dart';
import 'package:fahad_note_app/view_model/db_view_model.dart';
import 'package:fahad_note_app/view_model/favorite_ViewModel.dart';
import 'package:fahad_note_app/view_model/loading_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyMaterial());
}

class MyMaterial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Loading_view_model()),
        ChangeNotifierProvider(create: (_) => DB_View_Model()),
        ChangeNotifierProvider(create: (_) => Favoriteprovider())
      ],
      child: MaterialApp(title: 'final note app', home: Home_Screen()),
    );
  }
}