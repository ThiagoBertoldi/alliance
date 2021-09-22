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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_InfoCadastradas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          Container(
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
                  child: Text("Michel",
                      style:
                          TextStyle(fontSize: 30, color: Colors.orange[300])))),
              Container(
              child: Row(
            children:[
              new Image.asset(
                'images/user.png',
                width: 75.0,
                height: 75.0,
                fit: BoxFit.cover,
              ),
              Container(
                padding: new EdgeInsets.all(40),
                child: Center(
                  child: Text("Michel",
                      style:
                          TextStyle(fontSize: 30, color: Colors.orange[300]))),
                ),
             }
              ),
            ],
           )
          ),
        ],
      ),
    );
  }
}
