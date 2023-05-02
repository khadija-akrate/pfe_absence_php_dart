import 'dart:convert';

import 'package:app2/pfe/S3.dart';
import 'package:app2/pfe/S5.dart';

import 'package:app2/pfe/page1.dart';
import 'package:app2/pfe/page3.dart';
import 'package:app2/pfe/S1.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class semestre extends StatefulWidget {
  semestre({Key key}) : super(key: key);

  _semestreState createState() => _semestreState();
}

class _semestreState extends State<semestre> {
  String selectedSemestre;
  List semestreItemList = List();

  Future<void> getAllsemestre() async {
    var url = "http://10.0.2.2/pfe_absence/api/select.php";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        semestreItemList = jsonData;
      });
    } else {
      semestreItemList = [];
    }
  }

  //
  Future getPostBySemestre() async {
    var url = "http://10.0.2.2/pfe_absence/api/getPostBySemestre.php";
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllsemestre();
    getPostBySemestre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 260),
              height: 60,
              width: 40,
              child: ClipRRect(
                  //child: Image.asset('images/logo_est.jfif'),
                  ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/est-safi.jfif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text("khadija Akrate"),
              subtitle: Text("khadijaakrate@gmail.com"),
              leading: CircleAvatar(
                radius: 30,
                child: Text("KH"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // afficher les absences des etudiants

            ListTile(
              leading: Icon(
                Icons.view_list,
                color: Colors.blue,
              ),
              title: Text(
                'Choisir une semestre',
                style: TextStyle(fontSize: 15, color: Colors.blue[800]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => semestre(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.lock,
                color: Colors.blue[800],
              ),
              title: Text(
                'Déconnection',
                style: TextStyle(fontSize: 17, color: Colors.blue[800]),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => page1(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(0),
              margin:
                  EdgeInsets.only(left: 20, right: 20, bottom: 60, top: 120),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[800], width: 2.0),
                    borderRadius: BorderRadius.circular(20)),
                child: DropdownButton(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.blue[800]),
                  iconSize: 40,
                  underline: Divider(thickness: 0),
                  isExpanded: true,
                  hint: Container(
                    padding: EdgeInsets.only(left: 57),
                    child: Text(
                      "Choisir une semestre",
                      style: TextStyle(color: Colors.blue[800], fontSize: 20),
                    ),
                  ),
                  value: selectedSemestre,
                  items: semestreItemList
                      .map((semestre) => DropdownMenuItem(
                            value: semestre['NUM_SEMESTRE'],
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              child: Container(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Text(
                                  semestre['NUM_SEMESTRE'],
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSemestre = val;
                    });
                  },
                ),
              ),
            ),
          ),
          /*Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue[800], width: 2.0),
                borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => LP()));
                },
                child: Text(
                  'Lisence Professionnelle',
                  style: TextStyle(fontSize: 20, color: Colors.blue[800]),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),*/
          Container(
            margin: EdgeInsets.only(top: 160),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FlatButton(
                color: Colors.blue[800],
                onPressed: () {
                  if (selectedSemestre == "") {
                    print("please select a semestre");
                  } else {
                    print("user selected semestre $selectedSemestre");
                    if (selectedSemestre == "S1") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => S1(),
                          ));
                    } else {
                      if (selectedSemestre == "S3") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => S3(),
                            ));
                      }
                    }
                    if (selectedSemestre == "S5") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => S5(),
                          ));
                    }
                  }
                },
                child: Container(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue[800], width: 2.0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: FlatButton(
              color: Colors.blue[800],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => apres_login()));
              },
              child: Container(
                // margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue[800], width: 2.0),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Retour',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
