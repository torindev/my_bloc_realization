import 'package:flutter/material.dart';

// events - это входящие от UI,
// а states это исходящие из блока, на которые реагирует UI

abstract class BaseState {}

class InitialState extends BaseState {}

class LoadingState extends BaseState {}

class UpdateState extends BaseState {}

class ErrorState extends BaseState {
  final dynamic error;

  ErrorState(this.error);
}

//typedef StreamBuilderListener<T> = void Function(T data);
typedef OnInitial = Widget Function();
typedef OnLoading = Widget Function();
typedef OnUpdate = Widget Function();
typedef OnError = Widget Function(dynamic error);
typedef OnCustomState = Widget Function(BaseState state);
typedef OnUnrecognizedState = Widget Function();

class BaseStateHandler extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final OnInitial onInitial;
  final OnLoading onLoading;
  final OnUpdate onUpdate;
  final OnError onError;
  final OnCustomState onCustomState;
  final OnUnrecognizedState onUnrecognizedState;

  const BaseStateHandler(
    this.snapshot, {
    this.onInitial,
    this.onLoading,
    this.onUpdate,
    this.onError,
    this.onCustomState,
    this.onUnrecognizedState,
  });

  @override
  Widget build(BuildContext context) {
    if (snapshot.data is InitialState) {
      return onInitial();
    } else if (snapshot.data is LoadingState) {
      return onLoading();
    } else if (snapshot.data is UpdateState) {
      return onUpdate();
    } else if (snapshot.error != null || snapshot.data is ErrorState) {
      dynamic error = snapshot.error != null ? snapshot.error : snapshot.data;
      return onError(error);
    } else if (snapshot.data != null) {
      return onCustomState(snapshot.data);
    } else {
      return onUnrecognizedState();
    }
  }
}
