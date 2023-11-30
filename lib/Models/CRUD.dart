class CRUD{
  bool create=false;
  bool read=false;
  bool update=false;
  bool delete=false;
  CRUD(){
    create=false;
    read=false;
    update=false;
    delete=false;
  }

  CRUD.fromData(Map<String,bool> data){
    create=data['create']??false;
    read=data['read']??false;
    update=data['update']??false;
    delete=data['delete']??false;
  }

  toJson() {
    return {
      "create": create,
      "read": read,
      "update": update,
      "delete": delete,
    };
  }
}