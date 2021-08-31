import 'package:alliance/paginas/paginaCadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

main() {
  runApp(PaginaLogin());
}

// ignore: camel_case_types
class PaginaLogin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage_Login(title: 'Alliance'),
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
                    "Login de Usuário",
                    style: TextStyle(fontSize: 35, color: Colors.green),
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

                TextFormField(
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

                Container(
                  margin: new EdgeInsets.only(top: 30),
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.6,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      'Esqueci minha senha!!!',
                      style: TextStyle(color: Colors.black54),
                    ),
                    onPressed: () {},
                  ),
                ),
                // ignore: deprecated_member_use
                Container(
                  margin: new EdgeInsets.only(top: 40),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.07,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      imprimeLogin(email, senha);
                    },
                  ),
                ),
                Container(
                  margin: new EdgeInsets.only(top: 20),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.07,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
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
