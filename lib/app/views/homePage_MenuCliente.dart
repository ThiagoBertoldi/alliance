// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homePage_CadastroProdutos.dart';

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

void atualizaDados() async {
  var db = FirebaseFirestore.instance;
  var query = await db.collection("produtos_").get();
  for (var doc in query.docs) {
    print(doc['nomeProduto']);
    print(doc['marca']);
    print(doc['preço']);
    print(doc['unidadeMedida']);
    print("///////////////////////");
  }
}

class _MyHomePageState_MenuCliente extends State<MenuCliente_State> {
  var db = FirebaseFirestore.instance;

  String preco = '';
  String empresa = '';
  String marca = '';
  String unidadeMedida = '';

  void deletaProduto(String nomeProduto) {
    db.collection("produtos_").doc(nomeProduto).delete();
  }

  void atualizaProduto(
      String nomeProduto, String preco, String unidadeMedida, String marca) {
    db.collection("produtos_").doc(nomeProduto).set({
      "nomeProduto": nomeProduto,
      "marca": marca,
      "unidadeMedida": unidadeMedida,
      "preço": preco
    }).then((value) => print("Atualizado com Sucesso!!"));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.025),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.225,
                  child: Card(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Produtos',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '152',
                            style: TextStyle(fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1125,
                      child: Card(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Cotações respondidas',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '16',
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.1125,
                      child: Card(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fornecedores cadastrados',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                '14',
                                style: TextStyle(fontSize: 19),
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
                  top: MediaQuery.of(context).size.width * 0.06),
              child: Center(
                child: Text('Produtos Cadastrados',
                    style: TextStyle(fontSize: 24, color: Colors.orange)),
              )),
          Container(
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePage_CadastroProdutos(
                                title: 'ALLIANCE',
                              )));
                },
                child: Text("Adicionar Produto",
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
          ),
          Container(
            padding: new EdgeInsets.only(top: 20),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("produtos_")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docSnapshot =
                                snapshot.data!.docs[index];
                            return Container(
                              child: new InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ListView(children: [
                                        Container(
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.all(14),
                                                    child: Text(
                                                        docSnapshot[
                                                            'nomeProduto'],
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                Container(
                                                  padding: new EdgeInsets.only(
                                                      left: 70, right: 70),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                          child: Text(
                                                              "Preço mais baixo:",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Text(
                                                          "R\$ " +
                                                              docSnapshot[
                                                                  'preço'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.green))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: new EdgeInsets.only(
                                                      top: 10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.90,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  child: Center(
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (text) {
                                                        preco = text;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: '{{empresa}}',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: new EdgeInsets.only(
                                                      top: 10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.90,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  child: Center(
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (text) {
                                                        preco = text;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "R\$ " +
                                                            docSnapshot[
                                                                'preço'],
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: new EdgeInsets.only(
                                                      top: 10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.90,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  child: Center(
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (text) {
                                                        marca = text;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: docSnapshot[
                                                            'marca'],
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: new EdgeInsets.only(
                                                      top: 10),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.90,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.07,
                                                  child: Center(
                                                    child: TextFormField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      onChanged: (text) {
                                                        unidadeMedida = text;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: docSnapshot[
                                                            'unidadeMedida'],
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                  decoration: new BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      topRight:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomLeft:
                                                          const Radius.circular(
                                                              15.0),
                                                      bottomRight:
                                                          const Radius.circular(
                                                              15.0),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          new EdgeInsets.only(
                                                              top: 20),
                                                      width: 75,
                                                      height: 75,
                                                      child: Ink(
                                                        decoration:
                                                            const ShapeDecoration(
                                                          color: Colors.orange,
                                                          shape: CircleBorder(),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.save),
                                                          color: Colors.white,
                                                          onPressed: () {
                                                            atualizaProduto(
                                                                docSnapshot[
                                                                    'nomeProduto'],
                                                                preco,
                                                                unidadeMedida,
                                                                marca);
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          new EdgeInsets.only(
                                                              top: 20),
                                                      width: 75,
                                                      height: 75,
                                                      child: Ink(
                                                        decoration:
                                                            const ShapeDecoration(
                                                          color: Colors.black,
                                                          shape: CircleBorder(),
                                                        ),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.delete),
                                                          color: Colors.white,
                                                          onPressed: () {
                                                            deletaProduto(
                                                                docSnapshot[
                                                                    'nomeProduto']);
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
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
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                                child: Container(
                                              child: Text(
                                                  docSnapshot['nomeProduto'],
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )),
                                            Text("R\$ " + docSnapshot['preço'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                padding: new EdgeInsets.only(
                                                    left: 5, top: 7),
                                                child: Text(
                                                    docSnapshot[
                                                        'unidadeMedida'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            Container(
                                              child: Container(
                                                  padding: new EdgeInsets.only(
                                                      top: 5),
                                                  child: Text(
                                                      "R\$ " +
                                                          docSnapshot['preço'],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red))),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: new EdgeInsets.all(5),
                                          child: Text(docSnapshot['marca'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded, color: Colors.white),
        backgroundColor: Colors.orange[300],
      ),
    );
  }
}
