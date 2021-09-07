import 'package:alliance/paginas/paginaCadastro.dart';
import 'package:alliance/paginas/paginaProdutos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() {
  runApp(PaginaLogin());
}

// ignore: camel_case_types
class PaginaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage_Login(title: 'ALLIANCE'),
    );
  }
}

// ignore: camel_case_types
class MyHomePage_Login extends StatefulWidget {
  MyHomePage_Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_Login createState() => _MyHomePageState_Login();
}

// ignore: camel_case_types
class _MyHomePageState_Login extends State<MyHomePage_Login> {
  String email = '';
  String senha = '';

  void imprimeLogin(String email, String senha) {
    print(email + " / " + senha);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.only(left: 50.0, right: 50.0),
          child: Container(
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin:
                      new EdgeInsets.only(left: 10.0, right: 10.0, bottom: 50),
                  child: Text(
                    "ALLIANCE",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.orange[300],
                    ),
                  ),
                ),

                TextFormField(
                  onChanged: (text) {
                    email = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),

                Container(
                  margin: new EdgeInsets.only(top: 20),
                  child: TextFormField(
                    onChanged: (text) {
                      senha = text;
                    },
                    autofocus: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: new EdgeInsets.only(top: 15),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.9,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Esqueci minha senha!!!',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.orange[300],
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ),
                // ignore: deprecated_member_use
                Container(
                  margin: new EdgeInsets.only(top: 30),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.07,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    color: Colors.orange[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaginaProdutos()));
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: new EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
                  // ignore: deprecated_member_use

                  child: Text(
                    'Não possui uma conta?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.orange[300],
                    ),
                  ),
                ),
                Container(
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.07,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    color: Colors.orange[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PaginaCadastro()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
