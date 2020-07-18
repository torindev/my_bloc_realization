import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/global_blocs/users_bloc.dart';
import 'package:provider/provider.dart';

class GlobalBlocsApp extends StatelessWidget {
  final Widget child;

  const GlobalBlocsApp({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UsersBloc>(
          create: (ctx) => UsersBloc(),
          dispose: (ctx, bloc) => bloc.dispose(),
        ),
      ],
      child: child,
    );
  }
}
