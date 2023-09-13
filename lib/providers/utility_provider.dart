


import 'package:flutter/material.dart';

class UtilityProvider extends ChangeNotifier{

  int screenId=0;

  updateScreenId(int id){
    screenId=id;
    notifyListeners();
  }
}