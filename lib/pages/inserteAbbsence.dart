/*import 'package:abssence/model/userDetails.dart';
import 'package:abssence/services/userservice.dart';

import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SeanceWi extends StatefulWidget {
  @override
  SeanceWi({Key? key}) : super(key: key);
  State createState() => Seance();
}

class Seance extends State<SeanceWi> {
  List<userDetails> user = [];
  //  Future<List<userDetails>> students;
  @override
  void initState() {
    super.initState();
    getAllUsers();
    setState(() {
      getAllUsers();
    });
    //students = getuserDetailsList();
  }

  getAllUsers() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_data/api/studentdata.php'));
    print(response.toString());
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      user = result.map((e) => userDetails.fromJson(e)).toList();
      print(user.length);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: DataTable(
        columnSpacing: 38.0,
        columns: [
          DataColumn(label: Text(user.length.toString())),
          DataColumn(label: Text('Nom')),
          DataColumn(label: Text('Prenom')),
          DataColumn(label: Text('Etat')),
        ],
        rows: List.generate(user.length, (index) {
          final y = user[index].cne ?? "";

          final x = user[index].nom ?? "";
          final z = user[index].prenom ?? "";

          return DataRow(cells: [
            DataCell(Container(width: 75, child: Text(y))),
            DataCell(Container(child: Text(x))),
            DataCell(Container(child: Text(z)))
          ]);
        }),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
*/
import 'package:http/http.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app2/model/userDetails.dart';

import 'menu.dart';

class StudentList extends StatefulWidget {
  final String id_seance;

  StudentList({Key key, this.id_seance}) : super(key: key);
  // ignore: library_private_types_in_public_api
  StudentListState createState() => StudentListState(id_seance: this.id_seance);
}

class StudentListState extends State<StudentList> {
  final String id_seance;
  StudentListState({this.id_seance});
  List<userDetails> students = [];
  int count = 0;

  var ID;
  bool _areEyesOpen = true;
  @override
  Widget build(BuildContext context) {
    if (students.length == 0) {
      print("object");
      _loadRecycler();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Student List"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Container(
                  padding:
                      EdgeInsets.only(left: 4, top: 8, bottom: 8, right: 4),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.wc,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Students : " + students.length.toString(),
                            style: TextStyle(
                                color: Color.fromARGB(255, 5, 1, 19),
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Container(
            child: getStudentList(),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Menu(
                              user_id: "",
                            )));
              },
              child: Text(
                'enregister',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //region get student list and card
  //wrap it into Expanded widget or Container with width, Example below.
  Expanded getStudentList() {
    return Expanded(
      child: ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              margin: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
              color: Colors.white,
              elevation: 8.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SafeArea(
                child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue[900],
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  students[position].cne ?? "",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  (students[position].nom ?? "") +
                                      " " +
                                      (students[position].prenom ?? ""),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: IconButton(
                            icon: const Icon(Icons.visibility),
                            iconSize: 32,
                            color: Color.fromARGB(255, 0, 0, 0),
                            onPressed: () =>
                                insertAbsence(students[position].Id_User)
                            /*{
                            setState(() {
                              _areEyesOpen = !_areEyesOpen;
                              students[position];
                            });
                            print((students[position].Id_User ?? ""));
                            ID=students[position].Id_User??"";
                            setState(() {});
                            handlerec();
                          },*/
                            ),
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            );
          }),
    );
  }

  //endregion

  //region load recycler
  void _loadRecycler() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2/api_data/api/studentdata.php?seance_id=${this.id_seance}'));
    print(response.toString());
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      students = result.map((e) => userDetails.fromJson(e)).toList();
      print(students.length);
      setState(() {
        this.students = students;
        this.count = students.length;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

//endregion

  Future<void> rec() async {
    try {
      var response = await post(
          Uri.parse('http://10.0.2.2/pfe_absence/api/add.php'),
          body: {ID = ID});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        print(data['message']);
        if (data['message'] == 'ok') {
          print('recuperer');
        } else {
          print('failed');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerec() {
    print(rec());
    if (rec() == true) print('done');
  }

  insertAbsence(String id_etudient) async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2/api_data/api/add.php?seance_id=${id_seance} & etudient_id=$id_etudient'));
    print(response.body.toString());
    if (response.statusCode == 200) {
      /*setState(() {

      });*/

    } else {
      throw Exception('Failed to load data');
    }
  }
}
