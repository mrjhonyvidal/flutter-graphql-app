class DadosPessoais {
  static String getDadosPessoaisByCPF =
      """query obtenerDadosPessoais(\$cpf: String!){
  obtenerDadosPessoais(cpf: \$cpf){
          cpf
          rg
          nome
          dt_nascimento
          email
          contato
          id_tipo_sanguineo
          doador
          endereco
          numero
          complemento
          bairro
          cidade
          uf
          pais
          cep
      }
 }""";
}
