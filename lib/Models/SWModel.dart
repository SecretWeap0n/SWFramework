abstract class SWModel {
  SWModel();

  void fromDocument(String id, dynamic data);

  Map<String, dynamic> toJson();
}