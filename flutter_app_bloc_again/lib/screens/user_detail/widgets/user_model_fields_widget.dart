import 'package:flutter/material.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:provider/provider.dart';

import 'edit_text_widget.dart';

class UserModelFieldsWidget extends StatelessWidget {
  final UserModel userModel;

  const UserModelFieldsWidget({
    Key key,
    @required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailBloc bloc = Provider.of<UserDetailBloc>(context, listen: false);
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Full name:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              StreamBuilder(
                stream: bloc.editModeStream,
                builder: (ctx, snapshot) {
                  if (bloc.isEditMode) {
                    return EditTextWidget(
                      initialText: bloc.fullName,
                      hint: 'Edit full name',
                      onTextChange: (text) {
                        bloc.updateFullName(text);
                      },
                    );
                  } else {
                    return Text(userModel.fullName);
                  }
                },
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Salary \$:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 24,
              ),
              StreamBuilder(
                stream: bloc.editModeStream,
                builder: (ctx, snapshot) {
                  if (bloc.isEditMode) {
                    return EditTextWidget(
                      initialText: bloc.salary,
                      hint: 'Edit salary',
                      onTextChange: (text) {
                        bloc.updateSalary(text);
                      },
                    );
                  } else {
                    return Text('${userModel.salary}');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
