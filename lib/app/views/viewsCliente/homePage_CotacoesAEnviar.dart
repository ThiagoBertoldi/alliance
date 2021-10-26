// ignore: unused_import
import 'package:alliance/app/views/homePage_Login.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PaginaCadastroProdutos());
}

// ignore: camel_case_types
class PaginaCadastroProdutos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_Cotacoes(
        title: 'ALLIANCE',
      ),
    );
  }
}

// ignore: camel_case_types
class HomePage_Cotacoes extends StatefulWidget {
  HomePage_Cotacoes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_Cotacoes createState() => _MyHomePageState_Cotacoes();
}

// ignore: camel_case_types
class _MyHomePageState_Cotacoes extends State<HomePage_Cotacoes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          AnimationConfiguration.staggeredGrid(
              position: 1,
              duration: Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                  duration: Duration(milliseconds: 900),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: FadeInAnimation(
                      child: Container(
                    padding: new EdgeInsets.all(30),
                    child: Center(
                      child: Text("Produtos a enviar para cotação",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.orange)),
                    ),
                  )))),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("produtosParaCotacao")
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
                                    duration: Duration(milliseconds: 2500),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    child: FadeInAnimation(
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        duration: Duration(milliseconds: 2500),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 75,
                                              child: new InkWell(
                                                onTap: () {
                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return ListView(
                                                          children: [
                                                            Container(
                                                              child: Center(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                        padding:
                                                                            new EdgeInsets.all(
                                                                                14),
                                                                        child: Text(
                                                                            docSnapshot[
                                                                                'nomeProduto'],
                                                                            style:
                                                                                TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                                                                    Container(
                                                                      padding: new EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              20),
                                                                      width: 75,
                                                                      height:
                                                                          75,
                                                                      child:
                                                                          Ink(
                                                                        decoration:
                                                                            const ShapeDecoration(
                                                                          color:
                                                                              Colors.orange,
                                                                          shape:
                                                                              CircleBorder(),
                                                                        ),
                                                                        child:
                                                                            IconButton(
                                                                          icon:
                                                                              const Icon(Icons.remove_sharp),
                                                                          color:
                                                                              Colors.white,
                                                                          onPressed:
                                                                              () {
                                                                            reomoveDaPreCotacao(docSnapshot['nomeProduto']);
                                                                          },
                                                                        ),
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
                                                  shape: RoundedRectangleBorder(
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                              docSnapshot[
                                                                  'nomeProduto'],
                                                              style: TextStyle(
                                                                  fontSize: 19,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))));
                          }));
                } else {
                  return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator());
                }
              }),
          Column(
            children: [
              Container(
                margin: new EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  child: Text(
                    'Resetar Cotação',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    resetaCotacao();
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                margin: new EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  child: Text(
                    'Enviar para Cotação',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {
                    enviaParaCotacao();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
