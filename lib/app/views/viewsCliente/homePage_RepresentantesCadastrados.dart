import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'homePage_MenuCliente.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_RepresentantesCadastrados(title: 'ALLIANCE'),
    );
  }
}

// ignore: camel_case_types
class HomePage_RepresentantesCadastrados extends StatefulWidget {
  HomePage_RepresentantesCadastrados({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_RepresentantesCadastrados> {
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
        body: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              padding: new EdgeInsets.all(40),
              child: Center(
                child: Text("Usuários Cadastrados",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.orange[300],
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: db.collection("vendedor_").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot docSnapshot =
                                  snapshot.data!.docs[index];
                              return Column(
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      color: Colors.white,
                                      child: Container(
                                        padding: new EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            new Image.asset(
                                              'images/user.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            left: 20),
                                                    child: Text(
                                                        docSnapshot['nome'],
                                                        style: TextStyle(
                                                            fontSize: 16))),
                                                Container(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            left: 21),
                                                    child: Text(
                                                        docSnapshot['email'],
                                                        style: TextStyle(
                                                            fontSize: 15))),
                                              ],
                                            ),
                                          ],
                                        ),
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
        ));
  }
}
