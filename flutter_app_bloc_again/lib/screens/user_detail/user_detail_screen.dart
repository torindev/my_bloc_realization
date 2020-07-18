import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:flutter_app_bloc_again/base/stream_builder_with_listener.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/screens/common/widgets/global_settings_title.dart';
import 'package:flutter_app_bloc_again/screens/common/widgets/global_settings_widget.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/widgets/update_button.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/widgets/user_model_fields_widget.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/widgets/user_model_local_title.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

class UserDetailScreen extends StatelessWidget {
  static const routeName = '/user-detail-screen';

  static Future<Object> startScreen(BuildContext context, UserModel userModel) {
    return Navigator.of(context).pushNamed(routeName, arguments: userModel);
  }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = ModalRoute.of(context).settings.arguments;
    UserDetailBloc bloc = Provider.of<UserDetailBloc>(context, listen: false);
    bloc.init(userModel);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: StreamBuilder(
          stream: bloc.editModeStream,
          builder: (ctx, snapshot) {
            return Text(bloc.isEditMode
                ? 'Edit ${userModel.fullName}'
                : userModel.fullName);
          },
        ),
        elevation: 24,
        actions: <Widget>[
          StreamBuilder(
            stream: bloc.editModeStream,
            builder: (ctx, snapshot) {
              return IconButton(
                icon: Icon(bloc.isEditMode ? Icons.close : Icons.edit),
                onPressed: () {
                  bloc.toggleEditMode();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        userModel.photoBig,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              GlobalSettingsTitle(),
              GlobalSettingsWidget(),
              SizedBox(
                height: 24,
              ),
              UserModelLocalTitle(),
              UserModelFieldsWidget(
                userModel: userModel,
              ),
              SizedBox(
                height: 24,
              ),
              UpdateButton(),
            ],
          ),
        ),
      ),
    );
  }
}
