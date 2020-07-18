import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/global_blocs/users_bloc.dart';
import 'package:flutter_app_bloc_again/screens/common/widgets/global_settings_title.dart';
import 'package:flutter_app_bloc_again/screens/common/widgets/global_settings_widget.dart';
import 'package:flutter_app_bloc_again/screens/users_list/widgets/users_list_widget.dart';
import 'package:flutter_app_bloc_again/utils/lgi.dart';
import 'package:provider/provider.dart';

class UsersListScreen extends StatelessWidget {
  static const routeName = '/users-list-screen';

  static Future<Object> startScreen(BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    final usersBloc = Provider.of<UsersBloc>(context, listen: false);
    Lgi.p('');
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list'),
        backgroundColor: Colors.amber,
        elevation: 24,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            GlobalSettingsTitle(),
            GlobalSettingsWidget(),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              color: Colors.orange,
              elevation: 12,
              child: Text(
                'Reload',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                usersBloc.loadUsers();
              },
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: UsersListWidget(),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
