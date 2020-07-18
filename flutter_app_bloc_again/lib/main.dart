import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/global_blocs_app.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/user_detail_screen.dart';
import 'package:flutter_app_bloc_again/screens/users_list/users_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalBlocsApp(
      child: MaterialApp(
        title: 'Test Drive Bloc',
        initialRoute: UsersListScreen.routeName,
        routes: {
          UsersListScreen.routeName: (ctx) => UsersListScreen(),
          UserDetailScreen.routeName: (ctx) => Provider<UserDetailBloc>(
                create: (ctx) => UserDetailBloc(),
                dispose: (ctx, bloc) => bloc.dispose(),
                child: UserDetailScreen(),
              ),
        },
      ),
    );
  }
}
