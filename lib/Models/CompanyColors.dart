import 'package:flutter/material.dart';
import '../Utils/ColorFromHex.dart';

class CompanyColors{
  Color primary=Color(0xFF161616);
  Color secondary=Color(0xFF161616);
  Color accent=Color(0xFF161616);
  Color background=Color(0xFF161616);
  Color text=Color(0xFF161616);

  CompanyColors();

  CompanyColors.fromDocument(data) {
    primary = data["primary"]==null?Colors.black:getColorFromHex(data["primary"]);
    secondary =  data["secondary"]==null?Colors.blue:getColorFromHex(data["secondary"]);
    accent = data["accent"]==null?Colors.red:getColorFromHex(data["accent"]);
    background = data["background"]==null?Colors.white:getColorFromHex(data["background"]);
    text = data["text"]==null?Colors.black:getColorFromHex(data["text"]);
  }

  toJson() {
    return {
      "primary": primary.value.toRadixString(16),
      "secondary": secondary.value.toRadixString(16),
      "accent": accent.value.toRadixString(16),
      'background': background.value.toRadixString(16),
      'text': text.value.toRadixString(16),
    };
  }
}