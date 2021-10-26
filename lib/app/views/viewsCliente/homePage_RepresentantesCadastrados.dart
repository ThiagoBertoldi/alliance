import 'package:alliance/firebase_script/scripts.dart';
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
  var db = FirebaseFirestore.instance;

  String telefone = '';
  String empresa = '';
  String email = '';
  String nome = '';
  String cnpj = '';

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
              stream: db.collection("vendedor_").snapshots(),
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
                                                  child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    onChanged: (text) {
                                                      empresa = text;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: docSnapshot[
                                                          'empresa'],
                                                    ),
                                                  ),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
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
                                                  child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    onChanged: (text) {
                                                      cnpj = text;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          docSnapshot['cnpj'],
                                                    ),
                                                  ),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
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
                                                  child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          docSnapshot['email'],
                                                    ),
                                                  ),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
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
                                                  child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    onChanged: (text) {
                                                      telefone = text;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: docSnapshot[
                                                          'telefone'],
                                                    ),
                                                  ),
                                                ),
                                                decoration: new BoxDecoration(
                                                  color: Colors.grey[200],
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
                                                            atualizaDadosRepresentante(
                                                                empresa,
                                                                cnpj,
                                                                telefone,
                                                                docSnapshot[
                                                                    'nome']);
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
                                                            deletaUsuario(
                                                                docSnapshot[
                                                                    'nome']);
                                                          },
                                                        ),
                                                      ),
                                                    ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
