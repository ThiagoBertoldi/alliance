import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PaginaProdutos(title: 'Flutter App'),
    );
  }
}

class PaginaProdutos extends StatefulWidget {
  PaginaProdutos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PaginaProdutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Center(
                child: Text("Lista de Produtos",
                    style: TextStyle(fontSize: 30, color: Colors.green)),
              ),
            ),
            Container(
              child: ListTile(
                  title: new Row(children: <Widget>[
                new Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: new Text("Descrição do Produto",
                            style: TextStyle(fontSize: 20)))),
                new Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child:
                            new Text("Preço", style: TextStyle(fontSize: 20)))),
              ])),
            ),
            for (int i = 1; i <= 50; i++)
              ListTile(
                  title: new Row(children: <Widget>[
                new Expanded(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: new Text("Produto $i"))),
                new Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: new Text("Preço"))),
              ])),
          ],
        ),
      ),
    );
  }
}
