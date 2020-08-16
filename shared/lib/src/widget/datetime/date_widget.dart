import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DateWidget extends StatefulWidget {
  final AnimationController dateBackgroundAc;
  final Animation<double> dateBackgroundTween;
  final List<AnimationController> dateSelectorAcList;
  final List<Animation<double>> dateSelectorTweenList;

  const DateWidget(
      {Key key,
      @required this.dateBackgroundAc,
      @required this.dateBackgroundTween,
      @required this.dateSelectorAcList,
      @required this.dateSelectorTweenList})
      : super(key: key);

  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  var _currentDate = DateTime.now();
  var _dateIndexSelected = 1;
  bool _isDarkTheme;

  Color _textDateColor(int index) {
    if (!_isDarkTheme) {
      if (index == _dateIndexSelected) {
        return ColorPalettes.black;
      } else {
        return ColorPalettes.white;
      }
    } else {
      if (index == _dateIndexSelected) {
        return ColorPalettes.white;
      } else {
        return ColorPalettes.black;
      }
    }
  }

  Color _backgroundColor() {
    if (!_isDarkTheme) {
      return ColorPalettes.white.withOpacity(.1);
    } else {
      return ColorPalettes.black.withOpacity(.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    _isDarkTheme = themeData.appBarTheme?.color == null;
    return Container(
      height: Sizes.width(context) / 3.5,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          AnimatedBuilder(
            animation: widget.dateBackgroundAc,
            builder: (ctx, child) {
              return Transform.translate(
                offset: Offset(widget.dateBackgroundTween.value, 0),
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: _backgroundColor(),
                borderRadius: BorderRadius.all(Radius.circular(Sizes.dp10(context))),
              ),
            ),
          ),
          ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 7,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              var date = _currentDate.add(Duration(days: index));
              return AnimatedBuilder(
                animation: widget.dateSelectorAcList[index],
                builder: (ctx, child) {
                  return Transform.translate(
                    offset:
                        Offset(widget.dateSelectorTweenList[index].value, 0),
                    child: child,
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _dateIndexSelected = index;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: Sizes.dp25(context),
                      left: Sizes.dp10(context),
                      right: Sizes.dp10(context),
                      bottom: Sizes.dp25(context),
                    ),
                    width: Sizes.width(context) / 10,
                    decoration: BoxDecoration(
                      color: _dateIndexSelected == index
                          ? ColorPalettes.darkAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        Sizes.dp5(context),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          DateTimeFormat.day(date.weekday),
                          style: TextStyle(
                            fontSize: Sizes.dp12(context),
                            fontWeight: FontWeight.w600,
                            color: _textDateColor(index),
                          ),
                        ),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: Sizes.dp22(context),
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: _textDateColor(index),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
