// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ComprasPassadas_State extends StatefulWidget {
  ComprasPassadas_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_ComprasPassadas createState() =>
      _MyHomePageState_ComprasPassadas();
}

class _MyHomePageState_ComprasPassadas extends State<ComprasPassadas_State> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: ListView(
          children: [
            Container(margin: EdgeInsets.only(top: 20)),
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("comprasPassadas")
                    .doc(compraAntigaSelecionada)
                    .collection("empresas")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docSnapshot =
                                  snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Container(margin: EdgeInsets.only(top: 10)),
                                  Text(docSnapshot['empresa'],
                                      style: TextStyle(
                                          fontSize: 28, color: Colors.orange)),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: db
                                          .collection("comprasPassadas")
                                          .doc(compraAntigaSelecionada)
                                          .collection("empresas")
                                          .doc(docSnapshot['empresa'])
                                          .collection("produtos")
                                          .snapshots(),
                                      builder: (context, snapshot2) {
                                        if (snapshot2.hasData) {
                                          return Container(
                                              child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot2
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index2) {
                                                    DocumentSnapshot
                                                        docSnapshot2 = snapshot2
                                                            .data!.docs[index2];
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .9,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              .1,
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            color: Colors.white,
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      docSnapshot2[
                                                                          'nomeProduto'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }));
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      }),
                                ],
                              );
                            }));
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ));
  }
}
