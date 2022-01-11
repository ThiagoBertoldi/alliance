import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'homePage_MenuRepresentanteMateriaPrima.dart';

class PaginaRepondeCotacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePageState_ResponderCotacao(
        title: 'ALLIANCE',
      ),
    );
  }
}

// ignore: camel_case_types
class HomePageState_ResponderCotacao extends StatefulWidget {
  HomePageState_ResponderCotacao({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  HomePage_ResponderCotacao createState() => HomePage_ResponderCotacao();
}

// ignore: camel_case_types
class HomePage_ResponderCotacao extends State<HomePageState_ResponderCotacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PaginaRepresentanteMateriaPrima()));
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      body: ListView(
        children: [
          Container(
              padding: new EdgeInsets.all(30),
              child: Text(
                "Produtos para Responder: ",
                style: TextStyle(fontSize: 26, color: Colors.orange),
                textAlign: TextAlign.center,
              )),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("produtosEmCotacao")
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
                            if (docSnapshot['tipoProduto'] == tipoUsuario) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  delay: Duration(milliseconds: 100),
                                  child: SlideAnimation(
                                      duration: Duration(milliseconds: 2500),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: FadeInAnimation(
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          duration:
                                              Duration(milliseconds: 2500),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.95,
                                                height: 75,
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
                                                                              20),
                                                                          child: Text(
                                                                              docSnapshot['nomeProduto'],
                                                                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
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
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            onChanged:
                                                                                (text) {
                                                                              preco = text;
                                                                            },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              hintText: "Preço",
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
                                                                              hintText: "Marca",
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
                                                                              hintText: "Unidade de Medida",
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
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            75,
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                15),
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.orange,
                                                                          child:
                                                                              IconButton(
                                                                            icon:
                                                                                const Icon(Icons.done, color: Colors.white),
                                                                            onPressed:
                                                                                () {
                                                                              respondeCotacao(docSnapshot['nomeProduto'], preco, marca, unidadeMedida, empresa);
                                                                              preco = '';
                                                                              marca = '';
                                                                              unidadeMedida = '';
                                                                              Navigator.of(context).pop();
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
                                                                    fontSize:
                                                                        19,
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
                            } else {
                              return SizedBox();
                            }
                          }));
                } else {
                  return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
