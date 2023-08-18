import 'package:flutter/material.dart';
import 'package:work_time_app/util/recipeable.dart';

class ListRecipe<T extends Recipeable> extends StatelessWidget {
  final List<T> itemList;
  final void Function(List<T> items) onChanged;

  ListRecipe({required this.itemList, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (context, index) => itemList[index].buildRecipe(
                onChanged: (p0) {
                  final copiedList = [...itemList];
                  copiedList[index] = p0 as T;

                  onChanged(copiedList);
                },
              ),
          separatorBuilder: (BuildContext context, int index) => Container(
                margin: const EdgeInsets.all(15),
                child: Divider(
                  color: Colors.black.withOpacity(0.75),
                  endIndent: 15,
                  thickness: 3,
                ),
              )),
    );
  }
}
