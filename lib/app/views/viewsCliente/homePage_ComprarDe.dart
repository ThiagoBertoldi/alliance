import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'homePage_MenuCliente.dart';

// ignore: camel_case_types
class HomePage_ComprarDe extends StatefulWidget {
  HomePage_ComprarDe({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState_ComprarDe createState() => _HomePageState_ComprarDe();
}

// ignore: camel_case_types
class _HomePageState_ComprarDe extends State<HomePage_ComprarDe> {
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
        body: ListView(children: [
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 45),
            child: Text("Lista de compras desta Semana",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          )),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 25),
            child: Text("Empresas -> Produtos",
                style: TextStyle(fontSize: 17, color: Colors.orange)),
          )),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection("comprarDe").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnapshot =
                            snapshot.data!.docs[index];
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(docSnapshot['empresa'],
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 26)),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: db
                                    .collection("comprarDe")
                                    .doc(docSnapshot['empresa'])
                                    .collection("produtos")
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  if (snapshot2.hasData) {
                                    return ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot2.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot docSnapshot =
                                              snapshot2.data!.docs[index];
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .1,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  elevation: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          docSnapshot[
                                                              'nomeProduto'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(docSnapshot['preço'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }),
                          ],
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })
        ]));
  }
}
