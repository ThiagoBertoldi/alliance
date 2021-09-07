import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

main() {
  runApp(PaginaProdutos());
}

class PaginaProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: PaginaProdutos_State(title: 'Produtos Cadastrados'),
    );
  }
}

// ignore: camel_case_types
class PaginaProdutos_State extends StatefulWidget {
  PaginaProdutos_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PaginaProdutos_State> {
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
                padding: new EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.285,
                child: Card(
                  color: Colors.orange[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: new EdgeInsets.only(top: 10, left: 15),
                        height: 40,
                        child: Text("15",
                            style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: new EdgeInsets.only(top: 5, left: 15),
                        height: 40,
                        child: Text("Produtos cadastrados",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: new EdgeInsets.only(top: 5, left: 15),
                        height: 40,
                        child: Text("6",
                            style: TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: new EdgeInsets.only(top: 5, left: 15),
                        height: 40,
                        child: Text("Representantes diferentes",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  color: Colors.orange[300],
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.07),
                  child: Text("Últimos Produtos Cadastrados",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02)),
              for (int i = 1; i <= 10; i++)
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: new EdgeInsets.only(top: 5),
                  child: new InkWell(
                    onTap: () {
                      print("Clicou no Button $i");
                    },
                    child: Card(
                      color: Colors.white,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.04,
                          left: MediaQuery.of(context).size.width * 0.04,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                    child: Text("Produto $i",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold))),
                                Text('R\$ 150,00',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Container(
                              padding: new EdgeInsets.only(top: 10, left: 5),
                              child: Text("Unidade",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: new EdgeInsets.all(5),
                              child: Text("Marca",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
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
