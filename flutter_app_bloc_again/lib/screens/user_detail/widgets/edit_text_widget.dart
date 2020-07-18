import 'package:flutter/material.dart';

typedef OnTextChange = void Function(String text);

class EditTextWidget extends StatefulWidget {
  final String initialText;
  final String hint;
  final OnTextChange onTextChange;

  const EditTextWidget({
    Key key,
    @required this.initialText,
    @required this.hint,
    @required this.onTextChange,
  }) : super(key: key);

  @override
  _EditTextWidgetState createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController()..text = widget.initialText;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _textEditingController,
        onChanged: widget.onTextChange,
        decoration: InputDecoration(
//          border: InputBorder.none,
          hintText: widget.hint,
        ),
      ),
    );
  }
}
