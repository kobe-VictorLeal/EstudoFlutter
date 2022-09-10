void main() {
  final r = soma(3, 2);
  print("Deu $r");

  final rr = bagunca(4, 7, (a, b) {
    return a - b;
  });
  print("Deu $rr");

  var p1 = new Gente("Caaaarlos", 23947);
  print(p1.name);
}

int soma(int a, int b) {
  return (a + b);
}

int bagunca(int a, int b, int Function(int, int) ff) {
  return ff(a, b);
}

class Gente {
  String? name;
  double? valor;

  Gente(String? name, double? valor) {
    this.name = name;
    this.valor = valor;
  }
}
