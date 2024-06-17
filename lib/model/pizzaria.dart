class Pizzaria {
  final String uid;
  final String nome;
  final int avaliacao;
  final int tempoEntrega;

  Pizzaria(
    this.uid,
    this.nome,
    this.avaliacao,
    this.tempoEntrega,
  );

  //Transforma um OBJETO em JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': uid,
      'nome': nome,
      'avaliacao': avaliacao,
      "tempoEntrega": tempoEntrega,
    };
  }

  //Transforma um JSON em OBJETO
  factory Pizzaria.fromJson(Map<String, dynamic> json) {
    return Pizzaria(
      json['uid'],
      json['nome'],
      json['avaliacao'],
      json['tempoEntrega'],
    );
  }
}