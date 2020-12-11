import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/common/utils/chair_constant.dart';

class CinemaWidget extends StatefulWidget {
  final String movieBackground;

  const CinemaWidget({Key key, this.movieBackground}) : super(key: key);

  @override
  _CinemaWidgetState createState() => _CinemaWidgetState();
}

class _CinemaWidgetState extends State<CinemaWidget>
    with TickerProviderStateMixin {
  AnimationController _cinemaChairAc;
  Animation<double> _cinemaChairTween;
  AnimationController _cinemaScreenAc;
  Animation<double> _cinemaScreenTween;
  bool _isDarkTheme;

  var _chairStatus = [
    [0, 3, 2, 1, 2, 2, 0],
    [2, 2, 2, 2, 1, 2, 2],
    [1, 1, 2, 2, 2, 2, 2],
    [0, 2, 1, 1, 1, 2, 0],
    [2, 2, 2, 2, 2, 2, 2],
    [0, 3, 3, 2, 1, 1, 0]
  ];

  @override
  void initState() {
    super.initState();

    // initialize cinemaScreen
    _cinemaScreenAc = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _cinemaScreenTween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_cinemaScreenAc);
    Future.delayed(Duration(milliseconds: 800), () {
      _cinemaScreenAc.forward();
    });

    // chair
    _cinemaChairAc = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1600));
    _cinemaChairTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_cinemaChairAc);
    Future.delayed(Duration(milliseconds: 1200), () {
      _cinemaChairAc.forward();
    });
  }

  @override
  void dispose() {
    _cinemaChairAc.dispose();
    _cinemaScreenAc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    _isDarkTheme = themeData.appBarTheme?.color == null;
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: _cinemaScreenAc,
          builder: (ctx, child) {
            double perspective = 0.004 * _cinemaScreenTween.value;
            return Transform(
              alignment: Alignment.topCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, perspective)
                ..rotateX(_cinemaScreenTween.value),
              child: child,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dp10(context)),
            child: CachedNetworkImage(
              imageUrl: widget.movieBackground.imageOriginal,
              width: Sizes.width(context),
              fit: BoxFit.fill,
              placeholder: (context, url) => LoadingIndicator(),
              errorWidget: (context, url, error) => ErrorImage(),
            ),
          ),
        ),
        SizedBox(height: Sizes.dp20(context)),
        AnimatedBuilder(
          animation: _cinemaChairAc,
          builder: (ctx, child) {
            return Transform.translate(
              offset: Offset(0, _cinemaChairTween.value * 100),
              child:
                  Opacity(opacity: _cinemaChairTween.value + 1, child: child),
            );
          },
          child: Container(
            width: Sizes.width(context),
            child: _chairList(),
          ),
        ),
      ],
    );
  }

  Widget _chairList() {
    // 0 is null
    // 1 is free
    // 2 is reserved
    // 3 is not available
    // 4 is yours
    return Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(top: i == 3 ? Sizes.dp20(context) : 0),
            child: Row(
              children: <Widget>[
                for (int x = 0; x < 9; x++)
                  Expanded(
                    flex: x == 0 || x == 8 ? 2 : 1,
                    child: x == 0 ||
                            x == 8 ||
                            (i == 0 && x == 1) ||
                            (i == 0 && x == 7) ||
                            (i == 3 && x == 1) ||
                            (i == 3 && x == 7) ||
                            (i == 5 && x == 1) ||
                            (i == 5 && x == 7)
                        ? Container()
                        : GestureDetector(
                            onTap: () {
                              if (_chairStatus[i][x - 1] == 1) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 4;
                                });
                              } else if (_chairStatus[i][x - 1] == 4) {
                                setState(() {
                                  _chairStatus[i][x - 1] = 1;
                                });
                              }
                            },
                            child: Container(
                              height: Sizes.width(context) / 11 - 10,
                              margin: EdgeInsets.all(Sizes.dp5(context)),
                              child: _chairStatus[i][x - 1] == 1
                                  ? ChairConstant.white(context, _isDarkTheme)
                                  : _chairStatus[i][x - 1] == 2
                                      ? ChairConstant.grey(context)
                                      : _chairStatus[i][x - 1] == 3
                                          ? ChairConstant.red(context)
                                          : ChairConstant.orange(context),
                            ),
                          ),
                  ),
              ],
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: Sizes.dp20(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _chairCategory(ColorPalettes.white, "FREE", true),
              _chairCategory(ColorPalettes.darkAccent, "YOURS", false),
              _chairCategory(Colors.grey[700], "RESERVED", false),
              _chairCategory(Colors.red[800], "NOT AVAILABLE", false),
            ],
          ),
        ),
      ],
    );
  }

  Color _borderColor(bool isWhite) {
    if (!_isDarkTheme) {
      return ColorPalettes.transparent;
    } else {
      if (isWhite) {
        return ColorPalettes.grey;
      } else {
        return ColorPalettes.transparent;
      }
    }
  }

  Widget _chairCategory(Color color, String category, bool isWhite) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor(isWhite)),
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        Text(
          category,
          style: TextStyle(fontSize: 12, color: ColorPalettes.grey),
        ),
      ],
    );
  }
}
