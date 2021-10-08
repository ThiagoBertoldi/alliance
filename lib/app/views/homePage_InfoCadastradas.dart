import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

class _HomePageState_InfoCadastradas extends State<HomePage_InfoCadastradas> {
  @override

  //double_width = MediaQuery.of(context).size.width

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: ListView(children: [
          Container(
            child: Column(
              children: [
                /*new Image.asset(
                  'images/user.png',
                  width: 75.0,
                  height: 75.0,
                  fit: BoxFit.cover,
                ),
                Container(
                    padding: new EdgeInsets.all(40),
                    child: Center(
                        child: Text("Michel",
                            style: TextStyle(
                                fontSize: 30, color: Colors.orange[300])))),*/
                Container(
                    padding: new EdgeInsets.all(40),
                    child: Row(
                      children: [
                        new Image.asset(
                          'images/user.png',
                          width: 75.0,
                          height: 75.0,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: new EdgeInsets.all(40),
                          child: Center(
                              child: Text("Nome",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.orange[300]))),
                        ),
                      ],
                    )),
                Container(
                    //padding: new EdgeInsets.only(top: 40),
                    padding: new EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 330,
                          height: 80,
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      'E-mail',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 4),
                                    child: Text(
                                      'alliance@gmail.com',
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
                    //padding: new EdgeInsets.only(top: 40),
                    padding: new EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 330,
                          height: 80,
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      'Password',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 4),
                                    child: Text(
                                      '*********',
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
                    //padding: new EdgeInsets.only(top: 40),
                    padding: new EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 330,
                          height: 80,
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      'Telefone',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 4),
                                    child: Text(
                                      '(47) 9 9783-7553',
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
                    //padding: new EdgeInsets.only(top: 40),
                    padding: new EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 330,
                          height: 80,
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      'Empresa',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 4),
                                    child: Text(
                                      'Panif. Aliança',
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
                    //padding: new EdgeInsets.only(top: 40),
                    padding: new EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          width: 330,
                          height: 80,
                          child: Card(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 15),
                                    child: Text(
                                      'Empresa',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        new EdgeInsets.only(left: 15, top: 4),
                                    child: Text(
                                      'Panif. Aliança',
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
                  margin: new EdgeInsets.only(top: 30),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    height: MediaQuery.of(context).size.height * 0.07,
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      'Editar',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    color: Colors.orange[300],
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
