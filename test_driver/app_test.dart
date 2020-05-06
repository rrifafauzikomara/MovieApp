import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'app_test_key.dart';

void main() {
  group("Movies Development Test", (){

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("show list now plauing", () async {
      await driver.waitFor(homeKey);
      await driver.waitFor(tapBottomNowPlayingKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.waitFor(tapListViewNowPlayingKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(tapListViewNowPlayingKey, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(tapListViewNowPlayingKey, 0, -600, Duration(milliseconds: 500));
      await driver.scroll(tapListViewNowPlayingKey, 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapItemNowPlayingKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(tapItemFavoriteKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapBackButtonKey);
      await Future.delayed(Duration(seconds: 1));
    });

    test("show list up comming", () async {
      await driver.tap(tapBottomUpComingKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.waitFor(tapListViewUpComingKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(tapListViewUpComingKey, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(tapListViewUpComingKey, 0, -600, Duration(milliseconds: 500));
      await driver.scroll(tapListViewUpComingKey, 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapItemUpComingKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(tapItemFavoriteKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapBackButtonKey);
      await Future.delayed(Duration(seconds: 1));
    });

    test("show list popular", () async {
      await driver.tap(tapBottomPopularKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.waitFor(tapListViewPopularKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(tapListViewPopularKey, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(tapListViewPopularKey, 0, -600, Duration(milliseconds: 500));
      await driver.scroll(tapListViewPopularKey, 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapItemPopularKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(tapItemFavoriteKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapBackButtonKey);
      await Future.delayed(Duration(seconds: 1));
    });

    test("show list top rated", () async {
      await driver.tap(tapBottomTopKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.waitFor(tapListViewTopRatedKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.scroll(tapListViewTopRatedKey, 0, 200, Duration(milliseconds: 500));
      await driver.scroll(tapListViewTopRatedKey, 0, -600, Duration(milliseconds: 500));
      await driver.scroll(tapListViewTopRatedKey, 0, 800, Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapItemTopRatedKey);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(tapItemFavoriteKey);
      await Future.delayed(Duration(seconds: 1));
      await driver.tap(tapBackButtonKey);
      await Future.delayed(Duration(seconds: 1));
    });

    test("show about", () async {
      await driver.tap(tapBottomAboutKey);
    });

  });
}