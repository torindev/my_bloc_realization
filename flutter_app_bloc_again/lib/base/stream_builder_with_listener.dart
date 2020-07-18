import 'package:flutter/material.dart';

typedef StreamBuilderListener<T> = void Function(T data);

class StreamBuilderWithListener<T> extends StreamBuilder<T> {
  //by Eugene Brusov https://stackoverflow.com/questions/54101589/navigating-to-a-new-screen-when-stream-value-in-bloc-changes
  final StreamBuilderListener<T> listener;

  const StreamBuilderWithListener({
    Key key,
    T initialData,
    Stream<T> stream,
    @required this.listener,
    @required AsyncWidgetBuilder<T> builder,
  }) : super(
            key: key,
            initialData: initialData,
            stream: stream,
            builder: builder);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    listener(data);
    return super.afterData(current, data);
  }
}
