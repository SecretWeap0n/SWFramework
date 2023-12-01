import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sw_framework/Models/SWModel.dart';

import '../Providers/FirebaseDataProvider.dart';

abstract class SWProvider<T extends SWModel> extends ChangeNotifier {
  bool _isLoaded = false;
  late String collectionName;
  late CollectionReference collectionNode;

  List<T> documents = [];

  SWProvider() {
    _init();
  }

  void _init() {
    collectionNode = FirebaseDataProvider.companyNode.collection(collectionName);
  }

  void load() {
    if (_isLoaded) return;
    _isLoaded = true;
    collectionNode.snapshots().listen((event) {
      updateDocuments(event.docs);
    });
  }

  void updateDocuments(List<QueryDocumentSnapshot> docs) {
    List<T> updatedDocuments = docs.map((doc) => _documentToModel(doc)).toList();
    documents = updatedDocuments;
    notifyListeners();
  }

  T _documentToModel(QueryDocumentSnapshot doc) {
    // Assuming SWModel has a default constructor
    T model = createModelInstance();

    // Use the instance method on the created model
    model.fromDocument(doc.id, doc.data());

    return model;
  }

  T createModelInstance();

  void add(Map<String, dynamic> object) {
    print("Add ${object["id"]} to $collectionName");
    collectionNode.add(object);
  }

  void update(Map<String, dynamic> object) {
    print("Update ${object["id"]} from $collectionName");
    collectionNode.doc(object["id"]).update(object);
  }

  void remove(Map<String, dynamic> object) {
    print("Remove ${object["id"]} from $collectionName");
    collectionNode.doc(object["id"]).delete();
  }
}
