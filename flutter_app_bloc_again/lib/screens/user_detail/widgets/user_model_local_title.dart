import 'package:flutter/material.dart';

class UserModelLocalTitle extends StatelessWidget {
  const UserModelLocalTitle({
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
        'UserModel (Local)',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
