class devicePushNotification {

  static String registerNewDevice = """
    mutation novoCidadaoDispositivo(\$input: CidadaoDispositivoInput) {
      novoCidadaoDispositivo(input: \$input)
    }
  """;
}
