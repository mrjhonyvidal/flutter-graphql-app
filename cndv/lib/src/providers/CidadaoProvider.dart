import 'package:cndv/src/models/cidadao_dados_pessoais_models.dart';
import 'package:cndv/src/services/graphql/graphql_service.dart';
import 'package:cndv/src/services/graphql/queries/dados_pessoais.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';

class CidadaoProvider {
  GraphQLService _gqService;
  String _cpf;

  CidadaoProvider(String cidadaoCpf) {
    _cpf = cidadaoCpf;
    _gqService = GraphQLService();
  }

  getDadosPessoais() async {
    try{
      final result = await _gqService.performQuery(DadosPessoais.getDadosPessoaisByCPF, variables: {'cpf': _cpf});
      print(result.data);
      return result.data;
    }catch(e){
      print(e);
    }
  }

}