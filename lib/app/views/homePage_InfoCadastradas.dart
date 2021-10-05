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
                              child: Text("Alliance",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.orange[300]))),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ]));
  }
}
