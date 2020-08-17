import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class TimeWidget extends StatefulWidget {
  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> with TickerProviderStateMixin {
  var _timeSelectorAcList = List<AnimationController>();
  var _timeSelectorTweenList = List<Animation<double>>();
  bool _isDarkTheme;

  var _time = [
    ["01.30", 45],
    ["06.30", 45],
    ["10.30", 45]
  ];
  var _timeIndexSelected = 1;

  @override
  void initState() {
    super.initState();
    // initialize timeSelector List
    for (int i = 0; i < 3; i++) {
      _timeSelectorAcList.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)));
      _timeSelectorTweenList.add(Tween<double>(begin: 1000, end: 0)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(_timeSelectorAcList[i]));
      Future.delayed(Duration(milliseconds: i * 25 + 100), () {
        _timeSelectorAcList[i].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    _isDarkTheme = themeData.appBarTheme?.color == null;
    return Container(
      width: Sizes.width(context),
      height: Sizes.width(context) / 5,
      margin: EdgeInsets.symmetric(vertical: Sizes.dp20(context)),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (ctx, index) {
          return AnimatedBuilder(
            animation: _timeSelectorAcList[index],
            builder: (ctx, child) {
              return Transform.translate(
                offset: Offset(_timeSelectorTweenList[index].value, 0),
                child: child,
              );
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _timeIndexSelected = index;
                });
              },
              child: _timeItem(
                _time[index][0],
                _time[index][1],
                index == _timeIndexSelected ? true : false,
              ),
            ),
          );
        },
      ),
    );
  }

  Color _textTimeColor(bool active) {
    if (!_isDarkTheme) {
      if (active) {
        return ColorPalettes.darkAccent;
      } else {
        return ColorPalettes.white;
      }
    } else {
      if (active) {
        return ColorPalettes.darkAccent;
      } else {
        return ColorPalettes.darkBG;
      }
    }
  }

  Widget _timeItem(String time, int price, bool active) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Sizes.dp12(context)),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dp16(context)),
      decoration: BoxDecoration(
        border: Border.all(color: _textTimeColor(active), width: 1),
        borderRadius: BorderRadius.circular(Sizes.dp12(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: time,
              style: TextStyle(
                fontSize: Sizes.dp20(context),
                fontWeight: FontWeight.w600,
                color: _textTimeColor(active),
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' PM',
                  style: TextStyle(
                    fontSize: Sizes.dp14(context),
                    fontWeight: FontWeight.w600,
                    color: _textTimeColor(active),
                  ),
                )
              ],
            ),
          ),
          Text(
            "IDR ${price}K",
            style: TextStyle(
              fontSize: Sizes.dp14(context),
              fontWeight: FontWeight.w600,
              color: ColorPalettes.grey,
            ),
          ),
        ],
      ),
    );
  }
}
