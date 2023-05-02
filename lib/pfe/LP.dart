import 'package:app2/pfe/S1.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:app2/pfe/page1.dart';

class LP extends StatefulWidget {
  LP({Key key});

  @override
  _GIState createState() => _GIState();
}

class _GIState extends State<LP> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Center(child: Text('List absence LP GI')),
            //
            elevation: 0,
            leading: GestureDetector(
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )),
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
              Divider(),
              ListTile(
                title: Text("khadija Akrate"),
                subtitle: Text("khadijaakrate@gmail.com"),
                leading: CircleAvatar(
                  radius: 30,
                  child: Text("KH"),
                ),
              ),
              Divider(),
              // afficher les absences des etudiants
              ListTile(
                leading: Icon(
                  Icons.apps,
                  color: Colors.blue[800],
                ),
                title: Text(
                  'Afficher les absences & Avets',
                  style: TextStyle(fontSize: 17, color: Colors.blue[800]),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => S1(),
                    ),
                  );
                },
              ),
              Divider(),
              // afficher avertissement

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
        await http.get(Uri.parse('http://10.0.2.2/pfe_absence/api/S5.php'));

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
                    DataColumn(label: Text('Cne')),
                    DataColumn(label: Text('Nom')),
                    DataColumn(label: Text('Prenom')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Etat')),
                    DataColumn(label: Text('Statut')),
                    DataColumn(label: Text('date_D')),
                    DataColumn(label: Text('date_F')),
                    DataColumn(label: Text('Element')),
                    // DataColumn(label: Text('Total_heures')),
                    DataColumn(label: Text('Avertissements')),
                  ],
                  rows: List<DataRow>.generate(data.length, (index) {
                    final _data = data[index];

                    return DataRow(
                      cells: [
                        DataCell(Text(_data['CNE_ET'].toString())),
                        DataCell(Text(_data['NOM_USER'].toString())),
                        DataCell(Text(_data['PRENOM_USER'].toString())),
                        DataCell(Text(_data['EMAIL_USER'].toString())),
                        DataCell(Text(_data['ETAT'].toString())),
                        DataCell(Text(_data['STATUT'].toString())),
                        DataCell(Text(_data['date_D'])),
                        DataCell(Text(_data['date_F'])),
                        DataCell(Text(_data['NOM_ELEMENT'].toString())),
                        // DataCell(Text(_data[Total_heures])),
                        DataCell(Text(_data['AVERTISEMENT_ET'].toString())),
                      ],
                    );
                  })),
            ),
    );
  }
}
