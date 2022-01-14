import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_MenuRepresentanteEmbalagem.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_MenuRepresentanteMateriaPrima.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_MenuRepresentanteMercearia.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alliance',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage_Home(
        title: 'ALLIANCE',
      ),
    );
  }
}

// ignore: camel_case_types
class HomePage_Home extends StatefulWidget {
  HomePage_Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState_Home createState() => HomePageState_Home();
}

// ignore: camel_case_types
class HomePageState_Home extends State<HomePage_Home> {
  Future<void> _showDialogRepresentante(String tipoUsuario) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text("Digite o nome da SUA EMPRESA para continuar",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        onChanged: (value) {
                          empresa = value;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            icon: Icon(Icons.business),
                            hintText: 'Empresa'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              primary: Colors.orange,
                              onPrimary: Colors.white),
                          onPressed: () {
                            if (empresa == '') return;

                            if (tipoUsuario == 'Matéria Prima') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaginaRepresentanteMateriaPrima()));
                            } else if (tipoUsuario == 'Mercearia') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaginaRepresentanteMercearia()));
                            } else if (tipoUsuario == 'Embalagem') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaginaRepresentanteEmbalagem()));
                            } else {
                              return;
                            }
                          },
                          child: Text("Entrar")),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _showDialogCliente() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text("Digite a senha para continuar",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text("Você precisa de uma senha para entrar aqui!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      senhaAcessoApp = value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        icon: Icon(Icons.password),
                        hintText: 'Senha'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                          primary: Colors.orange,
                          onPrimary: Colors.white),
                      onPressed: () => verificaSenha(),
                      child: Text("Entrar")),
                )
              ],
            ),
          ));
        });
  }

  void verificaSenha() async {
    if (senhaAcessoApp == 'padoka33762723') {
      calculaPrecos();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => MenuCliente_State(
                    title: 'ALLIANCE',
                  )));
      empresa = "Aliança LTDA";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var appBar = AppBar(
      title: Text(widget.title, style: TextStyle(color: Colors.white)),
      automaticallyImplyLeading: false,
    );
    double heightScreen = (height - appBar.preferredSize.height) -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: appBar,
        body: ListView(
          children: [
            Column(children: [
              Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                      child: Text(
                    "Olá $nome,",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Color.fromARGB(100, 100, 100, 100))
                        ]),
                  ))),
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                      child: Text("Escolha uma opção abaixo:",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 3,
                                    color: Color.fromARGB(100, 100, 100, 100))
                              ])))),
              Container(
                width: width * 0.65,
                height: heightScreen * 0.7,
                margin: EdgeInsets.only(top: heightScreen * .04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: heightScreen * 0.175,
                      child: Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: width,
                                  height: heightScreen * 0.09,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          primary: Colors.orange,
                                          onPrimary: Colors.white),
                                      child: Text("Área de Gerenciamento"),
                                      onPressed: () {
                                        _showDialogCliente();
                                      })),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Área restrita",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                        height: heightScreen * 0.175,
                        width: width,
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Container(
                                  width: width,
                                  height: heightScreen * 0.09,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          primary: Colors.orange,
                                          onPrimary: Colors.white),
                                      child: Text(
                                        "Responder Cotação de Matéria Prima",
                                      ),
                                      onPressed: () {
                                        tipoUsuario = 'Matéria Prima';
                                        _showDialogRepresentante(tipoUsuario);
                                      })),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Entrar como representante",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ]))),
                    SizedBox(
                        height: heightScreen * 0.175,
                        width: width,
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Container(
                                  width: width,
                                  height: heightScreen * 0.09,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          primary: Colors.orange,
                                          onPrimary: Colors.white),
                                      child: Text(
                                        "Responder Cotação de Embalagens",
                                      ),
                                      onPressed: () {
                                        tipoUsuario = 'Embalagem';
                                        _showDialogRepresentante(tipoUsuario);
                                      })),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Entrar como representante",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ]))),
                    SizedBox(
                        height: heightScreen * 0.175,
                        width: width,
                        child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                              Container(
                                  width: width,
                                  height: heightScreen * 0.09,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          primary: Colors.orange,
                                          onPrimary: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Responder Cotação de Mercearia, Frios e Laticíneos",
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        tipoUsuario = 'Mercearia';
                                        _showDialogRepresentante(tipoUsuario);
                                      })),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Entrar como representante",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ])))
                  ],
                ),
              ),
            ]),
          ],
        ));
  }
}
