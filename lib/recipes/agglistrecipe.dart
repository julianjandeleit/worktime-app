import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:work_time_app/recipes/listrecipe.dart';
import 'package:work_time_app/util/recipeable.dart';


class AggListRecipe<T extends Recipeable> extends StatelessWidget {
  final List<T> itemList;
  final void Function(List<T> items) onChanged;
  final int? selectedIndex;
  final void Function(int index)? onItemSelect;

  final void Function()? onAdd; // Add this property for the add button

  const AggListRecipe({super.key, 
    required this.itemList,
    required this.onChanged,
    this.selectedIndex,
    this.onItemSelect,
    this.onAdd, // Initialize the property
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Edit List'),
                      content: SizedBox(
                          height: 400,
                          width: 500,
                          child: ListRecipe(
                            itemList: itemList,
                            onChanged: (items) {
                              onChanged(items);
                              Navigator.pop(context);
                            },
                            onItemSelect: onItemSelect != null
                                ? (index) {
                                    onItemSelect!(index);
                                    Navigator.pop(context);
                                  }
                                : null,
                            selectedIndex: selectedIndex,
                            onAdd: onAdd != null
                                ? () {
                                    onAdd!();
                                    Navigator.pop(context);
                                  }
                                : null,
                          )),
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit)),
          Expanded(
            child: Container(
              decoration:
                  const BoxDecoration(border: Border(left: BorderSide())),
              padding: const EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Listener(
                  onPointerSignal: (event) {
                    if (event is PointerScrollEvent) {
                      final offset = event.scrollDelta.direction *
                          event.scrollDelta.distance *
                          0.25;
                      scrollController
                          .jumpTo(scrollController.offset + offset);
                    }
                  },
                  child: Scrollbar(
                    controller: scrollController,
                    child: ListView.separated(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemList
                          .length, // Add an extra item for the Add button
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: MouseRegion(
                              cursor:
                                  onItemSelect != null && index != selectedIndex
                                      ? SystemMouseCursors.click
                                      : MouseCursor.defer,
                              child: GestureDetector(
                                onTap: onItemSelect != null &&
                                        index != selectedIndex
                                    ? () {
                                        onItemSelect!(index);
                                      }
                                    : null,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? Colors.blue.withOpacity(0.1)
                                        : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  width: max(constraints.maxWidth / 4.0,
                                      constraints.minWidth),
                                  child: itemList[index].buildAggregation(
                                    onChanged: (p0) {
                                      final copiedList = [...itemList];
                                      copiedList[index] = p0 as T;
                                      onChanged(copiedList);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                        margin: const EdgeInsets.all(15),
                        child: Divider(
                          color: Colors.black.withOpacity(0.75),
                          endIndent: 15,
                          thickness: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
