import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:flutter_app_bloc_again/base/stream_builder_with_listener.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/custom_states.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserDetailBloc bloc = Provider.of<UserDetailBloc>(context, listen: false);
    return StreamBuilder(
      stream: bloc.editModeStream,
      builder: (ctx, _) {
        return StreamBuilderWithListener(
          initialData: UpdateState(),
          listener: (baseState) {
            if (baseState is OnUserModelChanged) {
              Navigator.of(context).pop();
            }
          },
          stream: bloc.dataIsChangedStream,
          builder: (ctx, snapshot) {
            return BaseStateHandler(
              snapshot,
              onUpdate: () {
                return Visibility(
                  visible: bloc.isEditMode,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 200,
                        child: RaisedButton(
                          color: Colors.green,
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: bloc.isButtonSaveEnabled
                              ? () {
                                  bloc.onClickSave();
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
              onLoading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              onCustomState: (state) {
                return Container();
              },
            );
          },
        );
      },
    );
  }
}
