import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:package_info/package_info.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/theme';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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

  Future<String> _getVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
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
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Language'),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: Sizes.dp16(context),
                  ),
                  onPressed: () {
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
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Theme'),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: Sizes.dp16(context),
                  ),
                  onPressed: () {
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
                      },
                    );
                  },
                ),
              ],
            ),
            Divider(),
            Spacer(),
            FutureBuilder<String>(
              future: _getVersion(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                var verInfo = "";
                if (snapshot.hasData) {
                  verInfo = "v ${snapshot.data}";
                }
                return Container(
                  margin: EdgeInsets.only(bottom: Sizes.dp30(context)),
                  child: Text(
                    verInfo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
