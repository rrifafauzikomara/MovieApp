import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class SettingPage extends StatefulWidget {
  static const routeName = '/theme';

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  bool _isDark;

  @override
  void initState() {
    super.initState();
    ThemeHelper().getTheme().then((value) => _isDark = value);
  }

  void _handleRadioValueChange(bool value) {
    setState(() {
      _isDark = value;
      if (_isDark) {
        ThemeHelper().saveTheme(true);
        _changeTheme(context, ThemesKeys.DARK);
      } else {
        ThemeHelper().saveTheme(false);
        _changeTheme(context, ThemesKeys.LIGHT);
      }
    });
  }

  void _changeTheme(BuildContext buildContext, ThemesKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(Sizes.dp10(context)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                PopUp.showSnackBar(
                  Text(
                    'Comming Soon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Sizes.dp16(context),
                      color: ColorPalettes.white,
                    ),
                  ),
                  key: scaffoldKey,
                );
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: Sizes.dp10(context),
                  bottom: Sizes.dp10(context),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Language'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        groupValue: _isDark,
                        onChanged: (value) {
                          setState(() {
                            _isDark = value;
                            _handleRadioValueChange(_isDark);
                            print('Theme is dark ---> $_isDark');
                          });
                        },
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: Sizes.dp10(context),
                  bottom: Sizes.dp10(context),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Theme'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}