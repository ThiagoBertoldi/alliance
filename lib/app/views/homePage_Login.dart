import 'package:alliance/app/views/homePage_EsqueciSenha.dart';
import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
import 'package:alliance/app/views/homePage_CadastroUser.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_MenuRepresentante.dart';
import 'package:alliance/firebase_script/scripts.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: camel_case_types
class HomePage_Login extends StatefulWidget {
  HomePage_Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_Login createState() => _MyHomePageState_Login();
}

// ignore: camel_case_types
class _MyHomePageState_Login extends State<HomePage_Login> {
  void autenticacaoLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => validaLogin(email));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Não existe um usuário com este email!!!');
      } else if (e.code == 'wrong-password') {
        print('Senha não confere!!!');
      }
    }
  }

  void validaLogin(String email) async {
    var query = await db.collection("vendedor_").get();

    for (var dados in query.docs) {
      if (dados['email'] == email) {
        if (dados['permissao'] == '1') {
          userCredential = FirebaseAuth.instance.currentUser;
          userName = userCredential.displayName;
          empresa = dados['empresa'];

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage_MenuCliente()),
          );
        } else {
          userCredential = FirebaseAuth.instance.currentUser;
          userName = userCredential.displayName;
          empresa = dados['empresa'];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HomePage_MenuRepresentante(title: "ALLIANCE")));
        }
      }
    }
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage_EsqueciSenha()));
                    },
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
                      autenticacaoLogin(email, senha);
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage_MenuCliente()));*/
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
                                  HomePage_Cadastro(
                                    title: 'ALLIANCE',
                                  )));
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
