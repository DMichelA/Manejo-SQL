import 'package:flutter/material.dart';
import 'crud_operations.dart';
import 'students.dart';
import 'dart:async';

void main() => runApp(Update());

class Update extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
  //Variables referentes al manejo de la BD
  Future<List<Student>> Studentss;
  TextEditingController onecontroller = TextEditingController();
  TextEditingController twocontroller = TextEditingController();
  TextEditingController threecontroller = TextEditingController();
  TextEditingController fourcontroller = TextEditingController();
  TextEditingController fivecontroller = TextEditingController();
  TextEditingController sixcontroller = TextEditingController();
  TextEditingController controller = TextEditingController();

  String name;
  String ap;
  String am;
  String tel;
  String email;
  String clave;

  int currentUserId;
  int op;
  String valor;

  String descriptive_text = "Student Name";

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating; //Saber el estado actual de la consulta
  bool disabled1;
  bool disabled2;
  bool disabled3;
  bool disabled4;
  bool disabled5;
  bool disabled6;
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    disabled1 = false;
    disabled2 = false;
    disabled3 = false;
    disabled4 = false;
    disabled5 = false;
    disabled6 = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  void updated() {
    setState(() {
      _showSnackbar(context, "Updated Data!");
    });
  }

  void cleanData() {
    onecontroller.text = "";
    twocontroller.text = "";
    threecontroller.text = "";
    fourcontroller.text = "";
    fivecontroller.text = "";
    sixcontroller.text = "";
    controller.text = "";
  }

  /*void dataValidate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        Student stu = Student(currentUserId, name, ap, am, tel, email, clave);
        dbHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, name, ap, am, tel, email, clave);
        dbHelper.insert(stu);
      }
      //Limpia despues de ejecutar de la consulta
      cleanData();
      refreshList();
      updated();
    }
  }*/

  void updateData(){
    print("Valor de Opción");
    print(op);
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (op==1) {
        Student stu = Student(currentUserId, valor, ap, am, tel, email, clave);
        dbHelper.update(stu);
      }
      else if (op==2) {
        Student stu = Student(currentUserId, name, valor, am, tel, email, clave);
        dbHelper.update(stu);
      }
      else if (op==3) {
        Student stu = Student(currentUserId, name, ap, valor, tel, email, clave);
        dbHelper.update(stu);
      }
      else if (op==4) {
        Student stu = Student(currentUserId, name, ap, am, valor, email, clave);
        dbHelper.update(stu);
      }
      else if (op==5) {
        Student stu = Student(currentUserId, name, ap, am, tel, valor, clave);
        dbHelper.update(stu);
      }
      else if (op==6) {
        Student stu = Student(currentUserId, name, ap, am, tel, email, valor);
        dbHelper.update(stu);
      }
      cleanData();
      refreshList();
      updated();
    }
  }

  void insertData(){
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      {
        Student stu = Student(null, name, ap, am, tel, email, clave);
        dbHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }

  //Formulario
  Widget form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              enabled: disabled1 ? false : true,
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: descriptive_text),
              validator: (val) => val.length == 0 ? 'Enter Data' : null,
              onSaved: (val) => valor = val,
            ),
            SizedBox(height: 30,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.indigoAccent),
                  ),
                  onPressed: updateData,
                  //child: Text(isUpdating  ? 'Update Data' : 'Add Data'),
                  child: Text(isUpdating ? 'Update Data' : 'Select a Field'),
                ),
                MaterialButton(
                  color: Colors.indigoAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.indigoAccent),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Mostrar datos
  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("P-Surname"),
          ),
          DataColumn(
            label: Text("M-Surname"),
          ),
          DataColumn(
            label: Text("Phone"),
          ),
          DataColumn(
            label: Text("E-Mail"),
          ),
          DataColumn(
            label: Text("Enrollment"),
          ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [
          DataCell(Text(student.name.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "Name";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=1;
            });
            controller.text = student.name;
          }),
          DataCell(Text(student.ap.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "P-Surname";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=2;
            });
            controller.text = student.ap;
          }),
          DataCell(Text(student.am.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "M-Surname";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=3;
            });
            controller.text = student.am;
          }),
          DataCell(Text(student.tel.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "Phone";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=4;
          });
          controller.text = student.tel;
          }),
          DataCell(Text(student.email.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "E-Mail";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=5;
            });
            controller.text = student.email;
          }),
          DataCell(Text(student.clave.toString().toUpperCase()), onTap: () {
            setState(() {
              isUpdating = true;
              descriptive_text = "Enrollment";
              currentUserId = student.controlnum;
              name = student.name;
              ap = student.ap;
              am = student.am;
              tel = student.tel;
              email = student.email;
              clave = student.clave;
              op=6;
            });
            controller.text = student.clave;
          }),
        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
          future: Studentss,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //Cuando tenemos datos
              return dataTable(snapshot.data);
            }
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Text("No data founded!");
            }
            return CircularProgressIndicator();
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text('Update Operation',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            form(),
            list(),
            //list(),
          ],
        ),
      ),
    );
  }

  _showSnackbar(BuildContext context, String texto) {
    final snackBar = SnackBar(
        backgroundColor: Colors.indigoAccent,
        content: new Text(texto,
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Schyler',
              fontWeight: FontWeight.bold,
            )));
    _scaffoldkey.currentState.showSnackBar(snackBar);
  }
}
