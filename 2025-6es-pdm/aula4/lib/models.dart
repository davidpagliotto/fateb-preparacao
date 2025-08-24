class Perfil {
  String nome;
  String imagem;
  bool seguindo;

  // Construtor
  Perfil({
    required this.nome,
    required this.imagem,
    this.seguindo = false, // por padrão não está seguindo
  });

  // Método para alternar estado de "seguindo"
  void alternarSeguir() {
    seguindo = !seguindo;
  }

  // Representação em string (debug)
  @override
  String toString() {
    return 'Perfil(nome: $nome, imagem: $imagem, seguindo: $seguindo)';
  }
}
