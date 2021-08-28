import 'package:alliance/Paginas/paginaLogin.dart';
import 'package:flutter/material.dart';

main() {
  runApp(PaginaCadastro());
}

// ignore: camel_case_types
class PaginaCadastro extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage_Cadastro(title: 'Flutter App'),
    );
  }
}

// ignore: camel_case_types
class MyHomePage_Cadastro extends StatefulWidget {
  MyHomePage_Cadastro({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage_Cadastro> {
  String nome = '';
  String email = '';
  String empresa = '';
  String cnpj = '';
  String tel = '';
  int telefone = 0;
  String senha = '';
  String senhaNovamente = '';

  void gravaDados(String nome, String email, String empresa, int telefone,
      String senha, String senhaNovamente) {
    print(nome +
        " / " +
        email +
        " / " +
        empresa +
        " / " +
        cnpj +
        " / " +
        "$telefone" +
        " / " +
        senha +
        " / " +
        senhaNovamente);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: new EdgeInsets.only(
              left: 50.0,
              right: 50.0,
              top: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: new EdgeInsets.all(15),
                child: Text(
                  "Cadastro de Usuário",
                  style: TextStyle(fontSize: 30, color: Colors.green),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  nome = text;
                },
                decoration: InputDecoration(
                  labelText: 'Nome Completo',
                  icon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  empresa = text;
                },
                decoration: InputDecoration(
                  labelText: 'Empresa',
                  icon: Icon(Icons.business),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  cnpj = text;
                },
                decoration: InputDecoration(
                  labelText: 'CNPJ',
                  icon: Icon(Icons.document_scanner),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  tel = text;
                  telefone = int.parse(tel);
                },
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  icon: Icon(Icons.phone_android),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  senha = text;
                },
                autofocus: true,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  icon: Icon(Icons.password),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  senhaNovamente = text;
                },
                autofocus: true,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha Novamente',
                  icon: Icon(Icons.password),
                ),
              ),
              Container(
                margin: new EdgeInsets.only(top: 30),
                // ignore: deprecated_member_use
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  height: MediaQuery.of(context).size.height * 0.07,
                  minWidth: MediaQuery.of(context).size.width * 0.6,
                  child:
                      Text('Cadastrar', style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => PaginaLogin()));
                    gravaDados(
                        nome, email, empresa, telefone, senha, senhaNovamente);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
