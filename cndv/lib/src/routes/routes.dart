import 'package:cndv/src/pages/auth/cadastro_page.dart';
import 'package:cndv/src/pages/auth/login_page.dart';
import 'package:cndv/src/pages/auth/recuperar_senha_page.dart';
import 'package:cndv/src/pages/campanhas/campanha_detalhe_page.dart';
import 'package:cndv/src/pages/mensagens/mensagem_notificacoes_page.dart';
import 'package:cndv/src/pages/perfil/editar_dados_pessoais_page.dart';
import 'package:cndv/src/pages/searchs/buscar_campanhas_page.dart';
import 'package:cndv/src/pages/tabs/tabs_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'tabs': ( _ ) => TabsPage(),
  'login': ( _ ) => Login(),
  'cadastro': ( _ ) => Cadastro(),
  'recuperar_acesso': ( _ ) => RecuperarAcesso(),
  'campanha_detalhe': ( _ ) => CampanhaDetalhe(),
  'mensagem_notificacoes': ( _ ) => MensagensNotificacoes(),
  'editar_dados_pessoais': ( _ ) => EditarDadosPessoais(),
  'buscar_campanhas': ( _ ) => BuscarCampanhasPage(),
};