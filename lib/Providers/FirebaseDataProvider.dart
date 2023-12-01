import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataProvider{
  static DocumentReference<Map<String, dynamic>> companyNode=FirebaseFirestore.instance.collection('Companies').doc('');

  void SetCompanyNode(String companyId){
    print("Set Company Node: $companyId");
    companyNode = FirebaseFirestore.instance.collection('Companies').doc(companyId);
  }
}