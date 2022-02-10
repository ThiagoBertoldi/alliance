import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homePage_ExibeComprasPassadas.dart';
import 'homePage_MenuCliente.dart';

// ignore: camel_case_types
class HomePage_ComprasPassadas extends StatefulWidget {
  HomePage_ComprasPassadas({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState_ComprasPassadas createState() =>
      _HomePageState_ComprasPassadas();
}

// ignore: camel_case_types
class _HomePageState_ComprasPassadas extends State<HomePage_ComprasPassadas> {
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
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text("Compras realizadas anteriormente",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection("comprasPassadas").snapshots(),
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
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .9,
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  child: InkWell(
                                      onTap: () {
                                        compraAntigaSelecionada =
                                            docSnapshot['dataHora'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ComprasPassadas_State(
                                                      title: docSnapshot[
                                                          'dataHora'])),
                                        );
                                      },

                                      //compraAntigaSelecionada
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        color: Colors.white,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Text(
                                                    "Data e Hora da emissão do relatório"),
                                              ),
                                              Container(
                                                child: Text(
                                                  docSnapshot['dataHora'],
                                                  style: TextStyle(
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            );
                          }));
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
