import 'package:flutter/material.dart';

class GlobalSettingsTitle extends StatelessWidget {
  const GlobalSettingsTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Text(
        'UsersBloc (Global) Settings',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
