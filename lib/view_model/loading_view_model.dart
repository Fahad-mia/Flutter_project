import 'package:flutter/material.dart';

class Loading_view_model extends ChangeNotifier {
  String _content = 'Loading';
  String get content => _content;
  void setContent(String cont){
    _content = cont;
  }
  bool _loadingState = true;
  bool get loading => _loadingState;

  void setLoading(bool load) {
    _loadingState = load;
    notifyListeners();
  }
}
