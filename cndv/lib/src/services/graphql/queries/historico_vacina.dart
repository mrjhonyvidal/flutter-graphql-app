class HistoricoVacina {
  static String getCidadaoHistoricoVacinacao = """query obtenerHistoricoVacinacao(\$cpf: String!) {
    obtenerHistoricoVacinacao(cpf: \$cpf) {
       id
       cpf
       tipo_vacina_descricao
       dt_aplicacao        
       tipo_dose_descricao       
       lote
       codigo
       nome_aplicador
       reg_profissional
       unidade_saude  
      }
    }
""";
}