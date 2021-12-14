import 'package:alliance/app/views/homePage_Login.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homePage_RespondeCotacao.dart';

class PaginaRepresentante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_MenuRepresentante(
        title: 'ALLIANCE',
      ),
    );
  }
}

// ignore: camel_case_types
class HomePage_MenuRepresentante extends StatefulWidget {
  HomePage_MenuRepresentante({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_MenuRepresentante> {
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
                    builder: (BuildContext context) => HomePage_Login(
                          title: "Alliance",
                        )));
          },
          child: Icon(
            Icons.arrow_back,

            // add custom icons also
          ),
        ),
        // automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: ListView(
            children: [
              Container(
                padding: new EdgeInsets.all(30),
                child: Center(
                  child: Text("Cotações a Responder",
                      style:
                          TextStyle(fontSize: 28, color: Colors.orange[300])),
                ),
              ),
              Container(
                  child: Center(
                      child: new InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePageState_ResponderCotacao(
                                title: 'ALLIANCE',
                              )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .95,
                  height: MediaQuery.of(context).size.height * .1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cotação Semanal",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ))),
              Container(
                padding: new EdgeInsets.all(30),
                child: Center(
                  child: Text("Cotações Finalizadas em",
                      style:
                          TextStyle(fontSize: 28, color: Colors.orange[300])),
                ),
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: db.collection("cotacoesPassadas").snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc =
                                    snapshot.data!.docs[index];
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          .95,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(doc['dataHora'],
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
