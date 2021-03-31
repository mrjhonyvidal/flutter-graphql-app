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

  static String getSearchCampanhas = """query searchCampanhas(\$input: CampanhasSearchInput) {
      searchCampanhas(input: \$input){
        	id
          nome
          idade_inicio
          idade_final
          cidade
          uf
      }
  }""";
}
