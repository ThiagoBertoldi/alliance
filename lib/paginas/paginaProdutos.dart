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
        primarySwatch: Colors.orange,
      ),
      home: PaginaProdutos(title: 'Produtos Cadastrados'),
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
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: ListView(children: [
        Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.15,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.04),
                child: Card(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.05),
                  color: Colors.orange,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: new EdgeInsets.only(top: 10, left: 15),
                        height: 40,
                        child: Text("15",
                            style:
                                TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                      Container(
                        padding: new EdgeInsets.only(top: 5, left: 15),
                        height: 40,
                        child: Text("Produtos cadastrados",
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.1),
                  child: Text("Últimos produtos Cadastrados",
                      style: TextStyle(fontSize: 26, color: Colors.orange))),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    for (int i = 1; i <= 10; i++)
                      new GestureDetector(
                        onTap: () {
                          print("Clicou");
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.09,
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.015),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text("Produto $i",
                                          style: TextStyle(
                                            fontSize: 19,
                                          )),
                                    ),
                                    Container(
                                      child: Text(
                                        "R\$ 150,00",
                                        style: TextStyle(
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          0.01,
                                      left: 2),
                                  child: Text("Unidade"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width *
                                          0.03),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 1.5,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
