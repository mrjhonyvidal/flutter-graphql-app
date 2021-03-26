class devicePushNotification {

  static String registerNewDevice = """
    mutation novoCidadaoDispositivo(\$cpf: String!, \$token: String!, \$tipo: String!) {
      novoCidadaoDispositivo(input: {cpf: \$cpf, token: \$token, tipo: \$tipo}) {
        cpf
        token
        tipo        
      }
    }
  """;
}
