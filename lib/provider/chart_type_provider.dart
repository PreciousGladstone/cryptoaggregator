import 'package:flutter/material.dart';


class ChartProvider extends ChangeNotifier{
 
  String _selectedInterval = "1"; // default interval



  String get selectedInterval => _selectedInterval;

  void setInterval(String interval) {
    if (_selectedInterval == interval) return;
    _selectedInterval = interval;
    notifyListeners();
  }

  



}