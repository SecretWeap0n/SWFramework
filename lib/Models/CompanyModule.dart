import 'Module.dart';
import 'SWModulePermitions.dart';

class CompanyModule{
  String id="";
  String moduleId="";
  Module module=Module();
  int order=0;
  bool enabled=true;
  String overrideLabel="";
  String overrideIcon="";

  SWModulePermitions permissions=SWModulePermitions();

  String get label => overrideLabel.isNotEmpty?overrideLabel:module.name;
  String get icon => overrideIcon.isNotEmpty?overrideIcon:module.icon;

  CompanyModule();

  CompanyModule.fromDocument(String id,data) {
    this.id=id;
    moduleId=data["moduleId"]??'';
    order=data["order"]??0;
    enabled=data["enabled"]??true;
    overrideLabel=data["overrideLabel"]??'';
    overrideIcon=data["overrideIcon"]??'';
    permissions=data["permissions"]!=null?SetPermitions(data["permissions"]):SWModulePermitions();
  }

  SWModulePermitions SetPermitions(Map<String,dynamic> data){
    var permitions=SWModulePermitions();
    for (var key in data.keys) {
      permitions.SetPermition(key, Map<String,bool>.from(data[key]));
    }
    return permitions;
  }

  toJson() {
    return {
      "moduleId": moduleId,
      "order": order,
      "enabled": enabled,
      "overrideLabel": overrideLabel,
      "overrideIcon": overrideIcon,
      "permissions": permissions.ToJson(),
    };
  }
}