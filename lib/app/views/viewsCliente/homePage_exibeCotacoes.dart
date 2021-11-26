import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: camel_case_types
class HomePage_ExibeCotacoes extends StatefulWidget {
  HomePage_ExibeCotacoes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_ExibeLogin createState() => _MyHomePageState_ExibeLogin();
}

// ignore: camel_case_types
class _MyHomePageState_ExibeLogin extends State<HomePage_ExibeCotacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("cotacoesPassadas")
                    .doc(cotacaoSelecionada)
                    .collection("empresas")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docSnapshot =
                              snapshot.data!.docs[index];
                          return Container(
                            margin: new EdgeInsets.only(top: 25),
                            child: Column(
                              children: [
                                Text(docSnapshot['empresa'],
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold)),
                                StreamBuilder<QuerySnapshot>(
                                    stream: db
                                        .collection("cotacoesPassadas")
                                        .doc(cotacaoSelecionada)
                                        .collection("empresas")
                                        .doc(docSnapshot['empresa'])
                                        .collection("produtos")
                                        .snapshots(),
                                    builder: (context, snapshot2) {
                                      if (snapshot2.hasData) {
                                        return ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                snapshot2.data!.docs.length,
                                            itemBuilder: (context, index2) {
                                              DocumentSnapshot docSnapshot2 =
                                                  snapshot2.data!.docs[
                                                      index2]; ///////////////////////////////////////// COMPARAÇÃO DE PRODUTOS "snapshot.data!.docs[index];"
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                      position: index,
                                                      delay: Duration(
                                                          milliseconds: 100),
                                                      child: SlideAnimation(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  2500),
                                                          curve: Curves
                                                              .fastLinearToSlowEaseIn,
                                                          child:
                                                              FadeInAnimation(
                                                                  curve: Curves
                                                                      .fastLinearToSlowEaseIn,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          2500),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                          width: MediaQuery.of(context).size.width *
                                                                              0.95,
                                                                          child:
                                                                              Card(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              padding: new EdgeInsets.all(5),
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    padding: new EdgeInsets.only(top: 7),
                                                                                    child: Text(docSnapshot2['nomeProduto'], style: TextStyle(fontSize: 18)),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: new EdgeInsets.all(2),
                                                                                    child: Text(docSnapshot2['marca'], style: TextStyle(fontSize: 15)),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: new EdgeInsets.all(2),
                                                                                    child: Text(docSnapshot2['preço'], style: TextStyle(fontSize: 15, color: Colors.orange)),
                                                                                  ),
                                                                                  Container(
                                                                                    padding: new EdgeInsets.all(2),
                                                                                    child: Text(docSnapshot2['unidadeMedida'], style: TextStyle(fontSize: 15)),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ))));
                                            });
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ));
  }
}
