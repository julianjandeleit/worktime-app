import 'package:flutter/material.dart';
import 'package:work_time_app/util/recipeable.dart';

import 'package:flutter/material.dart';
import 'package:work_time_app/util/recipeable.dart';

class ListRecipe<T extends Recipeable> extends StatelessWidget {
  final List<T> itemList;
  final void Function(List<T> items) onChanged;
  final int? selectedIndex;
  final void Function(int index)? onItemSelect;
  final void Function()? onAdd; // Add this property for the add button

  ListRecipe({
    required this.itemList,
    required this.onChanged,
    this.selectedIndex,
    this.onItemSelect,
    this.onAdd, // Initialize the property
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemList.length +
            (onAdd != null ? 1 : 0), // Add an extra item for the Add button
        itemBuilder: (context, index) {
          if (index < itemList.length) {
            return Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      final copiedList = [...itemList];
                      copiedList.removeAt(index);
                      onChanged(copiedList);
                    },
                  ),
                  if (onItemSelect != null)
                    IconButton(
                      icon: Icon(selectedIndex == index
                          ? Icons.circle
                          : Icons.circle_outlined),
                      onPressed: () {
                        onItemSelect?.call(index);
                      },
                    ),
                  Expanded(
                    child: itemList[index].buildRecipe(
                      onChanged: (p0) {
                        final copiedList = [...itemList];
                        copiedList[index] = p0 as T;
                        onChanged(copiedList);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (index == itemList.length && onAdd != null) {
            // Show the Add button
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Icon(Icons.add_outlined),
                ),
              ],
            );
          }
          return const SizedBox(); // Return an empty container for other cases
        },
        separatorBuilder: (BuildContext context, int index) => Container(
          margin: const EdgeInsets.all(15),
          child: Divider(
            color: Colors.black.withOpacity(0.75),
            endIndent: 15,
            thickness: 3,
          ),
        ),
      ),
    );
  }
}
