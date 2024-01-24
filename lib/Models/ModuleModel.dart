class ModuleModel{
  List<ModuleModelVariable> varibles=[];

  ModuleModel();

  Map<String, dynamic> toJson() {
    return {
      "varibles": varibles.map((e) => e.toJson()).toList(),
    };
  }

  ModuleModel.fromDocument(data) {
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
  ModuleModelVariable();

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