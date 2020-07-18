import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/global_blocs/users_bloc.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/user_detail_screen.dart';
import 'package:provider/provider.dart';

class UserItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersBloc = Provider.of<UsersBloc>(context, listen: false);
    final userModel = Provider.of<UserModel>(context);
    return GestureDetector(
      onTap: () {
        UserDetailScreen.startScreen(context, userModel);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                userModel.photoSmall,
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userModel.fullName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  child: Text(
                    'id: ${userModel.id}',
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '\$${userModel.salary.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
