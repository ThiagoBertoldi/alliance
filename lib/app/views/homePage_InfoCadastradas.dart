import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class HomePage_InfoCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Informações Cadastrais',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_InfoCadastradas(title: 'Informações Cadastrais'),
    );
  }
}

// ignore: camel_case_types
class HomePage_InfoCadastradas extends StatefulWidget {
  HomePage_InfoCadastradas({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState_InfoCadastradas createState() =>
      _HomePageState_InfoCadastradas();
}

// ignore: camel_case_types
class _HomePageState_InfoCadastradas extends State<HomePage_InfoCadastradas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => MenuCliente_State(
                            title: 'ALLIANCE',
                          )));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset(
                        'images/user.png',
                        width: 75.0,
                        height: 75.0,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        child: Center(
                            child: Text(nome,
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.orange[300],
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  )),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: new EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                'E-mail',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: new EdgeInsets.only(
                                  left: 15, top: 4, right: 15),
                              child: Text(
                                email,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: new EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                'ID de Usuário',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: new EdgeInsets.only(left: 15, top: 4),
                              child: Text(
                                "$idToken",
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: new EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                'Empresa',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              padding: new EdgeInsets.only(left: 15, top: 4),
                              child: Text(
                                empresa,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ]));
  }
}
