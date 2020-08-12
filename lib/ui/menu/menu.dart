import 'package:moviecatalogue/ui/setting/setting_screen.dart';

class Menu {
  const Menu({this.route, this.title});

  final String route;
  final String title;
}

const List<Menu> menus = const <Menu>[
  const Menu(
    route: SettingScreen.routeName,
    title: 'Setting',
  ),
];