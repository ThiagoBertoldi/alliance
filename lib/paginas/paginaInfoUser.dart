import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PaginaInfoUsuario(title: 'Flutter App'),
    );
  }
}

// ignore: camel_case_types
class PaginaInfoUsuario extends StatefulWidget {
  PaginaInfoUsuario({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PaginaInfoUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.12),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("Informações Cadastradas",
                    style: TextStyle(fontSize: 30, color: Colors.green)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 75),
                child: ListTile(
                    title: new Row(children: <Widget>[
                  new Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Usuário: "))),
                  new Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Thiago Bertoldi"))),
                ])),
              ),
              Container(
                child: ListTile(
                    title: new Row(children: <Widget>[
                  new Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Empresa: "))),
                  new Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Católica SC"))),
                ])),
              ),
              Container(
                child: ListTile(
                    title: new Row(children: <Widget>[
                  new Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Telefone: "))),
                  new Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("(47) 9 91598535"))),
                ])),
              ),
              Container(
                child: ListTile(
                    title: new Row(children: <Widget>[
                  new Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Email: "))),
                  new Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child:
                              new Text("thiago.bertoldi@catolicasc.edu.br"))),
                ])),
              ),
              Container(
                child: ListTile(
                    title: new Row(children: <Widget>[
                  new Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("Última Cotação: "))),
                  new Expanded(
                      flex: 2,
                      child: Container(
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: new Text("14/08/2021"))),
                ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
