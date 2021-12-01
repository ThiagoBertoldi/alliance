// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'homePage_MenuCliente.dart';

// ignore: camel_case_types
class PaginaCadastroProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_CadastroProdutos(
        title: 'ALLIANCE',
      ),
    );
  }
}

// ignore: camel_case_types
class HomePage_CadastroProdutos extends StatefulWidget {
  HomePage_CadastroProdutos({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_CadastroProdutos> {
  var db = FirebaseFirestore.instance;

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
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                  padding: new EdgeInsets.all(50),
                  child: Text("Cadastro de Produtos",
                      style: TextStyle(fontSize: 30, color: Colors.orange))),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: new EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  children: [
                    Container(
                      padding: new EdgeInsets.all(5),
                      child: TextFormField(
                        onChanged: (text) {
                          nomeProduto = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nome do Produto',
                          icon: Icon(Icons.local_restaurant),
                        ),
                      ),
                    ),
                    Container(
                      padding: new EdgeInsets.all(40),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        height: MediaQuery.of(context).size.height * 0.07,
                        minWidth: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        color: Colors.orange[300],
                        onPressed: () {
                          gravaNovoProduto(nomeProduto);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
