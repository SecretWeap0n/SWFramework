class ModuleModel{
  List<ModuleModelVariable> varibles=[];

  
}

class ModuleModelVariable{
  String name="";
  ModuleModelVaribleType type=ModuleModelVaribleType.String;

  //constructor
  ModuleModelVarible(){
    name="New Variable";
    type=ModuleModelVaribleType.String;
  }
}

enum ModuleModelVaribleType{
  String,
  Int,
  Double,
  Bool,
  DateTime,
}