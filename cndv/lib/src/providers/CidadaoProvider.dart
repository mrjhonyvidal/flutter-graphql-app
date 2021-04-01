import 'package:cndv/src/services/graphql/graphql_service.dart';
import 'package:cndv/src/services/graphql/queries/dados_pessoais.dart';

class CidadaoProvider {
  GraphQLService _gqService;
  String _cpf;

  CidadaoProvider(String cidadaoCpf) {
    _cpf = cidadaoCpf;
    _gqService = GraphQLService();
  }

  Future getDadosPessoais() async {
    try{
      final result = await _gqService.performQuery(DadosPessoais.getDadosPessoaisByCPF, variables: {'cpf': _cpf});
      return result.data;
    }catch(e){
      print(e);
    }
  }
}