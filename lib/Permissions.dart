import 'package:sw_framework/Models/Company.dart';

import 'Models/CompanyModule.dart';


class Permissions {
  static final Permissions _instance = Permissions._internal();

  factory Permissions() {
    return _instance;
  }

  Permissions._internal() {}
  static String _userId = "";
  static String _userRole = "";
  static Company _company = Company();
  static CompanyModule _module = CompanyModule();

  static String _moduleSelected = "";

  static bool get isAdmin {
    return _userRole.toLowerCase() == "admin";
  }

  static bool get create {
    print("CREATE $_userRole ${_module.label}");
    if (CommonChecks()) return false;

    var isValid = _module.permissions.rules[_userRole]?.create ?? false;
    print("create: $isValid");
    return isValid;
  }

  static bool get read {
    print("READ $_userRole ${_module.label}");
    if (CommonChecks()) return false;
    var isValid = _module.permissions.rules[_userRole]?.read ?? false;
    print("read: $isValid");
    return isValid;
  }

  static bool get update {
    print("UPDATE $_userRole ${_module.label}");
    if (CommonChecks()) return false;
    var isValid = _module.permissions.rules[_userRole]?.update ?? false;
    print("update: $isValid");
    return isValid;
  }

  static bool get delete {
    print("DELETE $_userRole ${_module.label}");
    if (CommonChecks()) return false;
    var isValid = _module.permissions.rules[_userRole]?.delete ?? false;
    print("delete: $isValid");
    return isValid;
  }

  static SetUserId(String userId) {
    _userId = userId;
  }

  static SetCompany(Company company) {
    _company = company;
    if (!_company.users.containsKey(_userId)) return;

    _userRole = _company.users[_userId] ?? "";
  }

  static void SetModule(String moduleId) {
    if (moduleId.isEmpty) return;
    if (_company.modules.isEmpty) return;
    if (!_company.modules.any((element) => element.moduleId == moduleId)) return;
    _moduleSelected = moduleId;
    updateModulePermissions();
  }

  static void updateModulePermissions() {
    print("updateModulePermissions");
    if (_moduleSelected.isEmpty) return;
    _module = _company.modules.firstWhere((element) => element.id == _moduleSelected);
  }

  static bool CommonChecks() {
    if (_userId.isEmpty) {
      print("UserId is empty");
      return true;
    }
    if (_userRole.isEmpty) {
      print("Role is empty");
      return true;
    }
    if (_company.id.isEmpty) {
      print("Company is empty");
      return true;
    }
    if (_module.id.isEmpty) {
      print("Module is empty");
      return true;
    }

    if (_module.permissions.rules.isEmpty) {
      print("Module Rules is empty");
      return true;
    }
    if (!_module.permissions.rules.keys.contains(_userRole)) {
      print("Module Rules does not contain $_userRole");
      return true;
    }

    return false;
  }
}
