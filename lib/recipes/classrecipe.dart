import 'package:flutter/material.dart';

import '../util/serializable.dart';

class ClassRecipe<T extends Serializable> extends StatefulWidget {
  final T item;
  final void Function(T) onChanged;

  ClassRecipe({required this.item, required this.onChanged});

  void _onChangedSerializable(Serializable item) {
    if (item is T) {
      onChanged(item);
    }
  }

  @override
  _ClassRecipeState<T> createState() => _ClassRecipeState<T>();
}

class _ClassRecipeState<T extends Serializable> extends State<ClassRecipe<T>> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = widget.item.toMap().map(
      (key, value) {
        final controller = TextEditingController(text: value.toString());
        controller.addListener(() {
          setState(() {});
        });
        return MapEntry(key, controller);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controllers.length,
      itemBuilder: (context, index) {
        final attributeName = controllers.keys.elementAt(index);
        final controller = controllers[attributeName]!;
        return ListTile(
          title: Text(attributeName),
          subtitle: TextField(
            controller: controller,
            onChanged: (_) {
              final updatedItem = widget.item.fromMap({
                ...widget.item.toMap(),
                attributeName: controller.text,
              });
              widget._onChangedSerializable(updatedItem);
            },
          ),
        );
      },
    );
  }
}
