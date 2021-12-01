import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'homePage_CotacoesAEnviar.dart';
import 'homePage_CadastroProdutos.dart';
import '../homePage_InfoCadastradas.dart';
import 'homePage_CotacoesPassadas.dart';
import 'homePage_ProdutosRespondidos.dart';
import 'homePage_RepresentantesCadastrados.dart';

// ignore: camel_case_types
class MenuCliente_State extends StatefulWidget {
  MenuCliente_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_MenuCliente createState() => _MyHomePageState_MenuCliente();
}

// ignore: camel_case_types
class _MyHomePageState_MenuCliente extends State<MenuCliente_State> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Container(
                    margin: new EdgeInsets.only(top: 15),
                    child: Text("Olá, " + userName + "!",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold))),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.06),
                    child: Center(
                      child: Text('Produtos Cadastrados',
                          style: TextStyle(fontSize: 20, color: Colors.orange)),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200]),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        procuraProduto = text;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      labelText: 'Pesquise um produto',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: new EdgeInsets.only(top: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection("produtos_").snapshots(),
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
                                  return AnimationConfiguration.staggeredList(
                                      position: index,
                                      delay: Duration(milliseconds: 100),
                                      child: SlideAnimation(
                                          duration:
                                              Duration(milliseconds: 2500),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: FadeInAnimation(
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              duration:
                                                  Duration(milliseconds: 2500),
                                              child: Container(
                                                  child: new InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet<
                                                            void>(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return ListView(
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                              padding: new EdgeInsets.all(14),
                                                                              child: Text(docSnapshot['nomeProduto'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                                                                          Container(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                StreamBuilder<QuerySnapshot>(
                                                                                    stream: db.collection("produtosRespondidos").snapshots(),
                                                                                    builder: (context, snapshot2) {
                                                                                      if (snapshot2.hasData) {
                                                                                        return ListView.builder(
                                                                                            physics: BouncingScrollPhysics(),
                                                                                            shrinkWrap: true,
                                                                                            itemCount: snapshot2.data!.docs.length,
                                                                                            itemBuilder: (context, index2) {
                                                                                              DocumentSnapshot docSnapshot2 = snapshot2.data!.docs[index2];
                                                                                              return Column(
                                                                                                children: [
                                                                                                  Container(padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5), child: Text(docSnapshot2['empresa'], style: TextStyle(fontSize: 22, color: Colors.orange, fontWeight: FontWeight.bold))),
                                                                                                  Container(
                                                                                                    child: StreamBuilder<QuerySnapshot>(
                                                                                                        stream: db.collection("produtosRespondidosModal").doc(docSnapshot2['empresa']).collection(docSnapshot['nomeProduto']).snapshots(),
                                                                                                        builder: (context, snapshot3) {
                                                                                                          if (snapshot3.hasData) {
                                                                                                            return ListView.builder(
                                                                                                                physics: BouncingScrollPhysics(),
                                                                                                                shrinkWrap: true,
                                                                                                                itemCount: snapshot3.data!.docs.length,
                                                                                                                itemBuilder: (context, index3) {
                                                                                                                  DocumentSnapshot docSnapshot3 = snapshot3.data!.docs[index3];

                                                                                                                  return Column(
                                                                                                                    children: [
                                                                                                                      Container(
                                                                                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                          height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                          child: Card(
                                                                                                                            shape: RoundedRectangleBorder(
                                                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                                                            ),
                                                                                                                            child: Center(child: Text(docSnapshot3['preço'], style: TextStyle(fontSize: 18))),
                                                                                                                          )),
                                                                                                                      Container(
                                                                                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                          height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                          child: Card(
                                                                                                                            shape: RoundedRectangleBorder(
                                                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                                                            ),
                                                                                                                            child: Center(child: Text(docSnapshot3['marca'], style: TextStyle(fontSize: 16))),
                                                                                                                          )),
                                                                                                                      Container(
                                                                                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                          height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                          child: Card(
                                                                                                                            shape: RoundedRectangleBorder(
                                                                                                                              borderRadius: BorderRadius.circular(15.0),
                                                                                                                            ),
                                                                                                                            child: Center(child: Text(docSnapshot3['unidadeMedida'], style: TextStyle(fontSize: 16))),
                                                                                                                          )),
                                                                                                                    ],
                                                                                                                  );
                                                                                                                });
                                                                                                          } else {
                                                                                                            return CircularProgressIndicator();
                                                                                                          }
                                                                                                        }),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      } else {
                                                                                        return CircularProgressIndicator();
                                                                                      }
                                                                                    })
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                new EdgeInsets.only(bottom: 5),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Container(
                                                                                  padding: new EdgeInsets.only(top: 20),
                                                                                  width: 75,
                                                                                  height: 75,
                                                                                  child: Ink(
                                                                                    decoration: const ShapeDecoration(
                                                                                      color: Colors.black,
                                                                                      shape: CircleBorder(),
                                                                                    ),
                                                                                    child: IconButton(
                                                                                      icon: const Icon(Icons.delete),
                                                                                      color: Colors.white,
                                                                                      onPressed: () {
                                                                                        deletaProduto(docSnapshot['nomeProduto']);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  padding: new EdgeInsets.only(top: 20),
                                                                                  width: 75,
                                                                                  height: 75,
                                                                                  child: Ink(
                                                                                    decoration: const ShapeDecoration(
                                                                                      color: Colors.orange,
                                                                                      shape: CircleBorder(),
                                                                                    ),
                                                                                    child: IconButton(
                                                                                      icon: const Icon(Icons.send),
                                                                                      color: Colors.white,
                                                                                      onPressed: () {
                                                                                        enviaParaPreCotacao(docSnapshot['nomeProduto']);
                                                                                        Navigator.of(context).pop();
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ]);
                                                          },
                                                        );
                                                      },
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
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                docSnapshot[
                                                                    'nomeProduto'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.7,
                                                                height: 25,
                                                                margin:
                                                                    new EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            10),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              docSnapshot['unidadeMedida'],
                                                                              style: TextStyle(fontSize: 15, color: Colors.black)),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            docSnapshot['unidadeMedida'],
                                                                            style:
                                                                                TextStyle(fontSize: 15, color: Colors.black),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.7,
                                                                height: 25,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        child:
                                                                            Center(
                                                                          child: Text(
                                                                              docSnapshot['precoMaisBaixo'],
                                                                              style: TextStyle(fontSize: 15, color: Colors.white)),
                                                                        ),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.green,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(8.0),
                                                                            topRight:
                                                                                const Radius.circular(8.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(8.0),
                                                                            bottomRight:
                                                                                const Radius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            docSnapshot['precoMaisAlto'],
                                                                            style:
                                                                                TextStyle(fontSize: 15, color: Colors.white),
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.red,
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(8.0),
                                                                            topRight:
                                                                                const Radius.circular(8.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(8.0),
                                                                            bottomRight:
                                                                                const Radius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ]),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ))))));
                                }),
                          );
                        } else {
                          return Align(
                              alignment: FractionalOffset.bottomCenter,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
            backgroundColor: Colors.orange,
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: Colors.white,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Cadastrar um Produto',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_CadastroProdutos(title: "ALLIANCE")));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Enviar uma Cotação',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_Cotacoes(title: "ALLIANCE")));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Cotações Respondidas',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_ProdutosRespondidos(
                                    title: "ALLIANCE")));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Cotações Passadas',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_CotacoesPassadas()));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Representantes Cadastrados',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_RepresentantesCadastrados(
                                    title: "ALLIANCE")));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Informações Pessoais',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_InfoCadastradas(title: "ALLIANCE")));
                  }),
            ]));

    /*    FloatingActionButton(
            child: Icon(
              Icons.question_answer,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_CotacoesResponder(title: "ALLIANCE")));
            },
            heroTag: null,
          ),
    )*/
  }
}
