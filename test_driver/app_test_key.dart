import 'package:flutter_driver/flutter_driver.dart';

/**
 * Please don't use "package:shared/shared.dart" imported
 * You can check the reason and the issue from this:
 * https://github.com/flutter/flutter/issues/56192#issuecomment-624101352
 */

import '../libraries/shared/lib/src/common/utils/movies_key.dart';

// home screen
final homeKey = find.byValueKey(KEY_BOTTOM_NAVIGATION);
final tapBottomNowPlayingKey = find.byValueKey(KEY_BOTTOM_NAVIGATION_NOW_PLAYING);
final tapBottomUpComingKey = find.byValueKey(KEY_BOTTOM_NAVIGATION_UP_COMING);
final tapBottomPopularKey = find.byValueKey(KEY_BOTTOM_NAVIGATION_POPULAR);
final tapBottomTopKey = find.byValueKey(KEY_BOTTOM_NAVIGATION_TOP);
final tapBottomAboutKey = find.byValueKey(KEY_BOTTOM_NAVIGATION_ABOUT);

// detail screen
final tapItemFavoriteKey = find.byValueKey(KEY_TAP_ITEM_FAVORITE);
final tapBackButtonKey = find.byValueKey(KEY_TAP_BACK_BUTTON);

// now playing screen
final tapListViewNowPlayingKey = find.byValueKey(KEY_LIST_VIEW_NOW_PLAYING);
final tapItemNowPlayingKey = find.byValueKey(KEY_TAP_ITEM_NOW_PLAYING);

// up coming screen
final tapListViewUpComingKey = find.byValueKey(KEY_LIST_VIEW_UP_COMING);
final tapItemUpComingKey = find.byValueKey(KEY_TAP_ITEM_UP_COMING);

// popular screen
final tapListViewPopularKey = find.byValueKey(KEY_LIST_VIEW_POPULAR);
final tapItemPopularKey = find.byValueKey(KEY_TAP_ITEM_POPULAR);

// top rated screen
final tapListViewTopRatedKey = find.byValueKey(KEY_LIST_VIEW_TOP);
final tapItemTopRatedKey = find.byValueKey(KEY_TAP_ITEM_TOP);

// about screen