import 'package:secretweapon/Platform/CRUD.dart';

class SWModulePermitions{
  Map<String, CRUD> rules={};
  void SetPermition(String key, Map<String,bool> crud) {
    rules[key]=CRUD.fromData(crud);
  }

  ToJson() {
    var json = {};
    for (var key in rules.keys) {
      json[key.toLowerCase()] = rules[key]!.toJson();
    }
    return json;
  }
}