import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardPortfolio extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String url;

  const CardPortfolio({Key key, this.imageAsset, this.title, this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Sizes.dp5(context)),
      child: InkWell(
        onTap: () => Navigation.launchURL(url),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(Sizes.dp10(context)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Sizes.width(context) / 7,
                  width: Sizes.width(context) / 7,
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: Sizes.dp10(context),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.dp18(context),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.dp18(context),
                      ),
                      Text(
                        url,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Sizes.dp14(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
