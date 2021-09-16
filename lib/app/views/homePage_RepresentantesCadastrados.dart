import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'homePage_MenuCliente.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_InfoUser(title: 'Flutter App'),
    );
  }
}

// ignore: camel_case_types
class HomePage_InfoUser extends StatefulWidget {
  HomePage_InfoUser({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage_InfoUser> {
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
                    builder: (BuildContext context) => HomePage_MenuCliente()));
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
              child: Text("Usuários Cadastrados",
                  style: TextStyle(fontSize: 30, color: Colors.orange[300])),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("vendedor_")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnapshot =
                            snapshot.data!.docs[index];
                        return Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: new InkWell(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding:
                                                      new EdgeInsets.all(14),
                                                  child: Text(
                                                      docSnapshot['nome'],
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              Container(
                                                margin: new EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                child: Center(
                                                  child:
                                                      Text(docSnapshot['cnpj'],
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                child: Center(
                                                  child: Text(
                                                      docSnapshot['empresa'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                child: Center(
                                                  child:
                                                      Text(docSnapshot['email'],
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: new EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.90,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                child: Center(
                                                  child: Text(
                                                      docSnapshot['telefone'],
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      )),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomLeft:
                                                        const Radius.circular(
                                                            10.0),
                                                    bottomRight:
                                                        const Radius.circular(
                                                            10.0),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
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
                                                        child: Icon(Icons.save,
                                                            color: Colors.black,
                                                            size: 50)),
                                                    Container(
                                                        padding:
                                                            new EdgeInsets.only(
                                                                top: 20),
                                                        width: 75,
                                                        height: 75,
                                                        child: Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                            size: 50)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Card(
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
                                          children: [
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    left: 20),
                                                child: Text(docSnapshot['nome'],
                                                    style: TextStyle(
                                                        fontSize: 16))),
                                            Container(
                                                padding: new EdgeInsets.only(
                                                    left: 21),
                                                child: Text(
                                                    docSnapshot['telefone'],
                                                    style: TextStyle(
                                                        fontSize: 15))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator());
                }
              }),
          Center(
              child: Container(
                  padding: new EdgeInsets.all(20),
                  child: Text("Acabou! :D", style: TextStyle(fontSize: 20))))
        ],
      ),
    );
  }
}
