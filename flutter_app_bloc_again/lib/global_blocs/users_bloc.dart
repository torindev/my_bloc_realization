import 'package:flutter_app_bloc_again/base/base_bloc.dart';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:flutter_app_bloc_again/base/bloc_controller.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/utils/lgi.dart';

class UsersBloc implements BaseBloc {
  List<UserModel> _users = [
    UserModel.randomFemale(),
    UserModel.randomFemale(),
    UserModel.randomMale(),
    UserModel.randomFemale(),
    UserModel.randomMale(),
    UserModel.randomFemale(),
  ];
  List<UserModel> get users => [..._users];

  BlocController _loadUsersController = BlocController();
  Stream<BaseState> get loadUsersStream => _loadUsersController.stream;

  int _loadingTimeInMs = 1500;
  int get loadingTimeInMs => _loadingTimeInMs;

  BlocController _loadingTimeController = BlocController();
  Stream<BaseState> get loadingTimeStream => _loadingTimeController.stream;

  bool _isGenerateErrorLoadingUsers = false;
  bool get isGenerateErrorLoadingUsers => _isGenerateErrorLoadingUsers;

  BlocController _generateErrorController = BlocController();
  Stream<BaseState> get generateErrorStream => _generateErrorController.stream;

  void toggleLoadingUsersError(bool value) async {
    _isGenerateErrorLoadingUsers = value;
    _generateErrorController.onUpdateState();
  }

  void increaseLoadingTime() async {
    _loadingTimeInMs += 100;
    _loadingTimeController.onUpdateState();
  }

  void decreaseLoadingTime() async {
    if (_loadingTimeInMs > 150) {
      _loadingTimeInMs -= 100;
      _loadingTimeController.onUpdateState();
    }
  }

  void loadUsers() async {
    try {
      Lgi.p('load users #1');
      if (_loadUsersController.isLoading()) {
        Lgi.p('load users #2');
        return;
      }
      Lgi.p('load users #3');
      _loadUsersController.onLoading();
      await Future.delayed(Duration(milliseconds: _loadingTimeInMs));
      if (isGenerateErrorLoadingUsers) {
        throw Exception('Some custom Exception');
      }
      _loadUsersController.onUpdateState();
    } catch (error) {
      _loadUsersController.onError(error);
    }
  }

  @override
  void dispose() {
    _loadUsersController.dispose();
    _loadingTimeController.dispose();
    _generateErrorController.dispose();
  }
}
