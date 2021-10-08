// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_CotacoesAResponder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'homePage_CotacoesAEnviar.dart';
import 'homePage_CadastroProdutos.dart';
import '../homePage_InfoCadastradas.dart';
import 'homePage_ProdutosRespondidos.dart';
import 'homePage_RepresentantesCadastrados.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(HomePage_MenuCliente());
}

class HomePage_MenuCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MenuCliente_State(title: "ALLIANCE"),
    );
  }
}

// ignore: camel_case_types
class MenuCliente_State extends StatefulWidget {
  MenuCliente_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_MenuCliente createState() => _MyHomePageState_MenuCliente();
}

class _MyHomePageState_MenuCliente extends State<MenuCliente_State> {
  var db = FirebaseFirestore.instance;
  int count = 0;
  String procuraProduto = '';
  String preco = '';
  String empresa = '';
  String marca = '';
  String unidadeMedida = '';

  void deletaProduto(String nomeProduto) {
    db.collection("produtos_").doc(nomeProduto).delete();
  }

  void atualizaProduto(String nomeProduto, String unidadeMedida, String marca,
      String precoMaisAlto, String precoMaisBaixo) {
    if (unidadeMedida == '') {
      unidadeMedida = "sem unidade de medida";
    }
    if (marca == '') {
      marca = "sem marca";
    }
    if (precoMaisAlto == '') {
      precoMaisAlto = "sem preço";
    }
    if (precoMaisBaixo == '') {
      precoMaisBaixo = "sem preço";
    }

    print(marca);
    db.collection("produtos_").doc(nomeProduto).set({
      "nomeProduto": nomeProduto,
      "marca": marca,
      "unidadeMedida": unidadeMedida,
      "precoMaisAlto": precoMaisAlto,
      "precoMaisBaixo": precoMaisBaixo
    }).then((value) => print("Atualizado com Sucesso!!"));
  }

  void enviaParaCotacao(String nomeProduto) {
    db
        .collection("produtosParaCotacao")
        .doc(nomeProduto)
        .set({"nomeProduto": nomeProduto});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage_Login(
                            title: 'ALLIANCE',
                          )));
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("produtos_")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: Duration(milliseconds: 500),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                      duration: Duration(milliseconds: 900),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.025),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.35,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.225,
                                                    child: Card(
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Produtos',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "$count",
                                                              style: TextStyle(
                                                                  fontSize: 19),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1125,
                                                        child: Card(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Cotações respondidas',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Text(
                                                                  '$count',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1125,
                                                        child: Card(
                                                          child: Container(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Fornecedores cadastrados',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Text(
                                                                  "$count",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.06),
                                                child: Center(
                                                  child: Text(
                                                      'Produtos Cadastrados',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                              Colors.orange)),
                                                )),
                                            Container(
                                              height: 60,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: TextField(
                                                onChanged: (text) {
                                                  procuraProduto = text;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Pesquise um Produto',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )));
                            }));
                  } else {
                    return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(child: CircularProgressIndicator()));
                  }
                }),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: new EdgeInsets.only(top: 20),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("produtos_")
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
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return ListView(
                                                            children: [
                                                              Container(
                                                                child: Center(
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                          padding: new EdgeInsets.all(
                                                                              14),
                                                                          child: Text(
                                                                              docSnapshot['nomeProduto'],
                                                                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                                                                      Container(
                                                                        padding: new EdgeInsets.only(
                                                                            left:
                                                                                70,
                                                                            right:
                                                                                70),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: <
                                                                              Widget>[
                                                                            Expanded(child: Text("Preço mais baixo:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                                                                            Text("R\$ " + docSnapshot['precoMaisBaixo'],
                                                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: new EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.90,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.07,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextField(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onChanged:
                                                                                (text) {
                                                                              preco = text;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: '{{empresa}}',
                                                                              border: InputBorder.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(15.0),
                                                                            topRight:
                                                                                const Radius.circular(15.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(15.0),
                                                                            bottomRight:
                                                                                const Radius.circular(15.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.90,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.07,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextFormField(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onChanged:
                                                                                (text) {
                                                                              marca = text;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: docSnapshot['marca'],
                                                                              border: InputBorder.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(15.0),
                                                                            topRight:
                                                                                const Radius.circular(15.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(15.0),
                                                                            bottomRight:
                                                                                const Radius.circular(15.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: new EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.90,
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.07,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              TextFormField(
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onChanged:
                                                                                (text) {
                                                                              unidadeMedida = text;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: docSnapshot['unidadeMedida'],
                                                                              border: InputBorder.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            new BoxDecoration(
                                                                          color:
                                                                              Colors.grey[200],
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                const Radius.circular(15.0),
                                                                            topRight:
                                                                                const Radius.circular(15.0),
                                                                            bottomLeft:
                                                                                const Radius.circular(15.0),
                                                                            bottomRight:
                                                                                const Radius.circular(15.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                new EdgeInsets.only(top: 20),
                                                                            width:
                                                                                75,
                                                                            height:
                                                                                75,
                                                                            child:
                                                                                Ink(
                                                                              decoration: const ShapeDecoration(
                                                                                color: Colors.orange,
                                                                                shape: CircleBorder(),
                                                                              ),
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.save),
                                                                                color: Colors.white,
                                                                                onPressed: () {
                                                                                  atualizaProduto(docSnapshot['nomeProduto'], unidadeMedida, marca, docSnapshot['precoMaisAlto'], docSnapshot['precoMaisBaixo']);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                new EdgeInsets.only(top: 20),
                                                                            width:
                                                                                75,
                                                                            height:
                                                                                75,
                                                                            child:
                                                                                Ink(
                                                                              decoration: const ShapeDecoration(
                                                                                color: Colors.black,
                                                                                shape: CircleBorder(),
                                                                              ),
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.delete),
                                                                                color: Colors.white,
                                                                                onPressed: () {
                                                                                  deletaProduto(docSnapshot['nomeProduto']);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                new EdgeInsets.only(top: 20),
                                                                            width:
                                                                                75,
                                                                            height:
                                                                                75,
                                                                            child:
                                                                                Ink(
                                                                              decoration: const ShapeDecoration(
                                                                                color: Colors.orange,
                                                                                shape: CircleBorder(),
                                                                              ),
                                                                              child: IconButton(
                                                                                icon: const Icon(Icons.send),
                                                                                color: Colors.white,
                                                                                onPressed: () {
                                                                                  enviaParaCotacao(docSnapshot['nomeProduto']);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
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
                                                          BorderRadius.circular(
                                                              20.0),
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                child: Text(
                                                                    docSnapshot[
                                                                        'nomeProduto'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            19,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              )),
                                                              Text(
                                                                  "R\$ " +
                                                                      docSnapshot[
                                                                          'precoMaisBaixo'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .green))
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  padding: new EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      top: 7),
                                                                  child: Text(
                                                                      docSnapshot[
                                                                          'marca'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .black54,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Container(
                                                                    padding: new EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                    child: Text(
                                                                        "R\$ " +
                                                                            docSnapshot[
                                                                                'precoMaisBaixo'],
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.red))),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            padding:
                                                                new EdgeInsets
                                                                    .all(5),
                                                            child: Text(
                                                                docSnapshot[
                                                                    'unidadeMedida'],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ))));
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
        floatingActionButton:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            child: Icon(
              Icons.bookmark_add_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_Cotacoes(title: "ALLIANCE")));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_CadastroProdutos(title: "ALLIANCE")));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.add_business,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_RepresentantesCadastrados(
                              title: "ALLIANCE")));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.info,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_InfoCadastradas(title: "ALLIANCE")));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
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
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.all_inbox,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage_ProdutosRespondidos(title: "ALLIANCE")));
            },
            heroTag: null,
          ),
          SizedBox(
            height: 10,
          ),
        ]));
  }
}
