class Motoboy {
  final String nome;
  final int idade;

  Motoboy(this.nome, this.idade);

  //Transforma um OBJETO em JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'idade': idade,
    };
  }

  //Transforma um JSON em OBJETO
  factory Motoboy.fromJson(Map<String, dynamic> json) {
    return Motoboy(
      json['nome'],
      json['idade'],
    );
  }
}
