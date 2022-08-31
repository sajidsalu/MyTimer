import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc {

  final _selectedIndex = BehaviorSubject<int>.seeded(0);
  Stream<int> get selectedIndexStream => _selectedIndex.stream;
  get selectedIndex => _selectedIndex;

  void setIndex(index){
    selectedIndex.add(index);
  }
}