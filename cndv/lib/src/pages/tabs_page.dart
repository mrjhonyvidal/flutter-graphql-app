import 'package:cndv/src/pages/tabCampanhaVacinas_page.dart';
import 'package:cndv/src/pages/tabCarteiraMedica_page.dart';
import 'package:cndv/src/services/carteira_cidadao_service.dart';
import 'package:cndv/src/widgets/header_circle_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: [
        BottomNavigationBarItem( icon: Icon( Icons.fingerprint), label: 'Carteira Médica'),
        BottomNavigationBarItem( icon: Icon( Icons.medical_services), label: 'Campanhas')
      ]
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavegationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        TabCarteiraMedica(),
        TabCampanhaVacinas()
      ],
    );
  }
}

/// Publish/Notifier pattern to notify all the widgets that are dependent of this widget
class _NavegationModel with ChangeNotifier{
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage( int index ) {
    this._currentPage = index;
    _pageController.animateToPage(index, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
