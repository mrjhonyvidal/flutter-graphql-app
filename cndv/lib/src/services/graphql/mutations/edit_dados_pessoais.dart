class DadosPessoaisMutations {
  static String editarDadosPessoaisByCPF = """mutation atualizarDadosPessoais(\$cpf: String!, \$input: DadosPessoaisInput) {
    atualizarDadosPessoais(cpf: \$cpf, input: \$input) {
      cpf
      rg
      nome
      dt_nascimento
      email
      contato,
      id_tipo_sanguineo
      doador
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