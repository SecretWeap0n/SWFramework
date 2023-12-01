class SWUser{
  String id = "";
  String name = "";
  String lastname = "";
  String email = "";
  String phone = "";
  String picture="";
  bool isSuperUser = false;

  List<String> companies=[];

   String role='';

  String get fullname => "$name $lastname";
  String get initials => "${name[0]}${lastname[0]}".toUpperCase();

  SWUser();
  SWUser.fromDocument(String _id,Map<String, dynamic> document){
    this.id = _id;
    name = document['name'];
    lastname = document['lastname'];
    email = document['email'];
    phone = document['phone'];
    picture = document['picture']??"";
    companies = document['companies']!=null?List<String>.from(document['companies']):[];
    isSuperUser = document['isSuperUser']??false;
  }
}