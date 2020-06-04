class Student{
  int controlnum;
  String name;
  String ap;
  String am;
  String tel;
  String email;
  String clave;
  Student (this.controlnum, this.name, this.ap, this.am, this.tel, this.email, this.clave);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlnum': controlnum,
      'name': name,
      'ap': ap,
      'am': am,
      'tel': tel,
      'email': email,
      'clave': clave,
    };
    return map;
  }
  Student.fromMap(Map<String,dynamic> map){
    controlnum = map['controlnum'];
    name = map['name'];
    ap = map['ap'];
    am = map['am'];
    tel = map['tel'];
    email = map['email'];
    clave = map['clave'];
  }
}