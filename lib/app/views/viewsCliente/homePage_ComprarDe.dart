import 'package:alliance/app/views/viewsCliente/geraPDF/mobile.dart';
import 'package:alliance/firebase_script/scripts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'homePage_MenuCliente.dart';

// ignore: camel_case_types
class HomePage_ComprarDe extends StatefulWidget {
  HomePage_ComprarDe({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState_ComprarDe createState() => _HomePageState_ComprarDe();
}

// ignore: camel_case_types
class _HomePageState_ComprarDe extends State<HomePage_ComprarDe> {
  List listaNome = [];
  List listaEmpresa = [];
  List listaPreco = [];
  List listaMarca = [];
  List listaQuantidade = [];
  List listaUnidadeMedida = [];

  implementaListas(String nomeProduto, String empresa, String preco,
      String marca, String quantidadeDeCompra, String unidadeMedidaCompra) {
    if (listaNome.contains(nomeProduto)) {
    } else {
      listaNome.add(nomeProduto);
      listaPreco.add(preco);
      listaEmpresa.add(empresa);
      listaMarca.add(marca);
      listaQuantidade.add(quantidadeDeCompra);
      listaUnidadeMedida.add(unidadeMedidaCompra);
    }

    print("As listas foram implementadas");
  }

  limpaListas() async {
    listaNome.clear();
    listaEmpresa.clear();
    listaPreco.clear();
    listaMarca.clear();
    listaQuantidade.clear();
    listaUnidadeMedida.clear();
    print("As listas foram limpas");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
          leading: GestureDetector(
            onTap: () {
              limpaListas();
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
        body: ListView(children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .6,
                height: MediaQuery.of(context).size.height * .06,
                margin: EdgeInsets.only(top: 35),
                child: ElevatedButton(
                  child: Text("Exportar para PDF",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () {
                    _createPDF(listaNome, listaEmpresa, listaMarca, listaPreco,
                        listaQuantidade, listaUnidadeMedida);
                  },
                ),
              ),
            ],
          ),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 35),
            child: Text("Lista de compras desta Semana",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          )),
          Center(
              child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 25),
            child: Text("Empresas -> Produtos",
                style: TextStyle(fontSize: 17, color: Colors.orange)),
          )),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection("comprarDe").snapshots(),
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
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(docSnapshot['empresa'],
                                  style: TextStyle(
                                      color: Colors.orange, fontSize: 26)),
                            ),
                            StreamBuilder<QuerySnapshot>(
                                stream: db
                                    .collection("comprarDe")
                                    .doc(docSnapshot['empresa'])
                                    .collection("produtos")
                                    .snapshots(),
                                builder: (context, snapshot2) {
                                  if (snapshot2.hasData) {
                                    return ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot2.data!.docs.length,
                                        itemBuilder: (context, index2) {
                                          DocumentSnapshot docSnapshot2 =
                                              snapshot2.data!.docs[index2];
                                          implementaListas(
                                              docSnapshot2['nomeProduto'],
                                              docSnapshot2['empresa'],
                                              docSnapshot2['preço'],
                                              docSnapshot2['marca'],
                                              docSnapshot2[
                                                  'quantidadeDeCompra'],
                                              docSnapshot2[
                                                  'unidadeMedidaCompra']);
                                          return Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .9,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .1,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  elevation: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          docSnapshot2[
                                                              'nomeProduto'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text(
                                                          "R\$ " +
                                                              docSnapshot2[
                                                                  'preço'],
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .orange)),
                                                    ],
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
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ]));
  }

  Future<void> _createPDF(List listaNome, List listaEmpresa, List listaMarca,
      List listaPreco, List listaQuantidade, List listaUnidadeMedida) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString("Compras desta semana\n " + dateFormatted,
        PdfStandardFont(PdfFontFamily.helvetica, 40));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
        font: PdfStandardFont(PdfFontFamily.helvetica, 18),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 6);
    grid.headers.add(1);

    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Produto';
    header.cells[1].value = 'Empresa';
    header.cells[2].value = 'Marca';
    header.cells[3].value = 'Preço';
    header.cells[4].value = 'Quantidade';
    header.cells[5].value = 'Unidade';
    header.style = PdfGridRowStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 22,
          style: PdfFontStyle.bold),
    );

    for (int i = 0; i < listaNome.length; i++) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = listaNome[i];
      row.cells[1].value = listaEmpresa[i];
      row.cells[2].value = listaMarca[i];
      row.cells[3].value = "R\$ " + listaPreco[i];
      row.cells[4].value = listaQuantidade[i];
      row.cells[5].value = listaUnidadeMedida[i];
    }

    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, "CompraSemanal.pdf");
  }
}
