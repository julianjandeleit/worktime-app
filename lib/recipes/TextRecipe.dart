import 'package:flutter/material.dart';

class TextRecipe extends StatefulWidget {
  final String initialText;
  final void Function(String) onChanged;

  TextRecipe({required this.initialText, required this.onChanged});

  @override
  _TextRecipeState createState() => _TextRecipeState();
}

class _TextRecipeState extends State<TextRecipe> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Text"),
      subtitle: TextField(
        controller: _controller,
        onChanged: (newValue) {
          widget.onChanged(newValue);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
