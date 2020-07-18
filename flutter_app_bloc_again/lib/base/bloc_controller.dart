import 'dart:async';
import 'package:flutter_app_bloc_again/base/base_states.dart';
import 'package:rxdart/rxdart.dart';

class BlocController {
  final BehaviorSubject<BaseState> _streamController =
      BehaviorSubject<BaseState>();
  Stream<BaseState> get stream => _streamController.stream;

  void onLoading() {
    addState(LoadingState());
  }

  bool isLoading() {
    return _streamController.value is LoadingState;
  }

  void onUpdateState() {
    addState(UpdateState());
  }

  void onError(dynamic error) {
    addState(ErrorState(error));
  }

  void addState(BaseState state) {
    _streamController.sink.add(state);
  }

  void dispose() {
    _streamController.close();
  }
}
