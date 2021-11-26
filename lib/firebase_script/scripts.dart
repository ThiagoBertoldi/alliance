import 'package:alliance/app/views/google_auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

var db = FirebaseFirestore.instance;

String nome = '';
String email = '';
String empresa = '';
String cnpj = '';
String telefone = '';
String senha = '';
String senhaNovamente = '';
String permissao = '';
String marca = '';
String preco = '';
String unidadeMedida = '';
int count = 0;
String procuraProduto = '';
var userCredential;
String userName = '';
String userEmail = '';
int i = 0;
int iRecebe = 0;
String cotacaoSelecionada = '';
String emailRedefinicao = '';
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoUsuario(
  String nome,
  String email,
  String empresa,
  String cnpj,
  String telefone,
  String senha,
  String senhaNovamente,
) async {
  if (nome == '' ||
      email == '' ||
      empresa == '' ||
      telefone == '' ||
      senha == '' ||
      cnpj == '') {
    print("Precisa Preencher Todos os Campos!!");
  } else if (senhaNovamente != senha) {
    print("Senhas não são iguais!!!");
  } else {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);

      var currentUser = FirebaseAuth.instance.currentUser;

      currentUser!.updateDisplayName(nome);
      currentUser.updateEmail(email);

      // EMAIL
      sendEmail();

      FirebaseFirestore.instance.collection("vendedor_").doc(nome).set({
        "nome": nome,
        "email": email,
        "empresa": empresa,
        "telefone": telefone,
        "cnpj": cnpj,
        "permissao": "2"
      }).then((value) => "Cadastrado com sucesso");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Senha muito fraca!!!');
      } else if (e.code == 'email-already-in-use') {
        print('Este email já está cadastrado!!!');
      }
    } catch (e) {
      print(e);
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoProduto(String nomeProduto, String marca, String unidadeMedida) {
  if (nomeProduto != '') {
    if (marca == '') {
      marca = '-/-';
    }
    if (unidadeMedida == '') {
      unidadeMedida = '-/-';
    }
    db
        .collection("produtos_")
        .doc(nomeProduto)
        .set({
          "nomeProduto": nomeProduto,
          "marca": marca,
          "precoMaisBaixo": "-/-",
          "precoMaisAlto": "-/-",
          "unidadeMedida": unidadeMedida,
        })
        .then((value) => print("Cadastrado!!!"))
        .catchError((error) => print("Produto não cadastrado: $error"));
  } else {
    print("Algo deu errado, você pode tentar de novo...");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaProduto(String nomeProduto) {
  db.collection("produtos_").doc(nomeProduto).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaPreCotacao(String nomeProduto) {
  db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto});
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaCotacao() async {
  var produtoEmPreCotacao = await db.collection("produtosParaCotacao").get();
  var produtoEmCotacaoAntiga = await db.collection("produtosEmCotacao").get();

  for (var doc in produtoEmCotacaoAntiga.docs) {
    db.collection("produtosEmCotacao").doc(doc['nomeProduto']).delete();
  }
  for (var doc in produtoEmPreCotacao.docs) {
    db
        .collection("produtosEmCotacao")
        .doc(doc['nomeProduto'])
        .set({"nomeProduto": doc['nomeProduto']});

    db.collection("produtosParaCotacao").doc(doc['nomeProduto']).delete();
  }
  gravaCotacoesAntigas();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaCotacoesAntigas() async {
  List lista = [];
  final DateTime date = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
  final String dateFormatted = formatter.format(date);
  var produtosRespondidos = await db.collection("produtosRespondidos").get();

  for (var doc in produtosRespondidos.docs) {
    lista.add(doc['empresa']);
  }
  db
      .collection("cotacoesPassadas")
      .doc("$dateFormatted")
      .set({"dataHora": dateFormatted});
  for (int i = 0; i < lista.length; i++) {
    var recebeDados = await db
        .collection("produtosRespondidos")
        .doc(lista[i])
        .collection("produtos")
        .get();

    for (var doc in recebeDados.docs) {
      db
          .collection("produtosRespondidos")
          .doc(lista[i])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete();
      db
          .collection("cotacoesPassadas")
          .doc("$dateFormatted")
          .collection("empresas")
          .doc(doc['empresa'])
          .set({"empresa": doc['empresa']});
      db
          .collection("cotacoesPassadas")
          .doc("$dateFormatted")
          .collection("empresas")
          .doc(doc['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .set({
        "nomeProduto": doc['nomeProduto'],
        "empresa": doc['empresa'],
        "marca": doc['marca'],
        "preço": doc['preço'],
        "unidadeMedida": doc['unidadeMedida']
      });
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void removeDaPreCotacao(String nomeProduto) {
  db.collection("produtosParaCotacao").doc(nomeProduto).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void resetaCotacao() async {
  var prod = await db.collection("produtosEmCotacao").get();

  for (var doc in prod.docs) {
    db.collection("produtosEmCotacao").doc(doc["nomeProduto"]).delete();
  }

  var prod2 = await db.collection("produtosParaCotacao").get();

  for (var doc in prod2.docs) {
    db.collection("produtosParaCotacao").doc(doc["nomeProduto"]).delete();
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void atualizaDadosRepresentante(
    String empresa, String cnpj, String telefone, String nome) {
  if (empresa != '') {
    db
        .collection("vendedor_")
        .doc(nome)
        .update({"empresa": empresa}).then((value) => "Alterado com sucesso!");
  }

  if (cnpj != '') {
    db
        .collection("vendedor_")
        .doc(nome)
        .update({"cnpj": cnpj}).then((value) => "Alterado com sucesso!");
  }

  if (telefone != '') {
    db.collection("vendedor_").doc(nome).update({"telefone": telefone}).then(
        (value) => "Alterado com sucesso!");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaUsuario(String nome) {
  db.collection("vendedor_").doc(nome).delete();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void respondeCotacao(String nomeProduto, String preco, String marca,
    String unidadeMedida, var empresa) {
  db.collection("produtosRespondidos").doc(empresa).set({"empresa": empresa});
  if (marca == '') {
    marca = '-/-';
  }
  if (preco == '') {
    preco = '-/-';
  }
  if (unidadeMedida == '') {
    unidadeMedida = '-/-';
  }

  db.collection("precoAtualProduto").doc(empresa).set({"empresa": empresa});
  db
      .collection("precoAtualProduto")
      .doc(empresa)
      .collection("produtos")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "preço": preco, "empresa": empresa});
  db
      .collection("produtosRespondidos")
      .doc(empresa)
      .collection(nomeProduto)
      .doc(nomeProduto)
      .set({
    "nomeProduto": nomeProduto,
    "marca": marca,
    "unidadeMedida": unidadeMedida,
    "preço": preco,
    "empresa": empresa
  }).then((value) => print("Enviada com Sucesso!!!"));
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Future sendEmail() async {
  //GoogleAuthApi.signOut();
  //return;

  final user = await GoogleAuthApi.signIn();

  if (user == null) return;

  final email = user.email;

  final auth = await user.authentication;

  final token = auth.accessToken!;

  print('Authenticated: $email');

  final smtpServer = gmailSaslXoauth2(email, token);

  final message = Message()
    ..from = Address(email, "PAC")
    ..recipients = [emailRedefinicao]
    ..subject = "Seja bem-vindo!"
    ..html = "<h3>Seja bem-vindo</h3>\n<p>Agradecemos o seu cadastro!</p>";
  //..text = "Este é um e-mail de teste";

  try {
    await send(message, smtpServer);
  } on MailerException catch (e) {
    print(e);
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

void calculaPrecos() async {
  var empresas = await db.collection("precoAtualProduto").get();
  var produto = new Map();

  for (var doc in empresas.docs) {
    var precos = await db
        .collection("precoAtualProduto")
        .doc(doc['empresa'])
        .collection("produtos")
        .get();

    for (var doc2 in precos.docs) {
      produto[doc['empresa']] = int.parse(doc2['preço']);

      print(produto);
    }
  }
}
