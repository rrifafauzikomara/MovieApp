import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CustomDialog extends StatelessWidget {
  final bool isDark, groupValue;
  final ValueChanged<bool> onChanged;

  const CustomDialog({Key key, this.isDark, this.groupValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Switch Theme"),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: true,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Text('Dark'),
            ],
          ),
        ),
        SizedBox(
          height: Sizes.dp10(context),
        ),
        Padding(
          padding: EdgeInsets.only(left: Sizes.dp10(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Radio(
                value: false,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
              Text('Light'),
            ],
          ),
        ),
      ],
    );
  }
}
