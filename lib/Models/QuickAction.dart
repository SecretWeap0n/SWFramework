import 'package:flutter/material.dart';

class QuickAction{
  String title;
  IconData icon;
  Function() action;

  QuickAction({required this.title, required this.icon,required this.action});
}