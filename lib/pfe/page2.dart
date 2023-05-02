import 'dart:convert';
import 'package:app2/pfe/page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

class Auth extends StatefulWidget {
  @override
  Auth({Key key}) : super(key: key);
  State<StatefulWidget> createState() => page2();
}

class page2 extends State<Auth> {
  bool _isObscure = true;

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _formkey;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Center(child: Text("Login_page")),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 200,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/14.jfif',
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60, right: 60),
            child: TextFormField(
              controller: loginController,
              key: _formkey,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.email_outlined,
                  size: 20,
                ),
                hintText: 'saisir votre Email',
                labelText: 'email',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 60, right: 60),
            child: TextFormField(
              controller: passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(() => _isObscure = !_isObscure),
                  child: Icon(
                    !_isObscure ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                ),
                hintText: 'saisir votre mot de passe',
                labelText: 'password',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 45),
            width: 200,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FlatButton(
                color: Colors.blue[800],
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
        ],
      ),
    );
  }

  Future<bool> login() async {
    try {
      Response response = await post(
          Uri.parse('http://10.0.2.2/pfe_absence/api/login.php'),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => apres_login()));
          return true;
        } else {
          print(response.body);
          showDialog(
              context: context,
              builder: (constext) => AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                    title: const Text(
                      'Error',
                      style: TextStyle(color: Colors.red),
                    ),
                    content: const Text('Email or Password incorrect '),
                  ));
          return false;
        }
      }
    } catch (e) {
      //print(e.toString());

    }
  }

  void handleLogin() {
    print(login());
    if (login() == true)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => apres_login()));
    else {}
  }
}
