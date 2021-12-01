import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'homePage_MenuCliente.dart';

// ignore: camel_case_types
class HomePage_ProdutosRespondidos extends StatefulWidget {
  HomePage_ProdutosRespondidos({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _HomePageState_ProdutosRespondidos createState() =>
      _HomePageState_ProdutosRespondidos();
}

// ignore: camel_case_types
class _HomePageState_ProdutosRespondidos
    extends State<HomePage_ProdutosRespondidos> {
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
        Container(
          padding: new EdgeInsets.only(top: 35, bottom: 20),
          child: Center(
            child: Text("Produtos Respondidos",
                style: TextStyle(fontSize: 30, color: Colors.orange[300])),
          ),
        ),
        Column(
          children: [
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.75,
              child: TextField(
                onChanged: (text) {
                  procuraProduto = text;
                },
                decoration: InputDecoration(
                  labelText: 'Pesquise um Produto',
                ),
              ),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: db.collection("produtosRespondidos").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 25),
                            child: Text(docSnapshot['empresa'],
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange)),
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: db
                                  .collection("produtosRespondidos")
                                  .doc(docSnapshot['empresa'])
                                  .collection("produtos")
                                  .snapshots(),
                              builder: (context, snapshot2) {
                                if (snapshot2.hasData) {
                                  return ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot2.data!.docs.length,
                                      itemBuilder: (context, index2) {
                                        DocumentSnapshot docSnapshot2 =
                                            snapshot2.data!.docs[index2];
                                        return AnimationConfiguration
                                            .staggeredList(
                                                position: index,
                                                delay:
                                                    Duration(milliseconds: 100),
                                                child: SlideAnimation(
                                                    duration: Duration(
                                                        milliseconds: 2500),
                                                    curve: Curves
                                                        .fastLinearToSlowEaseIn,
                                                    child: FadeInAnimation(
                                                        curve: Curves
                                                            .fastLinearToSlowEaseIn,
                                                        duration: Duration(
                                                            milliseconds: 2500),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.95,
                                                                child: Card(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        new EdgeInsets
                                                                            .all(5),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              new EdgeInsets.only(top: 7),
                                                                          child: Text(
                                                                              docSnapshot2['nomeProduto'],
                                                                              style: TextStyle(fontSize: 18)),
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              new EdgeInsets.all(2),
                                                                          child: Text(
                                                                              docSnapshot2['marca'],
                                                                              style: TextStyle(fontSize: 15)),
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              new EdgeInsets.all(2),
                                                                          child: Text(
                                                                              docSnapshot2['preço'],
                                                                              style: TextStyle(fontSize: 15)),
                                                                        ),
                                                                        Container(
                                                                          padding:
                                                                              new EdgeInsets.all(2),
                                                                          child: Text(
                                                                              docSnapshot2['unidadeMedida'],
                                                                              style: TextStyle(fontSize: 15)),
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
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            })
      ]),
    );
  }
}
