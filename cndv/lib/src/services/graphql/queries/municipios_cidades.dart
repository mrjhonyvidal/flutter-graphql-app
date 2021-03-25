class MunicipiosCidades {
  static String getMunicipiosCidades = """query obtenerCidadesFilteredByUF(\$uf: String!){
      obtenerCidadesFilteredByUF(uf: \$uf){
        cidade
        uf
        }
      }""";
}