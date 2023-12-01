import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sw_framework/Models/Company.dart';

import '../Models/Permissions.dart';


class PlatformProvider with ChangeNotifier {
  Company _company = Company();
  String moduleSelected = '';
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? listener = null;


  Company get company => _company;

  PlatformProvider(String companyId) {
    setCompany(companyId);
  }

  void setModuleSelected(String moduleId) {
    moduleSelected = moduleId;
    notifyListeners();
  }

  void setCompany(String companyId) {
    if (companyId.isEmpty) return;
    listener?.cancel();
    listener = null;
    //TODO: remover Firebase
    listener = FirebaseFirestore.instance.collection("Companies").doc(companyId).snapshots().listen((event) {
      updateCompany(event);
    });
  }

  void updateCompany(DocumentSnapshot<Map<String, dynamic>> event) {
    _company = Company.fromDocument(event.id, event.data() as Map<String, dynamic>);
    Permissions.SetCompany(_company);
    Permissions.updateModulePermissions();
    notifyListeners();
  }

  void addUserToCompany(String userId) {
    _company.users[userId] = "";
  }

  void removeUserFromCompany(String userId) {
    _company.users.remove(userId);
  }
}
