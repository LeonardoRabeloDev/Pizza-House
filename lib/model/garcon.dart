class Garcon {
  final String nome;
  final int idade;

  Garcon(this.nome, this.idade);

  //Transforma um OBJETO em JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'idade': idade,
    };
  }

  //Transforma um JSON em OBJETO
  factory Garcon.fromJson(Map<String, dynamic> json) {
    return Garcon(
      json['nome'],
      json['idade'],
    );
  }
}