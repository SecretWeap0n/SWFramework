
import 'package:flutter/material.dart';
import 'package:sw_framework/Models/ModuleModel.dart';

class Module{
  String id="";
  String name="";
  ModuleModel model=ModuleModel();
  String version="1.0.0";
  String description="";
  String icon="";

  Widget screen=Container();

  List<String> dependencies=[];
  Module();

  Module.fromDocument(String id,data,Widget screen) {
    this.id=id;
    name=data["name"]??'';
    description=data["description"]??'';
    icon=data["icon"];
    version=data["version"]??'1.0.0';
    this.screen=screen;
    dependencies=data["dependencies"] != null ? List<String>.from(data["dependencies"]) : [];
    model=data["model"]!=null?ModuleModel.fromDocument(data["model"]):ModuleModel();
  }

  toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "icon": icon,
      "version": version,
      "dependencies": dependencies,
      "model":model.toJson(),
    };
  }
}