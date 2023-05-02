import 'package:app2/pfe/S1.dart';
import 'package:app2/pfe/S5.dart';
import 'package:app2/pfe/chef_dep.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app2/pfe/page1.dart';

class S3 extends StatefulWidget {
  S3({Key key});

  @override
  _GIState createState() => _GIState();
}

class _GIState extends State<S3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('List absence S3 GI'))),
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
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<dynamic> data;
  Future<void> getData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2/pfe_absence/api/S3.php'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body) as List<dynamic>;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          // width: double.infinity,
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const [
                    //  DataColumn(label: Text('Cne')),
                    DataColumn(label: Text('Nom')),
                    DataColumn(label: Text('Prenom')),
                    // DataColumn(label: Text('Email')),
                    //DataColumn(label: Text('Etat')),
                    // DataColumn(label: Text('Statut')),
                    DataColumn(label: Text('date_D')),
                    DataColumn(label: Text('date_F')),
                    DataColumn(label: Text('Element')),
                    DataColumn(label: Text('Absence')),
                    // DataColumn(label: Text('Total_heures')),
                    //DataColumn(label: Text('Avertissements')),
                  ],
                  rows: List<DataRow>.generate(data.length, (index) {
                    final _data = data[index];
                    bool isAbsent = true;
                    return DataRow(
                      cells: [
                        // DataCell(Text(_data['CNE_ET'].toString())),
                        DataCell(Text(_data['NOM_USER'].toString())),
                        DataCell(Text(_data['PRENOM_USER'].toString())),
                        // DataCell(Text(_data['EMAIL_USER'].toString())),
                        // DataCell(Text(_data['ETAT'].toString())),
                        // DataCell(Text(_data['STATUT'].toString())),
                        DataCell(Text(_data['date_D'])),
                        DataCell(Text(_data['date_F'])),
                        DataCell(Text(_data['NOM_ELEMENT'].toString())),
                        //  DataCell(Text(_data['Total_heures'])),
                        // DataCell(Text(_data['AVERTISEMENT_ET'].toString())),
                        DataCell(
                          Checkbox(
                            value: isAbsent,
                            onChanged: (newValue) {
                              setState(() {
                                isAbsent = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  })),
            ),
    );
  }
}
