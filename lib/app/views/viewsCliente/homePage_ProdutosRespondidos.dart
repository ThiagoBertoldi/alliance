import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  Future<List> dataList = recebeVendedores();
  void teste() {
    print(dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Container(
          padding: new EdgeInsets.all(40),
          child: Center(
            child: Text("Produtos Respondidos",
                style: TextStyle(fontSize: 30, color: Colors.orange[300])),
          ),
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
                          Text(docSnapshot['empresa'],
                              style: TextStyle(fontSize: 30)),
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
                                        return Container(
                                          padding: new EdgeInsets.only(top: 40),
                                          child: Column(
                                            children: [
                                              Text(docSnapshot2['nomeProduto']),
                                              Text(docSnapshot2['preço']),
                                              Text(docSnapshot2[
                                                  'unidadeMedida']),
                                              Text(docSnapshot2['marca']),
                                            ],
                                          ),
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

        /*StreamBuilder<QuerySnapshot>(
            stream: db
                .collection("produtosRespondidos")
                .doc()
                .collection("produtos")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                teste();
                return Container(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot docSnapshot =
                              snapshot.data!.docs[index];
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      child: ListTile(
                                        title: /*Text(docSnapshot['nomeProduto'])*/ Text(
                                            "Oi"),
                                        subtitle: Text(docSnapshot['marca']),
                                        trailing: Text(docSnapshot['preço'] +
                                            '  ' +
                                            docSnapshot['unidadeMedida']),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }));
              } else {
                return CircularProgressIndicator();
              }
            }),*/

        /*ElevatedButton(
              onPressed: () {
                recebeVendedores();
              },
              child: Text("OlA"))*/
      ]),
    );
  }
}
