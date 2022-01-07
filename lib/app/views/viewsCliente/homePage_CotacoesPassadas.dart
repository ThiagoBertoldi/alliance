// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homePage_MenuCliente.dart';
import 'homePage_exibeCotacoes.dart';

// ignore: camel_case_types
class HomePage_CotacoesPassadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: CotacoesPassadas_State(title: "ALLIANCE"),
    );
  }
}

// ignore: camel_case_types
class CotacoesPassadas_State extends StatefulWidget {
  CotacoesPassadas_State({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState_EsqueciSenha createState() =>
      _MyHomePageState_EsqueciSenha();
}

class _MyHomePageState_EsqueciSenha extends State<CotacoesPassadas_State> {
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
                        MenuCliente_State(title: 'ALLIANCE')));
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Text("Últimas cotações",
                      style: TextStyle(fontSize: 30, color: Colors.orange)),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: db.collection("cotacoesPassadas").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docSnapshot =
                                snapshot.data!.docs[index];
                            return Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: InkWell(
                                    onTap: () {
                                      cotacaoSelecionada =
                                          docSnapshot['dataHora'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomePage_ExibeCotacoes(
                                                    title: docSnapshot[
                                                        'dataHora'])),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Cotação Finalizada em",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(docSnapshot['dataHora'],
                                              style: TextStyle(fontSize: 17)),
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
          )
        ],
      ),
    );
  }
}
