import 'package:cndv/src/pages/tabs/tabCampanhaVacinas_page.dart';
import 'package:cndv/src/pages/tabs/tabCarteiraMedica_page.dart';
import 'package:cndv/src/routes/sidebar_menu_routes.dart';
import 'package:cndv/src/storage/cndv_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavegationModel(),
      child: Scaffold(
        body: _Pages(),
        drawer: _MainSidebarMenu(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _MainSidebarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cndvAuthSecureProvider =
        Provider.of<CNDVAuthSecureStorage>(context, listen: true);

    return Drawer(
      child: Container(
          child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 150,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child:  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.camera_enhance, color: Colors.white, size: 40.0),
                    onPressed: () {},
                  ),
                )),
          ),
          Text(
            cndvAuthSecureProvider.usuarioAcesso.nome,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            cndvAuthSecureProvider.usuarioAcesso.cpf,
            style: TextStyle(fontSize: 14),
          ),
          Expanded(
              child: _ListSidebarMenuOptions(
                  cpfCidadao: cndvAuthSecureProvider.usuarioAcesso.cpf)),
          ListTile(
            leading: Icon(FontAwesomeIcons.doorOpen, color: Colors.blue),
            title: Text('Sair'),
            onTap: () {
              CNDVAuthSecureStorage.deleteToken();
              Navigator.pushReplacementNamed(context, 'login');
            },
          )
        ],
      )),
    );
  }
}

class _ListSidebarMenuOptions extends StatelessWidget {
  final String cpfCidadao;

  const _ListSidebarMenuOptions({Key key, this.cpfCidadao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, i) => Divider(
        color: Colors.blue,
      ),
      itemCount: sidebarMenuRoutes.length,
      itemBuilder: (context, i) => ListTile(
          leading: FaIcon(
            sidebarMenuRoutes[i].icon,
            color: Colors.blue,
          ),
          title: Text(sidebarMenuRoutes[i].titulo),
          trailing: Icon(Icons.chevron_right, color: Colors.blue),
          onTap: () => Navigator.of(context).pushNamed(
              sidebarMenuRoutes[i].page,
              arguments: {'cpf': this.cpfCidadao})),
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

        ///selectedItemColor: Colors.black,
        ///unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fingerprint), label: 'Carteira Médica'),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: 'Campanhas')
        ]);
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
      ///children: <Widget>[TabCarteiraMedica(), TabCampanhaVacinas()],
      children: <Widget>[TabCarteiraMedica(), MyApp()],
    );
  }
}

/// Publish/Notifier pattern to notify all the widgets that are dependent of this widget
class _NavegationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = new PageController();

  int get currentPage => this._currentPage;

  set currentPage(int index) {
    this._currentPage = index;
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
