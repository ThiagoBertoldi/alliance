// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PaginaCadastroProdutos());
}

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
  String nomeProduto = '';
  String marca = '';
  String preco = '';
  double preco_int = 0;
  String unidadeMedida = '';

  void gravaDados(
      String nomeProduto, String marca, double preco, String unidadeMedida) {
    if (nomeProduto != '' &&
        marca != '' &&
        preco != '' &&
        unidadeMedida != '') {
      db
          .collection("produtos_")
          .doc("$nomeProduto")
          .set({
            "nomeProduto": "$nomeProduto",
            "marca": "$marca",
            "preço": "$preco",
            "unidadeMedida": "$unidadeMedida",
          })
          .then((value) => print("Cadastrado!!!"))
          .catchError((error) => print("Produto não cadastrado: $error"));
    } else {
      print("Precisa Preencher Todos os Campos!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
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
                      padding: new EdgeInsets.all(5),
                      child: TextFormField(
                        onChanged: (text) {
                          marca = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Marca',
                          icon: Icon(Icons.flag),
                        ),
                      ),
                    ),
                    Container(
                      padding: new EdgeInsets.all(5),
                      child: TextFormField(
                        onChanged: (text) {
                          preco = text;
                          preco_int = double.parse(preco);
                        },
                        decoration: InputDecoration(
                          labelText: 'Preço',
                          icon: Icon(Icons.attach_money),
                        ),
                      ),
                    ),
                    Container(
                      padding: new EdgeInsets.all(5),
                      child: TextFormField(
                        onChanged: (text) {
                          unidadeMedida = text;
                        },
                        decoration: InputDecoration(
                          labelText: 'Unidade de Medida',
                          icon: Icon(Icons.widgets_rounded),
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
                          gravaDados(
                              nomeProduto, marca, preco_int, unidadeMedida);
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
