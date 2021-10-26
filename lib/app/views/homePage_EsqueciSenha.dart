import 'package:alliance/app/views/google_auth_api.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(HomePage_EsqueciSenha());
}

// ignore: camel_case_types
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

  /*void autenticacaoLogin(String email, String password) async {
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
  }*/

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
      body: ListView(
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
                      emailRedefinicao = text;
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
                      /*onPressed: () {
                        
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomePage_VerifiqueEmail()));
                      },*/
                      onPressed: sendEmail,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future sendEmail() async {
  //GoogleAuthApi.signOut();
  //return;
  final user = await GoogleAuthApi.signIn();

  if (user == null) return;

  final email = user.email;

  final auth = await user.authentication;

  final token = auth.accessToken!;

  print('Authenticated: $email');

  final smtpServer = gmailSaslXoauth2(email, token);

  final message = Message()
    ..from = Address(email, "PAC")
    ..recipients = [emailRedefinicao]
    ..subject = "Redefinição de senha"
    ..html =
        "<h3>Redefinição de senha</h3>\n<p>Recebemos a sua solicitação de redefinição de senha.</p>\n<p>Segue a nova senha para acesso a plataforma: <b>ertYU6.98</b></p>";
  //..text = "Este é um e-mail de teste";

  try {
    await send(message, smtpServer);
  } on MailerException catch (e) {
    print(e);
  }
}
