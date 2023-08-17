import 'package:flutter/material.dart';

class ListRecipe<T> extends StatelessWidget {
  final List<T> itemList;
  final Widget Function(BuildContext context, T item) itemBuilder;

  ListRecipe({
    required this.itemList,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final item = itemList[index];
        return itemBuilder(context, item);
      },
    );
  }
}
