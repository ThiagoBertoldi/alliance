import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'homePage_RespondeCotacao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PaginaRepresentante());
}

class PaginaRepresentante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_MenuRepresentante(
        title: 'ALLIANCE',
      ),
    );
  }
}

class HomePage_MenuRepresentante extends StatefulWidget {
  HomePage_MenuRepresentante({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_MenuRepresentante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: ListView(
            children: [
              Container(
                padding: new EdgeInsets.all(30),
                child: Center(
                  child: Text("Cotações Pendentes",
                      style:
                          TextStyle(fontSize: 30, color: Colors.orange[300])),
                ),
              ),
              Container(
                  child: Center(
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePageState_ResponderCotacao(
                                  title: 'ALLIANCE',
                                )));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        right: 15,
                        left: 15,
                        bottom: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                child: Text("Cotação Semanal",
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold)),
                              )),
                              Text("Enviado em ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: new EdgeInsets.only(left: 5, top: 7),
                                  child: Text("35 Produtos para responder",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: Container(
                                    padding: new EdgeInsets.only(top: 5),
                                    child: Text("26/09/2021",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
              Container(
                padding: new EdgeInsets.all(30),
                child: Center(
                  child: Text("Cotações Respondidas",
                      style:
                          TextStyle(fontSize: 30, color: Colors.orange[300])),
                ),
              ),
              for (int i = 0; i < 10; i++)
                Container(
                  child: new InkWell(
                    onTap: () {},
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
                                    child: Text("Produto ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold))),
                                Text('Enviado em',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding:
                                        new EdgeInsets.only(left: 5, top: 7),
                                    child: Text("35 Produtos para responder",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Container(
                                  child: Container(
                                      padding: new EdgeInsets.only(top: 5),
                                      child: Text('14/09/2021',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
