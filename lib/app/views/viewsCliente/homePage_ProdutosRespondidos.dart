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
  Color color = Colors.white;

  Future<void> quantidadeASerComprada(String empresa, String nomeProduto) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  height: MediaQuery.of(context).size.height * .45,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Digite a quantidade de compra",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            nomeProduto,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.all(25),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              quantidadeDeCompra = text;
                            },
                            decoration: InputDecoration(
                              labelText: 'Quantidade',
                              icon: Icon(Icons.production_quantity_limits),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .08,
                          margin: EdgeInsets.only(top: 10),
                          child: DropdownButton<String>(
                            hint: Text(unidadeMedidaComprarDe),
                            items: <String>[
                              'Un',
                              'Kg',
                              'L',
                              'Cx',
                              'Fd',
                              'Outro'
                            ].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                unidadeMedidaComprarDe = value.toString();
                              });
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .45,
                          height: MediaQuery.of(context).size.height * .05,
                          margin: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Adicionar",
                                  style: TextStyle(color: Colors.white))),
                        )
                      ])));
        });
  }

  Future<void> _showDialogCompraProduto(
      String nomeProduto,
      String empresaJaContem,
      String precoJaContem,
      String empresaNaoContem,
      String precoNaoContem,
      String marcaJaContem,
      String marcaNaoContem,
      String quantidadeDeCompra,
      String unidadeMedidaCompra) async {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(nomeProduto,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21)),
                  Text("já existe na lista de compras",
                      style: TextStyle(fontSize: 16)),
                  Text("\n\nDeseja substituir?",
                      style: TextStyle(fontSize: 15)),
                  Text("\nEmpresa: " + empresaJaContem,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("Preço: R\$ " + precoJaContem,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("\npor:"),
                  Text("\nEmpresa:" + empresaNaoContem,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("Preço: R\$" + precoNaoContem,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () async {
                              await db
                                  .collection("comprarDe")
                                  .doc(empresaJaContem)
                                  .collection("produtos")
                                  .doc(nomeProduto)
                                  .delete();

                              await db
                                  .collection("comprarDe")
                                  .doc(empresaNaoContem)
                                  .set({"empresa": empresaNaoContem});
                              await db
                                  .collection("comprarDe")
                                  .doc(empresaNaoContem)
                                  .collection("produtos")
                                  .doc(nomeProduto)
                                  .set({
                                "nomeProduto": nomeProduto,
                                "empresa": empresaNaoContem,
                                "preço": precoNaoContem,
                                "marca": marcaNaoContem,
                                "quantidadeDeCompra": quantidadeDeCompra,
                                "unidadeMedidaCompra": unidadeMedidaCompra
                              });

                              Navigator.pop(context);
                            },
                            child: Text("Sim",
                                style: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                            onPressed: () {
                              db
                                  .collection("comprarDe")
                                  .doc(empresaNaoContem)
                                  .collection("produtos")
                                  .doc(nomeProduto)
                                  .delete();
                              Navigator.of(context).pop();
                            },
                            child: Text("Não",
                                style: TextStyle(color: Colors.white))),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  comprarDe(String empresa, String nomeProduto, String preco, String marca,
      String quantidadeCompra, String unidadeMedidaCompra) async {
    db.collection("comprarDe").doc(empresa).set({"empresa": empresa});
    db
        .collection("comprarDe")
        .doc(empresa)
        .collection("produtos")
        .doc(nomeProduto)
        .set({
      "nomeProduto": nomeProduto,
      "empresa": empresa,
      "preço": preco,
      "marca": marca,
      "quantidadeDeCompra": quantidadeCompra,
      "unidadeMedidaCompra": unidadeMedidaCompra
    });

    var query = await db.collection("comprarDe").get();

    for (var doc in query.docs) {
      var query2 = await db
          .collection("comprarDe")
          .doc(doc['empresa'])
          .collection("produtos")
          .get();

      for (var doc2 in query2.docs) {
        if (doc2['nomeProduto'].contains(nomeProduto) &&
            doc['empresa'] != empresa) {
          _showDialogCompraProduto(
              nomeProduto,
              doc2['empresa'],
              doc2['preço'],
              empresa,
              preco,
              doc2['marca'],
              marca,
              quantidadeCompra,
              unidadeMedidaCompra);
        } else {
          db.collection("comprarDe").doc(empresa).set({"empresa": empresa});
          db
              .collection("comprarDe")
              .doc(empresa)
              .collection("produtos")
              .doc(nomeProduto)
              .set({
            "nomeProduto": nomeProduto,
            "empresa": empresa,
            "preço": preco,
            "marca": marca,
            "quantidadeDeCompra": quantidadeCompra,
            "unidadeMedidaCompra": unidadeMedidaCompra
          });
        }
      }
    }
    quantidadeDeCompra = "";
    unidadeMedidaComprarDe = "";
  }

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
            padding: EdgeInsets.only(top: 35, bottom: 20),
            child: Center(
              child: Text("Produtos Respondidos",
                  style: TextStyle(fontSize: 30, color: Colors.orange[300])),
            ),
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                  onChanged: (text) {
                    setState(() {
                      procuraProduto = text;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Pesquise um produto',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection("produtosRespondidoss").snapshots(),
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
                              margin: EdgeInsets.only(right: 65),
                              padding: EdgeInsets.only(top: 25),
                              child: Text(docSnapshot['nomeProduto'],
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange)),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: db
                                    .collection("produtosRespondidoss")
                                    .doc(docSnapshot['nomeProduto'])
                                    .collection("empresas")
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
                                          if (procuraProduto == '' ||
                                              docSnapshot2['nomeProduto']
                                                  .contains(procuraProduto)) {
                                            return AnimationConfiguration
                                                .staggeredList(
                                                    position: index,
                                                    delay: Duration(
                                                        milliseconds: 100),
                                                    child: SlideAnimation(
                                                        duration: Duration(
                                                            milliseconds: 2500),
                                                        curve: Curves
                                                            .fastLinearToSlowEaseIn,
                                                        child: FadeInAnimation(
                                                            curve: Curves
                                                                .fastLinearToSlowEaseIn,
                                                            duration: Duration(
                                                                milliseconds:
                                                                    2500),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .18,
                                                                    child: Card(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20.0),
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            new EdgeInsets.all(5),
                                                                        color:
                                                                            color,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              padding: new EdgeInsets.only(top: 7),
                                                                              child: Text(docSnapshot2['empresa'], style: TextStyle(fontSize: 15)),
                                                                            ),
                                                                            Container(
                                                                              padding: new EdgeInsets.all(2),
                                                                              child: Text(docSnapshot2['marca'], style: TextStyle(fontSize: 15)),
                                                                            ),
                                                                            Container(
                                                                              padding: new EdgeInsets.all(2),
                                                                              child: Text("R\$ " + docSnapshot2['preço'], style: TextStyle(fontSize: 15, color: Colors.orange[300])),
                                                                            ),
                                                                            Container(
                                                                              padding: new EdgeInsets.all(2),
                                                                              child: Text(docSnapshot2['unidadeMedida'], style: TextStyle(fontSize: 15)),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )),
                                                                Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .15,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .13,
                                                                    child:
                                                                        ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        quantidadeASerComprada(docSnapshot2['empresa'], docSnapshot2['nomeProduto']).then((value) => comprarDe(
                                                                            docSnapshot2['empresa'],
                                                                            docSnapshot2['nomeProduto'],
                                                                            docSnapshot2['preço'],
                                                                            docSnapshot2['marca'],
                                                                            quantidadeDeCompra,
                                                                            unidadeMedidaComprarDe));
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .attach_money,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ))
                                                              ],
                                                            ))));
                                          } else {
                                            return SizedBox();
                                          }
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
