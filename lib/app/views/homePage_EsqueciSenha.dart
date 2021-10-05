import 'package:alliance/app/views/homePage_VerifiqueEmail.dart';
import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alliance/app/views/homePage_Login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(HomePage_EsqueciSenha());
}

class HomePage_EsqueciSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: EsqueciSenha_State(title: "ALLIANCE"),
    );
  }
}

// ignore: camel_case_types
class EsqueciSenha_State extends StatefulWidget {
  EsqueciSenha_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_EsqueciSenha createState() =>
      _MyHomePageState_EsqueciSenha();
}

// ignore: camel_case_types
class _MyHomePageState_EsqueciSenha extends State<EsqueciSenha_State> {
  String email = '';
  String senha = '';

  //teste

  void autenticacaoLogin(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      print(userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Não existe um usuário com este email!!!');
      } else if (e.code == 'wrong-password') {
        print('Senha não confere!!!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage_Login(
                          title: 'ALLIANCE',
                        )));
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
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
                  margin: new EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 50, top: 30),
                  child: Text(
                    "ALLIANCE",
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.orange[300],
                    ),
                  ),
                ),

                Container(
                  margin: new EdgeInsets.only(
                      left: 0.0, right: 0.0, bottom: 50, top: 25),
                  child: Text(
                    "Para redefinir sua senha, informe o e-mail cadastrado na sua conta e lhe enviaremos um e-mail com as instruções.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[500],
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
                      'Redefinir senha',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    color: Colors.orange[300],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage_VerifiqueEmail()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: new Text("Add"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.edit),
            title: new Text("Edit"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.delete),
            title: new Text("Delete"),
          ),
        ],
      ),
    );
  }
}
