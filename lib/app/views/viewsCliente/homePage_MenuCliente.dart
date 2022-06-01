import 'package:alliance/app/views/homePage_Login.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'homePage_ComprarDe.dart';
import 'homePage_ComprasPassadas.dart';
import 'homePage_CotacoesAEnviar.dart';
import 'homePage_CadastroProdutos.dart';
import 'homePage_InfoCadastradas.dart';
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
  final DateTime date = DateTime.now();

  Future<void> _showDialogAlteraNomeProduto(
      String nomeProduto,
      String marca,
      String precoMaisAlto,
      String precoMaisBaixo,
      String unidadeMedida,
      String tipoProduto,
      String empresaPrecoAlto,
      String empresaPrecoBaixo) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text("Qual o novo nome?",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        nomeProduto,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextFormField(
                      initialValue: nomeProduto,
                      onChanged: (text) {
                        novoNomeProduto = text;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          icon: Icon(Icons.fastfood),
                          hintText: 'Novo Nome'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          primary: Colors.orange,
                          onPrimary: Colors.white),
                      onPressed: () {
                        editaNomeProduto(
                            nomeProduto,
                            novoNomeProduto,
                            marca,
                            precoMaisAlto,
                            precoMaisBaixo,
                            unidadeMedida,
                            tipoProduto,
                            empresaPrecoAlto,
                            empresaPrecoBaixo);

                        Navigator.of(context).pop();
                      },
                      child: Text("Salvar"),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

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
                    margin: new EdgeInsets.only(top: 20),
                    child: Text("Olá, " + nome + "!",
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold))),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * .8,
                  height: 3,
                  color: Colors.grey,
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.06),
                    child: Center(
                      child: Text('Produtos Cadastrados',
                          style: TextStyle(
                              fontSize: 26,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold)),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * .06,
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
                      labelText: 'Pesquise um produto',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                /*Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("Embalagens",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                ),*/
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: new EdgeInsets.only(top: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection("produtos_")
                          .orderBy("tipoProduto")
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

                                  if (procuraProduto == '' ||
                                      docSnapshot['nomeProduto']
                                          .contains(procuraProduto)) {
                                    return AnimationConfiguration.staggeredList(
                                        position: index,
                                        delay: Duration(milliseconds: 100),
                                        child: SlideAnimation(
                                            duration:
                                                Duration(milliseconds: 2500),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            child: FadeInAnimation(
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                duration: Duration(
                                                    milliseconds: 2500),
                                                child: Container(
                                                    child: new InkWell(
                                                        onTap: () {
                                                          showModalBottomSheet<
                                                              void>(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return ListView(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                                padding: new EdgeInsets.all(14),
                                                                                child: Text(docSnapshot['nomeProduto'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                                                                            Container(
                                                                              padding: new EdgeInsets.only(bottom: 5),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: new EdgeInsets.only(top: 10, left: 50),
                                                                                        width: 60,
                                                                                        height: 60,
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
                                                                                          margin: new EdgeInsets.only(
                                                                                            top: 10,
                                                                                            left: 50,
                                                                                          ),
                                                                                          child: Text("Deletar"))
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: new EdgeInsets.only(top: 10),
                                                                                        width: 60,
                                                                                        height: 60,
                                                                                        child: Ink(
                                                                                          decoration: const ShapeDecoration(
                                                                                            color: Colors.orange,
                                                                                            shape: CircleBorder(),
                                                                                          ),
                                                                                          child: IconButton(
                                                                                            icon: const Icon(Icons.edit),
                                                                                            color: Colors.white,
                                                                                            onPressed: () {
                                                                                              _showDialogAlteraNomeProduto(docSnapshot['nomeProduto'], docSnapshot['marca'], docSnapshot['precoMaisAlto'], docSnapshot['precoMaisBaixo'], docSnapshot['unidadeMedida'], docSnapshot['tipoProduto'], docSnapshot['empresaPrecoAlto'], docSnapshot['empresaPrecoBaixo']);
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(margin: new EdgeInsets.only(top: 10), child: Text("Editar"))
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: new EdgeInsets.only(top: 10),
                                                                                        width: 60,
                                                                                        height: 60,
                                                                                        child: Ink(
                                                                                          decoration: const ShapeDecoration(
                                                                                            color: Colors.orange,
                                                                                            shape: CircleBorder(),
                                                                                          ),
                                                                                          child: IconButton(
                                                                                            icon: const Icon(Icons.send),
                                                                                            color: Colors.white,
                                                                                            onPressed: () {
                                                                                              enviaParaPreCotacao(docSnapshot['nomeProduto'], docSnapshot['tipoProduto']);
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(margin: new EdgeInsets.only(top: 10), child: Text("Enviar"))
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: new EdgeInsets.only(top: 25, right: 50),
                                                                                        width: 60,
                                                                                        height: 60,
                                                                                        child: Ink(
                                                                                          decoration: const ShapeDecoration(
                                                                                            color: Colors.orange,
                                                                                            shape: CircleBorder(),
                                                                                          ),
                                                                                          child: IconButton(
                                                                                            icon: const Icon(Icons.send_and_archive_sharp),
                                                                                            color: Colors.white,
                                                                                            onPressed: () {
                                                                                              insereNaCotacao(docSnapshot['nomeProduto'], docSnapshot['tipoProduto']);
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                          margin: new EdgeInsets.only(top: 10, right: 50),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Text("Enivar"),
                                                                                              Text("Atrasado")
                                                                                            ],
                                                                                          ))
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: 10),
                                                                              child: Text("Preços desta cotação", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                                                            ),
                                                                            Container(
                                                                              child: Column(
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
                                                                                                    Container(margin: EdgeInsets.only(top: 5), width: MediaQuery.of(context).size.width * .85, height: 2, color: Colors.black45),
                                                                                                    Container(padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5), child: Text(docSnapshot2['empresa'], style: TextStyle(fontSize: 22, color: Colors.orange, fontWeight: FontWeight.bold))),
                                                                                                    Container(
                                                                                                      child: StreamBuilder<QuerySnapshot>(
                                                                                                          stream: db.collection("produtosRespondidosModal").doc(docSnapshot2['empresa']).collection("produtos").snapshots(),
                                                                                                          builder: (context, snapshot3) {
                                                                                                            if (snapshot3.hasData) {
                                                                                                              return ListView.builder(
                                                                                                                  physics: BouncingScrollPhysics(),
                                                                                                                  shrinkWrap: true,
                                                                                                                  itemCount: snapshot3.data!.docs.length,
                                                                                                                  itemBuilder: (context, index3) {
                                                                                                                    DocumentSnapshot docSnapshot3 = snapshot3.data!.docs[index3];
                                                                                                                    if (docSnapshot3['nomeProduto'] == docSnapshot['nomeProduto']) {
                                                                                                                      return Column(
                                                                                                                        children: [
                                                                                                                          Container(
                                                                                                                            margin: EdgeInsets.only(top: 5),
                                                                                                                            child: Text("Preço", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                                                          ),
                                                                                                                          Container(
                                                                                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                              height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                              child: Card(
                                                                                                                                shape: RoundedRectangleBorder(
                                                                                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                                                                                ),
                                                                                                                                child: Center(child: Text("R\$ " + docSnapshot3['preço'], style: TextStyle(fontSize: 18, color: Colors.orange))),
                                                                                                                              )),
                                                                                                                          Container(
                                                                                                                            margin: EdgeInsets.only(top: 5),
                                                                                                                            child: Text("Marca", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                                                          ),
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
                                                                                                                            margin: EdgeInsets.only(top: 5),
                                                                                                                            child: Text("Unidade de Medida", style: TextStyle(fontWeight: FontWeight.bold)),
                                                                                                                          ),
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
                                                                                                                    } else {
                                                                                                                      return SizedBox();
                                                                                                                    }
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
                                                                  height: 35,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              12),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                          mainAxisAlignment: MainAxisAlignment
                                                                              .spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              child: Center(
                                                                                child: Text("R\$ " + docSnapshot['precoMaisBaixo'], style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold)),
                                                                              ),
                                                                              decoration: new BoxDecoration(
                                                                                color: Colors.green,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: const Radius.circular(8.0),
                                                                                  topRight: const Radius.circular(8.0),
                                                                                  bottomLeft: const Radius.circular(8.0),
                                                                                  bottomRight: const Radius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.3,
                                                                              child: Center(
                                                                                child: Text(
                                                                                  "R\$ " + docSnapshot['precoMaisAlto'],
                                                                                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              decoration: new BoxDecoration(
                                                                                color: Colors.red,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: const Radius.circular(8.0),
                                                                                  topRight: const Radius.circular(8.0),
                                                                                  bottomLeft: const Radius.circular(8.0),
                                                                                  bottomRight: const Radius.circular(8.0),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ]),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 5),
                                                                            child:
                                                                                Text(
                                                                              docSnapshot['empresaPrecoBaixo'],
                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              padding: EdgeInsets.only(left: 15),
                                                                              child: Text(docSnapshot['empresaPrecoAlto'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ))))));
                                  } else {
                                    return SizedBox();
                                  } /////////////////////////////////////////////////////////////////////////////////////
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
                                HomePage_Cotacoes()));
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
                  label: 'Cotações Anteriores',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_CotacoesPassadas()));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Lista de Compras',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_ComprarDe(
                                  title: "ALLIANCE",
                                )));
                  }),
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Compras Anteriores',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_ComprasPassadas(title: "ALLIANCE")));
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
              SpeedDialChild(
                  child: Icon(Icons.add, color: Colors.orange),
                  label: 'Sair',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                HomePage_Login(title: "ALLIANCE")));
                  }),
            ]));
  }
}
