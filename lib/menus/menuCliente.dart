// ignore: unused_import
import 'package:alliance/Paginas/paginaLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MenuCliente());
}

class MenuCliente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MenuCliente_State(title: 'Menu Principal'),
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

dynamic imprimeDados() async {
  var query = await FirebaseFirestore.instance.collection("produtos_").get();
  for (var doc in query.docs) {
    print(doc['nomeProduto']);
    print(doc['marca']);
    print(doc['preço']);
    print(doc['unidadeMedida']);
  }
}

class _MyHomePageState_MenuCliente extends State<MenuCliente_State> {
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
                child: Text('Últimos Produtos Cadastrados',
                    style: TextStyle(fontSize: 24, color: Colors.orange)),
              )),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.04),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
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
                                padding: new EdgeInsets.all(14),
                                child: Text("Produto",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold))),
                            Container(
                              padding: new EdgeInsets.only(left: 70, right: 70),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                      child: Text("Preço mais baixo:",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                  Text('R\$ 10,00',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green))
                                ],
                              ),
                            ),
                            Container(
                              margin: new EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text("Produpan",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              decoration: new BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                ),
                              ),
                            ),
                            Container(
                              margin: new EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text("UN",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              decoration: new BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                ),
                              ),
                            ),
                            Container(
                              margin: new EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Center(
                                child: Text("Fleischman",
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              decoration: new BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                ),
                              ),
                            ),
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
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.04,
                    left: MediaQuery.of(context).size.width * 0.04,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text("Produto ",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold))),
                          Text('R\$ 100,00',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: new EdgeInsets.only(left: 5, top: 7),
                              child: Text("Unidade",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            child: Container(
                                padding: new EdgeInsets.only(top: 5),
                                child: Text('R\$ 150,00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
                          ),
                        ],
                      ),
                      Container(
                        padding: new EdgeInsets.all(5),
                        child: Text("Marca",
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
          )
        ],
      ),
    );
  }
}
