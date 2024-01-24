class ModuleModel{
  List<ModuleModelVariable> varibles=[];

  Map<String, dynamic> toJson() {
    return {
      "varibles": varibles.map((e) => e.toJson()).toList(),
    };
  }

  void fromDocument(data) {
    varibles.clear();
    for (var _varible in data["varibles"]) {
      var varible = ModuleModelVariable.fromDocument(_varible["name"],_varible);
      varibles.add(varible);
    }
  }
}

class ModuleModelVariable{
  String name="";
  ModuleModelVaribleType type=ModuleModelVaribleType.String;

  //constructor
  ModuleModelVarible(){
    name="New Variable";
    type=ModuleModelVaribleType.String;
  }

  ModuleModelVariable.fromDocument(String name,Map<String,dynamic> data){
    this.name=name;
    this.type=ModuleModelVaribleType.values.firstWhere((element) => element.toString()==data["type"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "type": type.toString(),
    };
  }
}

enum ModuleModelVaribleType{
  String,
  Int,
  Double,
  Bool,
  DateTime,
}