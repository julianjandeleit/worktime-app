import 'package:flutter/material.dart';

import '../util/recipeable.dart';

class ClassRecipe<T extends Recipeable> extends StatefulWidget {
  final T item;
  final void Function(T) onChanged;
  final T Function(Map<String, dynamic>) fromJsonT; // Add this

  ClassRecipe({
    required this.item,
    required this.onChanged,
    required this.fromJsonT, // Add this
  });

  @override
  _ClassRecipeState<T> createState() => _ClassRecipeState<T>();
}

class _ClassRecipeState<T extends Recipeable> extends State<ClassRecipe<T>> {
  late Map<String, TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = widget.item.toJson().map(
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
              final updatedItem = widget.fromJsonT(
                  {...widget.item.toJson(), attributeName: controller.text});
              widget.onChanged(updatedItem);
            },
          ),
        );
      },
    );
  }
}
