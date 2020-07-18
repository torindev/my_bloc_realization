import 'package:flutter_app_bloc_again/base/base_bloc.dart';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:flutter_app_bloc_again/base/bloc_controller.dart';
import 'package:flutter_app_bloc_again/models/user_model.dart';
import 'package:flutter_app_bloc_again/screens/user_detail/bloc/custom_states.dart';
import 'package:flutter_app_bloc_again/utils/lgi.dart';

class UserDetailBloc extends BaseBloc {
  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;

  bool _isButtonSaveEnabled = false;
  bool get isButtonSaveEnabled => _isButtonSaveEnabled;

  BlocController _editModeController = BlocController();
  Stream<BaseState> get editModeStream => _editModeController.stream;

  BlocController _dataIsChangedController = BlocController();
  Stream<BaseState> get dataIsChangedStream => _dataIsChangedController.stream;

  String _fullName = '';
  String get fullName => '$_fullName';

  String _salary = '';
  String get salary => '$_salary';

  UserModel _initialUserModel;

  void updateFullName(String s) {
    _fullName = s;
    _dataIsChanged();
  }

  void updateSalary(String s) {
    _salary = s;
    _dataIsChanged();
  }

  void onClickSave() async {
    _dataIsChangedController.onLoading();
    await Future.delayed(Duration(milliseconds: 1500));
    _initialUserModel.updateFields(fullName, salary);
    _dataIsChangedController.addState(OnUserModelChanged());
  }

  void _dataIsChanged() async {
    if (_salary.isEmpty ||
        _fullName.isEmpty ||
        (_salary == _initialUserModel.salary.toString() &&
            _fullName == _initialUserModel.fullName)) {
      _isButtonSaveEnabled = false;
    } else {
      _isButtonSaveEnabled = true;
    }

    _dataIsChangedController.onUpdateState();
  }

  void init(UserModel userModel) {
    Lgi.p('111111');
    _initialUserModel = userModel;
    _fullName = userModel.fullName;
    _salary = userModel.salary.toString();
  }

  void toggleEditMode() async {
    _isEditMode = !_isEditMode;
    _editModeController.onUpdateState();
  }

  @override
  void dispose() {
    _editModeController.dispose();
    _dataIsChangedController.dispose();
    super.dispose();
  }
}
