import 'package:flutter/material.dart';
import '../Utils/ColorFromHex.dart';

class LoginSettings{
  String backgroundImage="";
  Color backgroundColor=Colors.black;

  bool googleAuthEnabled=false;
  bool facebookAuthEnabled=false;
  bool appleAuthEnabled=false;

  LoginSettings();
  LoginSettings.fromDocument(data) {
    backgroundImage = data["backgroundImage"]??"";
    backgroundColor = data["backgroundColor"]!=null?getColorFromHex(data["backgroundColor"]):Colors.blue;
    googleAuthEnabled = data["googleAuthEnabled"]??false;
    facebookAuthEnabled = data["facebookAuthEnabled"]??false;
    appleAuthEnabled = data["appleAuthEnabled"]??false;
  }

  toJson() {
    return {
      "backgroundImage": backgroundImage,
      "backgroundColor": backgroundColor.value.toRadixString(16),
      "googleAuthEnabled": googleAuthEnabled,
      "facebookAuthEnabled": facebookAuthEnabled,
      "appleAuthEnabled": appleAuthEnabled,
    };
  }
}