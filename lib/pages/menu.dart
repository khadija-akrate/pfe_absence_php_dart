import 'dart:convert';
import 'package:app2/model/seance.dart';
import 'package:app2/pages/login.dart';
import './updatepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'inserteAbbsence.dart';

/*
class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
   
      Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 11, 64, 108),
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('seance'),
            onTap: () => ElevatedButton(onPressed: (){}, child: Text("seance")) ,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('modifier'),
            onTap: () => ElevatedButton(onPressed: (){}, child: Text("modifier")) ,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => ElevatedButton(onPressed: (){}, child: Text("dexonnexion")) ,
          ),
        ],
      ),
    );
  }
}
*/

class Menu extends StatefulWidget {
  final String user_id;
  Menu({Key key, this.user_id}) : super(key: key);
  // ignore: library_private_types_in_public_api
  _Menu createState() => _Menu(user_id: this.user_id);
}

// container
class _Menu extends State<Menu> {
  final String user_id;
  _Menu({this.user_id});
  Seance seance = null;
  List<Seance> seances = [];

  @override

  // ui user interface Design (likaydar fi build)
  Widget build(BuildContext context) {
    print(this.user_id);
    if (seance == null) {
      this.getSeanceByProf();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          backgroundColor: Colors.blue,
        ),
        drawer: Drawer(
          // backgroundColor: Color.fromARGB(255, 10, 48, 79),
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('X'),
                accountEmail: Text('X@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
                ),
              ),
              ListTile(
                leading: Icon(Icons.apps, color: Colors.blue),
                title: Text(
                  'AJOUTER ABSSENCE',
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StudentList();
                      },
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.update,
                  color: Colors.blue,
                ),
                title: Text(
                  'MODIFICATION',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'RaleWay', color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return modifier();
                      },
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  'EXIT',
                  style: TextStyle(
                      fontSize: 15, fontFamily: 'RaleWay', color: Colors.blue),
                ),
                leading: Icon(Icons.exit_to_app, color: Colors.blue),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Auth();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 220, // Largeur du bouton
            height: 70, // Hauteur du bouton
            child: ElevatedButton(
              onPressed: () => routerStudentList(),

              child: Text(
                'Seance',
                style: TextStyle(
                  fontSize: 25, // Taille du texte
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Couleur de fond du bouton
              ), // Contenu du bouton
            ),
          ),
        ));
  }

  void getSeanceByProf() async {
    final response = await http.get(Uri.parse(
        "http://10.0.2.2/pfe_absence/api/seance.php?prof_id=${this.user_id}"));

    // Uri.parse('http://10.0.2.2/api/seance.php?prof_id=${this.user_id}'));
    print(response.body.toString());
    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      seances = result.map((e) => Seance.fromJson(e)).toList();
      if (seances.length > 0) {
        seance = seances[0];
      }
      /*setState(() {
        
      });*/

    } else {
      throw Exception('Failed to load data');
    }
  }

  routerStudentList() {
    print(seance);
    if (seance != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StudentList(
                    id_seance: seance?.id ?? "",
                  )));
    }
  }
}
