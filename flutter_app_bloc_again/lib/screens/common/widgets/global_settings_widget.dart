import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/base/stream_builder_with_listener.dart';
import 'package:flutter_app_bloc_again/global_blocs/users_bloc.dart';
import 'package:flutter_app_bloc_again/utils/lgi.dart';
import 'package:provider/provider.dart';

class GlobalSettingsWidget extends StatelessWidget {
  const GlobalSettingsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersBloc = Provider.of<UsersBloc>(context, listen: false);
    Lgi.p('');
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: Colors.black.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Set loading time (ms):'),
              SizedBox(
                width: 16,
              ),
              IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  usersBloc.decreaseLoadingTime();
                },
              ),
              StreamBuilderWithListener(
                stream: usersBloc.loadingTimeStream,
                listener: (baseState) {
                  Lgi.p('listener loadingTime');
                },
                builder: (ctx, snapshot) {
                  Lgi.p('update loadingTime label');
                  return Text(usersBloc.loadingTimeInMs.toString());
                },
              ),
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  usersBloc.increaseLoadingTime();
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('generate error:'),
              SizedBox(
                width: 16,
              ),
              StreamBuilderWithListener(
                stream: usersBloc.generateErrorStream,
                listener: (baseState) {
                  Lgi.p('listener generateError');
                },
                builder: (ctx, snapshot) {
                  return Checkbox(
                    value: usersBloc.isGenerateErrorLoadingUsers,
                    onChanged: (value) {
                      Lgi.p('update loadingError label');
                      usersBloc.toggleLoadingUsersError(value);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
