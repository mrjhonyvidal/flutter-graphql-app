import 'package:cndv/src/pages/auth/login_page.dart';
import 'package:cndv/src/pages/perfil/editar_dados_pessoais_page.dart';
import 'package:flutter/material.dart';
import 'package:cndv/src/pages/cidadao/carteira_qr_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final sidebarMenuRoutes = <_Route>[
  _Route(FontAwesomeIcons.qrcode, 'QR CNDV', 'carteira_qr'),
  _Route(FontAwesomeIcons.userCircle, 'Dados pessoais', 'editar_dados_pessoais')
];

class _Route {
  final IconData icon;
  final String titulo;
  final String page;

  _Route(this.icon, this.titulo, this.page);
}
