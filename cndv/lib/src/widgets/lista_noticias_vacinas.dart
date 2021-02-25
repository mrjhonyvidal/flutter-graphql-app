import 'package:cndv/src/models/noticias_vacinas_model.dart';
import 'package:cndv/src/theme/theme.dart';
import 'package:flutter/material.dart';

class ListaNoticiasVacinas extends StatelessWidget {

  final List<Article> noticias;
  const ListaNoticiasVacinas(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.noticias.length,
        itemBuilder: (BuildContext context, int index) {
       
          return _NoticiasVacinas(noticia: this.noticias[index], index: index);
        },
    );
  }
}

class _NoticiasVacinas extends StatelessWidget {

  final Article noticia;
  final int index;

  const _NoticiasVacinas({
    @required this.noticia,
    @required this.index
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
       _CardNoticiaTopBar(noticia, index),
       _CardNoticiaTitulo(noticia),
       _CardNoticiaImagen(noticia)
      ]
    );
  }
}

class _CardNoticiaTopBar extends StatelessWidget {

  final Article noticia;
  final int index;

  const _CardNoticiaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        children: <Widget>[
          Text('${ index + 1}.', style: TextStyle(color: cndvTheme.accentColor),),
          Text('${ noticia.source.name }.'),
        ]
      )

    );
  }
}

class _CardNoticiaTitulo extends StatelessWidget {

  final Article noticia;

  const _CardNoticiaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: <Widget>[
              Text('${ noticia.source.name }.'),
            ]
        )

    );
   }
}

class _CardNoticiaImagen extends StatelessWidget {

  final Article noticia;

  const _CardNoticiaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            children: <Widget>[
              Text('${ noticia.source.name }.'),
            ]
        )
    );
  }
}
