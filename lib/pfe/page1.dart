import 'package:app2/pfe/page2.dart';
import 'package:flutter/material.dart';

class page1 extends StatelessWidget {
  @override
  page1({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/13.jfif'),
          ),
        ),
        child: Column(children: [
          Padding(padding: EdgeInsets.all(60)),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text('Hi! Welcome in our application',
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 20,
                    fontFamily: 'Anton')),
          ),
          Padding(padding: EdgeInsets.all(230)),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                        color: Colors.blue[800],
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Auth()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  )),
            ),
          )
        ]),
      ),
    );
  }
}
