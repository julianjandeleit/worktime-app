import 'package:flutter/material.dart';
import 'package:work_time_app/util/recipeable.dart';

class ListRecipe<T extends Recipeable> extends StatelessWidget {
  final List<T> itemList;
  final void Function(List<T> items) onChanged;
  final int? selectedIndex; // Add this property to hold the selected index
  final void Function(int index)? onItemSelect; // Add this property

  ListRecipe({
    required this.itemList,
    required this.onChanged,
    this.selectedIndex,
    this.onItemSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(border: Border(left: BorderSide())),
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: selectedIndex == index
                ? Colors.blue.withOpacity(0.1) // Highlight selected item
                : Colors.grey.withOpacity(0.1), // Subtle background color
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
                    onItemSelect?.call(
                        index); // Call the callback when the icon is pressed
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
        ),
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
