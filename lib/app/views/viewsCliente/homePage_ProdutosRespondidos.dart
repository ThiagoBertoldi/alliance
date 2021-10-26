import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage_ProdutosRespondidos extends StatefulWidget {
  HomePage_ProdutosRespondidos({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _HomePageState_ProdutosRespondidos createState() =>
      _HomePageState_ProdutosRespondidos();
}

class _HomePageState_ProdutosRespondidos
    extends State<HomePage_ProdutosRespondidos> {
  List<String> dataList = ["Catolica", "Aliança"];
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
      body: ListView(
        children: [
          Container(
            padding: new EdgeInsets.all(40),
            child: Center(
              child: Text("Produtos Respondidos",
                  style: TextStyle(fontSize: 30, color: Colors.orange[300])),
            ),
          ),
          for (int i = 0; i < dataList.length; i++)
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("produtosRespondidos")
                    .doc(dataList[i])
                    .collection("produtos")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          child: Text(dataList[i],
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.8))),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docSnapshot =
                                  snapshot.data!.docs[index];
                              return Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: MediaQuery.of(context).size.width *
                                        0.20,
                                    child: Card(
                                      child: Container(
                                        padding: new EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      docSnapshot[
                                                          "nomeProduto"],
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8))),
                                                ),
                                                Container(
                                                  child: Text(
                                                      docSnapshot["marca"],
                                                      style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8))),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      "R\$" +
                                                          docSnapshot["preço"],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5))),
                                                ),
                                                Container(
                                                  child: Text(
                                                      docSnapshot[
                                                          "unidadeMedida"],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5))),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    );
                  } else {
                    return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator());
                  }
                }),
          /*ElevatedButton(
              onPressed: () {
                recebeVendedores();
              },
              child: Text("OlA"))*/
        ],
      ),
    );
  }
}
