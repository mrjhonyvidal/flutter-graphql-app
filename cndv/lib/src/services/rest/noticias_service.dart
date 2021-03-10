import 'package:flutter/material.dart';
import 'package:cndv/src/models/noticias_vacinas_model.dart';
import 'package:http/http.dart' as http;

final _URL_NOTICIAS = 'https://newsapi.org/v2/';
final _API_KEY = 'f49f2e8ac07047eb887cef27c938857b';

class NoticiasService with ChangeNotifier {
  List<Article> headlines = [];

  NoticiasService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    final url =
        '$_URL_NOTICIAS/top-headlines?apiKey=$_API_KEY&country=br&q=vacina&category=health';
    final resp = await http.get(url);

    final noticiasVacinas = noticiasVacinasFromJson(resp.body);

    this.headlines.addAll(noticiasVacinas.articles);
    notifyListeners();
  }
}
