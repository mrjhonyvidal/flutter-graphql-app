import 'package:flutter/material.dart';

class EditarFotoPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff526BF6), title: Text('Foto')),
      body: Center(
        child: Text('Round Circle com opção para buscar da galería de imagens ou da câmara'),
      ),
    );
  }
}
