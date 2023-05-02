import 'package:app2/pages/menu.dart';
import 'package:app2/pfe/chef_dep.dart';
import 'package:flutter/material.dart';

class apres_login extends StatelessWidget {
  @override
  apres_login({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const BackButtonIcon(),
        ),
        backgroundColor: Colors.blue[800],
        title: Center(child: Text("Chef_département")),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Menu(),
                  ),
                );
              },
              child: Ink.image(
                image: AssetImage('images/chef.png'),
                height: 300,
                width: 500,
                child: Container(
                  margin: EdgeInsets.only(top: 250, left: 120),
                  child: Text(
                    "Enseignant",
                    style: TextStyle(fontSize: 30, fontFamily: 'Anton'),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 0)),
            Material(
              //elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(100),

              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => semestre(),
                    ),
                  );
                },
                child: Ink.image(
                  image: AssetImage('images/khadija.png'),
                  height: 250,
                  width: 460,
                  child: Container(
                    //margin: EdgeInsets.symmetric(vertical: 100, horizontal: 85),
                    margin: EdgeInsets.only(top: 210, left: 80),
                    child: Text(
                      "Chef département",
                      style: TextStyle(fontSize: 30, fontFamily: 'Anton'),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
