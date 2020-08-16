import 'package:flutter/material.dart';
import 'package:moviecatalogue/ui/dashboard/dashboard_screen.dart';
import 'package:shared/shared.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = '/booking';

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  var _dateSelectorAcList = List<AnimationController>();
  var _dateSelectorTweenList = List<Animation<double>>();
  var _timeSelectorAcList = List<AnimationController>();
  var _timeSelectorTweenList = List<Animation<double>>();

  AnimationController _dateBackgroundAc;
  Animation<double> _dateBackgroundTween;
  AnimationController _cinemaScreenAc;
  AnimationController _payButtonAc;
  Animation<double> _payButtonTween;

  bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    // initialize dateSelector List
    for (int i = 0; i < 7; i++) {
      _dateSelectorAcList.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)));
      _dateSelectorTweenList.add(Tween<double>(begin: 1000, end: 0)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(_dateSelectorAcList[i]));
      Future.delayed(Duration(milliseconds: i * 50 + 170), () {
        _dateSelectorAcList[i].forward();
      });
    }

    // initialize dateSelector Background
    _dateBackgroundAc =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _dateBackgroundTween = Tween<double>(begin: 1000, end: 0)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_dateBackgroundAc);
    Future.delayed(Duration(milliseconds: 150), () {
      _dateBackgroundAc.forward();
    });

    // initialize timeSelector List
    for (int i = 0; i < 3; i++) {
      _timeSelectorAcList.add(AnimationController(
          vsync: this, duration: Duration(milliseconds: 500)));
      _timeSelectorTweenList.add(Tween<double>(begin: 1000, end: 0)
          .chain(CurveTween(curve: Curves.easeOutCubic))
          .animate(_dateSelectorAcList[i]));
      Future.delayed(Duration(milliseconds: i * 25 + 100), () {
        _timeSelectorAcList[i].forward();
      });
    }

    // initialize cinemaScreen
    _cinemaScreenAc = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    Future.delayed(Duration(milliseconds: 800), () {
      _cinemaScreenAc.forward();
    });

    // paybutton
    _payButtonAc = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _payButtonTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_payButtonAc);
    Future.delayed(Duration(milliseconds: 800), () {
      _payButtonAc.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    _isDarkTheme = themeData.appBarTheme?.color == null;
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: !_isDarkTheme ? ColorPalettes.darkPrimary : ColorPalettes.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(args.movies.title),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Sizes.dp20(context), left: Sizes.dp20(context), bottom: Sizes.dp20(context)),
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: <Widget>[
                    DateWidget(
                      dateBackgroundAc: _dateBackgroundAc,
                      dateBackgroundTween: _dateBackgroundTween,
                      dateSelectorAcList: _dateSelectorAcList,
                      dateSelectorTweenList: _dateSelectorTweenList,
                    ),
                    TimeWidget(
                      timeSelectorAcList: _timeSelectorAcList,
                      timeSelectorTweenList: _timeSelectorTweenList,
                    ),
                    CinemaWidget(movieBackground: args.movies.backdropPath),
                    SizedBox(height: Sizes.width(context) / 5),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _payButton(),
          ),
        ],
      ),
    );
  }

  Widget _payButton() {
    return AnimatedBuilder(
      animation: _payButtonAc,
      builder: (ctx, child) {
        double opacity() {
          if (_payButtonTween.value + 1 < 0.2) {
            return (_payButtonTween.value + 1) * 5;
          }
          return 1;
        }
        return Transform.translate(
          offset: Offset(0, _payButtonTween.value * 200),
          child: Opacity(opacity: opacity(), child: child),
        );
      },
      child: CustomButton(
        text: "Pay",
        onPressed: () {
          SmoothDialog(
            context: context,
            path: ImagesAssets.successful,
            mode: SmoothMode.Lottie,
            content: "Thanks for your movie ticket order",
            title: "Payment Successful!",
            submit: () {
              Navigation.intentWithClearAllRoutes(context, DashBoardScreen.routeName);
            },
          );
        },
      ),
    );
  }
}
