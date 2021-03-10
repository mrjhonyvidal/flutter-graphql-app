class authTokenRegistrationUsuario {
  static String authUser = """
    mutation autenticarUsuario(\$cpf: String!, \$senha: String!) {
      autenticarUsuario(input: {cpf: \$cpf, senha: \$senha}) {
        token
        email
        cpf
        nome
      }
    }
  """;

  static String registerNewUser = """
    mutation novoUsuarioAcesso(\$cpf: String!, \$nome: String!, \$senha: String!, \$email: String!) {
      novoUsuarioAcesso(input: {cpf: \$cpf, nome: \$nome, senha: \$senha, email: \$email}) {
        cpf
        nome
        email
      }
    }
  """;
}
