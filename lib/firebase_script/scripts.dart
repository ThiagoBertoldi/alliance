import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

var db = FirebaseFirestore.instance;

String nome = '';
String email = '';
String empresa = '';
String idToken = '';
String telefone = '';
String permissao = '';
String marca = '';
String preco = '';
String unidadeMedida = '';
String procuraProduto = '';
var userCredential;
String userName = '';
String userEmail = '';
String cotacaoSelecionada = '';
String senhaRedefinicao = '';
String nomeProduto = '';
String senhaAcessoApp = '';
String novoNomeProduto = '';
String tipoUsuario = '';
String tipoProduto = '';
List listaPrecos = [];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void gravaNovoProduto(String nomeProduto, String tipoProduto) {
  if (nomeProduto != '' || tipoProduto != '') {
    db.collection("produtos_").doc(nomeProduto).set({
      "nomeProduto": nomeProduto,
      "marca": "-/-",
      "unidadeMedida": "-/-",
      "precoMaisBaixo": "-/-",
      "precoMaisAlto": "-/-",
      "tipoProduto": tipoProduto
    }).then((value) => print("Cadastrado!!!"));
  } else {
    print("Algo deu errado, você pode tentar de novo...");
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void deletaProduto(String nomeProduto) async {
  var query = await db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .collection("empresas")
      .get();

  for (var doc in query.docs) {
    await db
        .collection("precoAtualProduto")
        .doc(nomeProduto)
        .collection("empresas")
        .doc(doc['empresa'])
        .delete();
  }

  await db
      .collection("produtosEmCotacao")
      .doc(nomeProduto)
      .delete()
      .then((value) => "Produto deletado da cotação");
  await db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .delete()
      .then((value) => "Produto deletado da pré-cotação");
  await db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .delete()
      .then((value) => "Produto deletado dos preços atuais");
  await db
      .collection("produtos_")
      .doc(nomeProduto)
      .delete()
      .then((value) => "Produto Deletado");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void editaNomeProduto(String nomeProduto, String novoNome, String marca,
    String precoMaisAlto, String precoMaisBaixo, String unidadeMedida) async {
  // ignore: unnecessary_null_comparison
  if (novoNome == '') {
    novoNome = nomeProduto;
  }

  var query = await db.collection("precoAtualProduto").get();

  for (var doc in query.docs) {
    var query = await db
        .collection("precoAtualProduto")
        .doc(doc['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc2 in query.docs) {
      db
          .collection("precoAtualProduto")
          .doc(doc['nomeProduto'])
          .collection("empresas")
          .doc(doc2['empresa'])
          .delete();
    }
  }

  await db.collection("produtos_").doc(nomeProduto).delete();
  await db.collection("precoAtualProduto").doc(nomeProduto).delete();

  await db.collection("produtos_").doc(novoNome).set({
    "nomeProduto": novoNome,
    "marca": marca,
    "precoMaisAlto": precoMaisAlto,
    "precoMaisBaixo": precoMaisBaixo,
    "unidadeMedida": unidadeMedida
  });

  await db.collection("precoAtualProduto").doc(novoNome).set({
    "nomeProduto": novoNome,
    "marca": marca,
    "precoMaisAlto": precoMaisAlto,
    "precoMaisBaixo": precoMaisBaixo,
    "unidadeMedida": unidadeMedida
  });

  novoNome = '';
  novoNomeProduto = '';
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaPreCotacao(String nomeProduto, String tipoProduto) async {
  await db
      .collection("produtosParaCotacao")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto, "tipoProduto": tipoProduto}).then(
          (value) => "Colocado em pré-cotação");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void enviaParaCotacao() async {
  var produtoEmPreCotacao = await db.collection("produtosParaCotacao").get();
  var produtoEmCotacaoAntiga = await db.collection("produtosEmCotacao").get();
  var produtosRespondidos = await db.collection("produtosRespondidos").get();
  var produtosRespondidosModal =
      await db.collection("produtosRespondidosModal").get();
  var deletaPrecosProdutos = await db.collection("produtos_").get();
  var deletaPrecoAtual = await db.collection("precoAtualProduto").get();

  gravaCotacoesAntigas();

  for (var doc5 in deletaPrecoAtual.docs) {
    var recebeEmpresasPrecoAtualProduto = await db
        .collection("precoAtualProduto")
        .doc(doc5['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc6 in recebeEmpresasPrecoAtualProduto.docs) {
      db
          .collection("precoAtualProduto")
          .doc(doc5['nomeProduto'])
          .collection("empresas")
          .doc(doc6['empresa'])
          .delete();
    }
    db.collection("precoAtualProduto").doc(doc5['nomeProduto']).delete();
  }

  for (var doc2 in produtosRespondidos.docs) {
    var query = await db
        .collection("produtosRespondidos")
        .doc(doc2['empresa'])
        .collection("produtos")
        .get();
    for (var doc in query.docs) {
      db
          .collection("produtosRespondidos")
          .doc(doc2['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete()
          .then((value) => "Produto deletado da tabela produtosRespondidos!");
    }
  }

  for (var doc in produtosRespondidos.docs) {
    db.collection("produtosRespondidos").doc(doc['empresa']).delete();
  }

  for (var doc3 in produtosRespondidosModal.docs) {
    var query = await db
        .collection("produtosRespondidosModal")
        .doc(doc3['empresa'])
        .collection("produtos")
        .get();

    for (var doc in query.docs) {
      db
          .collection("produtosRespondidosModal")
          .doc(doc3['empresa'])
          .collection("produtos")
          .doc(doc['nomeProduto'])
          .delete();
    }
  }

  for (var doc in produtosRespondidosModal.docs) {
    db.collection("produtosRespondidosModal").doc(doc['empresa']).delete();
  }

  for (var doc4 in deletaPrecosProdutos.docs) {
    db
        .collection("produtos_")
        .doc(doc4['nomeProduto'])
        .update({"precoMaisAlto": "0,00"});
    db
        .collection("produtos_")
        .doc(doc4['nomeProduto'])
        .update({"precoMaisBaixo": "0,00"});
  }
  for (var doc in produtoEmCotacaoAntiga.docs) {
    db.collection("produtosEmCotacao").doc(doc['nomeProduto']).delete();
  }
  for (var doc in produtoEmPreCotacao.docs) {
    db.collection("produtosEmCotacao").doc(doc['nomeProduto']).set({
      "nomeProduto": doc['nomeProduto'],
      "tipoProduto": doc['tipoProduto']
    }).then((value) => print("Produto enviado para cotação!!!"));

    db.collection("produtosParaCotacao").doc(doc['nomeProduto']).delete();
  }
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
      .set({"dataHora": dateFormatted}).then(
          (value) => "Documento criado no FireBase: " + dateFormatted);
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

  print("Pré-cotação grvada como: " + dateFormatted);
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
void respondeCotacao(String nomeProduto, String preco, String marca,
    String unidadeMedida, var empresa) {
  if (marca == '') {
    marca = '-/-';
  }
  if (preco == '') {
    preco = '-/-';
  }
  if (unidadeMedida == '') {
    unidadeMedida = '-/-';
  }

  if (empresa == '') {
    empresa = '-/-';
  }

  db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .set({"nomeProduto": nomeProduto});
  db
      .collection("precoAtualProduto")
      .doc(nomeProduto)
      .collection("empresas")
      .doc(empresa)
      .set({"nomeProduto": nomeProduto, "preço": preco, "empresa": empresa})
      .then((value) => "Preço Atual Criado!!!")
      .onError((error, stackTrace) => "Erro Linha 201 \"scripts.dart:200\"");

  db
      .collection("produtosRespondidosModal")
      .doc(empresa)
      .set({"empresa": empresa});
  db
      .collection("produtosRespondidosModal")
      .doc(empresa)
      .collection("produtos")
      .doc(nomeProduto)
      .set({
        "nomeProduto": nomeProduto,
        "marca": marca,
        "unidadeMedida": unidadeMedida,
        "preço": preco,
        "empresa": empresa
      })
      .then((value) => "Informações Modal OK!!!")
      .onError((error, stackTrace) => "Erro Linha 218 \"scripts.dart:218\"");

  db.collection("produtosRespondidos").doc(empresa).set({"empresa": empresa});
  db
      .collection("produtosRespondidos")
      .doc(empresa)
      .collection("produtos")
      .doc(nomeProduto)
      .set({
        "nomeProduto": nomeProduto,
        "marca": marca,
        "unidadeMedida": unidadeMedida,
        "preço": preco,
        "empresa": empresa
      })
      .then((value) => print("Enviada com Sucesso!!!"))
      .onError((error, stackTrace) => "Erro Linha 233 \"scripts.dart:233\"");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

void calculaPrecos() async {
  print("Iniciando comparação de preços dos produtos...");
  var produtos = await db.collection("precoAtualProduto").get();
  listaPrecos = [];

  for (var doc1 in produtos.docs) {
    var produtos2 = await db
        .collection("precoAtualProduto")
        .doc(doc1['nomeProduto'])
        .collection("empresas")
        .get();
    for (var doc2 in produtos2.docs) {
      if (doc2['preço'] == '' || doc2['preço'] == 0) {
        print("Sem preço cadastrado");
      } else {
        print(doc2['nomeProduto'] + ": preço comparado");
        listaPrecos.add(doc2['preço']);
      }
    }
    listaPrecos.sort();
    db
        .collection('produtos_')
        .doc(doc1['nomeProduto'])
        .update({'precoMaisAlto': listaPrecos.last});
    db
        .collection('produtos_')
        .doc(doc1['nomeProduto'])
        .update({'precoMaisBaixo': listaPrecos.first});
    listaPrecos.clear();
  }
  print("Comparação de preços de produtos OK");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////