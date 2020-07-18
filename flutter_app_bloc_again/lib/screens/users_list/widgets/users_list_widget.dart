import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:flutter_app_bloc_again/base/stream_builder_with_listener.dart';
import 'package:flutter_app_bloc_again/global_blocs/users_bloc.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/screens/users_list/widgets/user_item_widget.dart';
import 'package:flutter_app_bloc_again/utils/lgi.dart';
import 'package:provider/provider.dart';

class UsersListWidget extends StatelessWidget {
  const UsersListWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersBloc = Provider.of<UsersBloc>(context, listen: false);
    Lgi.p('build in UsersListWidget');
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      child: StreamBuilderWithListener(
        // if comment next line, then in builder we get null in snapshot.data
        initialData: InitialState(),
        listener: (baseState) {},
        stream: usersBloc.loadUsersStream,
        builder: (ctx, snapshot) {
          return BaseStateHandler(
            snapshot,
            onInitial: () {
              return Center(
                child: Container(
                  child: Text('Initial state'),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
            onLoading: () {
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(
                    24,
                  ),
                ),
              );
            },
            onUpdate: () {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  UserModel userModel = usersBloc.users[index];
                  return ChangeNotifierProvider<UserModel>.value(
                    value: userModel,
                    child: UserItemWidget(),
                  );
                },
                itemCount: usersBloc.users.length,
              );
            },
            onError: (error) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(error.toString()),
                      FlatButton(
                        color: Colors.red,
                        child: Text('Retry'),
                        onPressed: () {
                          usersBloc.loadUsers();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            onCustomState: (baseState) {
              Lgi.p('Custom State');
              return Container(
                child: Text('Custom state'),
              );
            },
            onUnrecognizedState: () {
              Lgi.p('Unrecognized State');
              return Container(
                child: Text('Unrecognized state'),
              );
            },
          );
        },
      ),
    );
  }
}
