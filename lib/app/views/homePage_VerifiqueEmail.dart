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
  runApp(HomePage_VerifiqueEmail());
}

class HomePage_VerifiqueEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: VerifiqueEmail_State(title: "ALLIANCE"),
    );
  }
}

// ignore: camel_case_types
class VerifiqueEmail_State extends StatefulWidget {
  VerifiqueEmail_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_VerifiqueEmail createState() =>
      _MyHomePageState_VerifiqueEmail();
}

// ignore: camel_case_types
class _MyHomePageState_VerifiqueEmail extends State<VerifiqueEmail_State> {
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
      body: Container(
        width: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
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
                          left: 0.0, right: 0.0, bottom: 10, top: 25),
                      child: Text(
                        "Verifique seu e-mail",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Container(
                      margin: new EdgeInsets.only(
                          left: 0.0, right: 0.0, bottom: 50, top: 10),
                      child: Text(
                        "Nós enviamos um e-mail com as instruções.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(top: 80),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              //color: Colors.black,
              child: Text(
                "Não recebeu o e-mail? Cheque a sua caixa de spam.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
