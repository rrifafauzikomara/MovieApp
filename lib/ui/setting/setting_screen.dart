import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/about/about_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:shared/shared.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/theme';

  Future<String> _getVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    return info.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text('Developer'),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: Sizes.dp16(context),
                  ),
                  onPressed: () {
                    Navigation.intent(context, AboutScreen.routeName);
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
                        return BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            return CustomDialog(
                              groupValue: state is ThemeState
                                  ? state.isDarkTheme
                                  : false,
                              onChanged: (value) {
                                context.read<ThemeBloc>().add(ThemeChanged(isDarkTheme: value));
                              },
                            );
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
