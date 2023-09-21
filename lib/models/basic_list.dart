import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:work_time_app/recipes/agglistrecipe.dart';
import 'package:work_time_app/recipes/listrecipe.dart';
import '../util/recipeable.dart';

part 'basic_list.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class BasicList<T extends Recipeable> extends Recipeable {
  final List<T> items;
  final bool selectable;
  final int? selectedIndex;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final void Function()? onAdd;
  //TODO: can these "interactive abilities" somehow be aggregated and generalized in a formal way for all recipeables? The above (at least some form of derived state) and especially this callback!
  // also when duplicating new instances these variables need to be taken care of each individually...

  BasicList(
      {required this.items,
      this.selectable = false,
      this.selectedIndex = null,
      this.onAdd = null});

  factory BasicList.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BasicListFromJson<T>(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() =>
      _$BasicListToJson<T>(this, (item) => item.toJson());

  BasicList<T> buildChangedInstance(List<T> items) {
    print("changed list");
    var new_selected_index = null;
    if (items.isEmpty) {
      new_selected_index = null;
    } else if (items.length > this.items.length) {
      new_selected_index = selectedIndex;
    } else if (items.length < this.items.length) {
      new_selected_index = 0;
    } else {
      new_selected_index = selectedIndex;
    }
    return BasicList(
        items: items,
        selectable: selectable,
        selectedIndex: new_selected_index,
        onAdd: onAdd);
  }

//TODO: how to conceptualize differend kinds of views for the same data? new class? give option on onRecipe?
// should other visualizations have other abilities?
// some sort of visualizer class given as generic?
  @override
  Widget buildRecipe({void Function(Recipeable p1)? onChanged}) {
    return ListRecipe<T>(
      itemList: items,
      onChanged: (items) => onChanged?.call(buildChangedInstance(items)),
      selectedIndex: selectedIndex,
      onItemSelect: selectable
          ? (index) {
              onChanged?.call(BasicList(
                  items: items,
                  selectable: selectable,
                  selectedIndex: index,
                  onAdd: onAdd));
            }
          : null,
      onAdd: onAdd,
    );
  }

  @override
  Widget buildAggregation({void Function(Recipeable p1)? onChanged}) {
    return AggListRecipe<T>(
      itemList: items,
      onChanged: (items) => onChanged?.call(buildChangedInstance(items)),
      selectedIndex: selectedIndex,
      onItemSelect: selectable
          ? (index) {
              onChanged?.call(BasicList(
                  items: items,
                  selectable: selectable,
                  selectedIndex: index,
                  onAdd: onAdd));
            }
          : null,
      onAdd: onAdd,
    );
  }
}
