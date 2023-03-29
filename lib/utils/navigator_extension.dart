import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext{
  navigateTo(Widget destination){
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => destination),
    );
  }
  navigateToWithKey(Widget destination,int id){
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}