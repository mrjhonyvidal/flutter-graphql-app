import 'package:cndv/src/models/noticias_vacinas_model.dart';
import 'package:flutter/material.dart';

class ListaNoticiasVacinas extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticiasVacinas(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(this.noticias[index].title);
        },
    );
  }
}
