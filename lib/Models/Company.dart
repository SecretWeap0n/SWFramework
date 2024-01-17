import 'CompanyColors.dart';
import 'CompanyModule.dart';
import 'LoginSettings.dart';

class Company {
  String id = "";
  String name = "";
  String image = "";
  CompanyColors colors = CompanyColors();
  LoginSettings loginSettings = LoginSettings();
  List<CompanyModule> modules = [];

  //created date
  DateTime createdDate = DateTime.now();

  List<String> admins = [];
  Map<String, String> users = {};
  List<String> roles = [];

  bool enableNewAccounts = false;

  //get modules enabled
  List<CompanyModule> get enabledModules => modules.where((element) => element.enabled).toList();

  Company();

  Company.fromDocument(String id, Map<String, dynamic> data) {
    this.id = id;
    this.name = data["name"] ?? '';
    this.image = data["image"] ?? "";
    this.colors = data["colors"] != null ? CompanyColors.fromDocument(data["colors"]) : CompanyColors();
    this.loginSettings =
        data["loginSettings"] != null ? LoginSettings.fromDocument(data["loginSettings"]) : LoginSettings();
    this.modules = data["modules"] != null ? LoadModules(data["modules"]) : [];
    this.createdDate = data["createdDate"] != null ? data["createdDate"].toDate() : DateTime.now();
    this.users = data["users"] != null ? Map<String, String>.from(data["users"]) : {};
    this.roles = data["roles"] != null ? List<String>.from(data["roles"]) : [];
    this.admins = data["admins"] != null ? List<String>.from(data["admins"]) : [];
    this.enableNewAccounts = data["enableNewAccounts"] ?? true;
  }

  LoadModules(List<dynamic> data) {
    modules.clear();
    for (var _module in data) {
      var module = CompanyModule.fromDocument(_module["moduleId"], _module);
      modules.add(module);
    }

    modules.sort((a, b) => a.order.compareTo(b.order));
    return modules;
  }

  toJson() {
    return {
      "name": name,
      "image": image,
      "colors": colors.toJson(),
      "loginSettings": loginSettings.toJson(),
      "users": users,
      "roles": roles,
      "admins": admins,
      "createdDate": createdDate,
      "enableNewAccounts": enableNewAccounts,
      "modules": modules.map((e) {
        return e.toJson();
      }).toList(),
    };
  }

  String getUserRole(String userId) {
    if (users.containsKey(userId)) {
      return users[userId] ?? "";
    }
    return "";
  }
}
