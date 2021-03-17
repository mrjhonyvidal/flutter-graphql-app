class Campanhas {
  static String getAllCampanhas = """query obtenerCampanhas{
    obtenerCampanhas{
      id
      nome
      idade_inicio
      idade_final
      cidade
      uf
      descricao
    }
}""";
}
