class Ordenador {
  String empresa = '';
  double preco = 0;

  Ordenador(String empresa, double preco) {
    this.empresa = empresa;
    this.preco = preco;
  }

  String getEmpresa() {
    return this.empresa;
  }

  double getPreco() {
    return this.preco;
  }

  void setPreco(double preco) {
    this.preco = preco;
  }
}
