import 'package:flutter/material.dart';
import 'package:work_time_app/util/recipeable.dart';

class ListRecipe<T extends Recipeable> extends StatelessWidget {
  final List<T> itemList;
  final Widget Function(BuildContext context, T item) itemBuilder;

  ListRecipe({
    required this.itemList,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      padding: const EdgeInsets.all(15),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemList.length,
        itemBuilder: (context, index) => itemList[index].buildRecipe(),
      ),
    );
  }
}
