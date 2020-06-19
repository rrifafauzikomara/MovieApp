import 'package:moviecatalogue/ui/setting/setting_page.dart';

class Menu {
  const Menu({this.route, this.title});

  final String route;
  final String title;
}

const List<Menu> menus = const <Menu>[
  const Menu(
    route: SettingPage.routeName,
    title: 'Setting',
  ),
];