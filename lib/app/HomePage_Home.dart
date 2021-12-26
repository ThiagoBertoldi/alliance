import 'package:alliance/app/views/viewsCliente/homePage_MenuCliente.dart';
import 'package:alliance/app/views/viewsRepresentante/homePage_MenuRepresentante.dart';
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
  void verificaSenha() async {
    if (senhaAcessoApp == 'padoka33762723') {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Container(
            padding: EdgeInsets.only(top: 40),
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
            padding: EdgeInsets.all(20),
            child: Center(
                child: Text("escolha uma opção abaixo:",
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
          height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
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
                      child: Text("Área de Gerenciamento"),
                      onPressed: () => showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text("Digite a senha para continuar",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    child: Text(
                                        "Você precisa de uma senha para entrar aqui!",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 40, bottom: 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: TextFormField(
                                      obscureText: true,
                                      onChanged: (value) {
                                        senhaAcessoApp = value;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          icon: Icon(Icons.password),
                                          hintText: 'Senha'),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(30),
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                            primary: Colors.orange,
                                            onPrimary: Colors.white),
                                        onPressed: () => verificaSenha(),
                                        child: Text("Entrar")),
                                  )
                                ],
                              ),
                            );
                          }))),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
                child: Text("Gerenciamento de cotações",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.07,
                  margin: EdgeInsets.only(top: 30),
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
                      child: Text(
                        "Responder Cotação Semanal",
                      ),
                      onPressed: () => showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                        "Digite o nome da EMPRESA para continuar",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        empresa = value;
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(30),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                  bottomRight:
                                                      Radius.circular(5))),
                                          icon: Icon(Icons.business),
                                          hintText: 'Empresa'),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.07,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(30),
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5))),
                                            primary: Colors.orange,
                                            onPrimary: Colors.white),
                                        onPressed: () {
                                          if (empresa == '') {
                                            return;
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomePage_MenuRepresentante(
                                                          title: 'ALLIANCE',
                                                        )));
                                          }
                                        },
                                        child: Text("Entrar")),
                                  )
                                ],
                              ),
                            );
                          }))),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 20),
                child: Text("Entrar como representante",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
