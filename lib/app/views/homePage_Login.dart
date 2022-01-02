import 'package:alliance/app/HomePage_Home.dart';
import 'package:alliance/app/teste_login/google.sign_in.dart';
import 'package:alliance/app/views/viewsCliente/homePage_CotacoesAEnviar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class HomePage_Login extends StatefulWidget {
  HomePage_Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_Login createState() => _MyHomePageState_Login();
}

// ignore: camel_case_types
class _MyHomePageState_Login extends State<HomePage_Login> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  width: _width,
                  height: _height * 0.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Text("ALLIANCE",
                            style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(125.0),
                    ),
                  )),
              Container(
                width: _width * 0.6,
                height: _height * 0.07,
                margin: EdgeInsets.only(top: _height * 0.15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        primary: Colors.orange,
                        onPrimary: Colors.white),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage_Home(title: "ALLIANCE"))));
                    },
                    child: Text(
                      "Entrar com Google",
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: _height * 0.1),
                padding: EdgeInsets.all(10),
                child: Text("Ainda não possui conta?",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ));
  }
}
