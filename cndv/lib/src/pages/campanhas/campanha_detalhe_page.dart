import 'package:cndv/src/models/campanhas_models.dart';
import 'package:cndv/src/widgets/postos_saude_map.dart';
import 'package:flutter/material.dart';

class CampanhaDetalhe extends StatelessWidget {
  final SearchCampanhas campanha;

  CampanhaDetalhe({Key key, this.campanha}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(58, 66, 86, .6),
            value: 0.5,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final faixaEtaria = Container(
      padding: const EdgeInsets.all(5.0),
      child: new Text(
        'Idades: ' + campanha.idadeInicio.toString() + ' a ' + campanha.idadeFinal.toString(),
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60.0),
        Icon(
          Icons.medical_services,
          color: Colors.white,
          size: 40.0,
        ),
        Container(
          width: 90.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          campanha.nome,
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(flex: 2, child: faixaEtaria),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/img/vacinacao_agulha_image.jpeg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(93, 133, 248, 0.9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 10.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final cidadeInfo = Row(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Text(
                  campanha.cidade + ', ' + campanha.uf,
                  style: TextStyle(color: Colors.blueAccent),
                ))),
        SizedBox( height: 50 ),
      ],
    );

    final bottomContentText = Text(
      campanha.descricao,
      style: TextStyle(fontSize: 18.0, color: Colors.black),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PostosSaudeMap(), fullscreenDialog: true),
          )},
          color: Colors.blueAccent,
          child:
          Text("Buscar Postos de Saúde", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Expanded(
      child: SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(40.0),
        child: Center(
              child: Column(
                children: <Widget>[
                  cidadeInfo,
                  bottomContentText,
                  readButton],
              ),
            ),
          ),
        )),
    );

    /// Show in Campanha Detalhe page:
    /// PostosSaudeMap postosSaudeMap = PostosSaudeMap();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }
}