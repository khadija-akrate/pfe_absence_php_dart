import 'dart:convert';
import 'package:app2/pages/menu.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

class Auth extends StatefulWidget {
  @override
  Auth({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => log(Id_User: '');
}

class log extends State<Auth> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String Id_User;
  log({this.Id_User});

  @override
  Widget build(BuildContext context) {
    bool _isObscure = true;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(0, 255, 255, 255)
        //color set to transperent or set your own color
        ));

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height
                      //set minimum height equal to 100% of VH
                      ),
              width: MediaQuery.of(context).size.width,
              //make width of outer wrapper to 100%
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 255, 255),
                  ],
                ),
              ), //show linear gradient background of page

              padding: EdgeInsets.all(20),
              child: Column(children: <Widget>[
                Container(
                  child: Container(
                      width: 280,
                      height: 200,
                      margin: EdgeInsets.only(top: 60, left: 50, right: 50),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          image: DecorationImage(
                            image: AssetImage("./images/logo_est.jfif"),
                            fit: BoxFit.cover,
                          ))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Sign In using Email and Password",
                    style: TextStyle(
                        color: Color.fromARGB(0, 3, 1, 42), fontSize: 15),
                  ), //subtitle text
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: loginController,
                    //set username controller
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                        labelText: 'email',
                        suffixIcon: Icon(
                          Icons.person,
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                    decoration: InputDecoration(
                      labelText: 'password',
                      suffixIcon: InkWell(
                        onTap: () => setState(() => _isObscure = !_isObscure),
                        child: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 45),
                  width: 200,
                  height: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                      onPressed: () {
                        handleLogin();
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]))),
    );
  }

  Future<void> login() async {
    try {
      Response response = await post(
          Uri.parse('http://10.0.2.2/api_data/api/login.php'),
          body: {
            'email': loginController.text,
            'password': passwordController.text
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print(data['message']);
        if (data['message'] == 'ok') {
          print('Login successfully');
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Menu(
                        user_id: data['Id_User'],
                      )));
        } else {
          print('failed');
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void handleLogin() {
    login();
  }
}
