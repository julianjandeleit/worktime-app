import 'package:flutter/material.dart';
import 'package:work_time_app/models/Project.dart';

import '../util/recipeable.dart';

class ClassRecipe<T extends Recipeable> extends StatelessWidget {
  final T item;
  final void Function(T) onChanged;
  // Important: this should call fromJson constructors, not pass on existing instances
  final Recipeable Function(Map<String, dynamic>, {String? attrname}) fromJson;

  ClassRecipe({
    required this.item,
    required this.onChanged,
    required this.fromJson,
  });

  @override
  Widget build(BuildContext context) {
    //widget.item.toJson().entries.map((e) => widget.fromJsonT({e.key: e.value}))
    print(item.toJson().entries.map((e) => e.key));
    final children = item.toJson().entries;
    return ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, index) {
        final attributeName = children.elementAt(index).key;
        final attributeJson = children.elementAt(index).value;

        //print("full model ${item.toJson()}");
        print("attr model json ${attributeName} ${attributeJson}");
        final model = fromJson(attributeJson, attrname: attributeName);
        //return Container();
        return model.buildRecipe(
          onChanged: (p0) {
            final updated =
                fromJson({...item.toJson(), attributeName: p0.toJson()});
            onChanged(updated as T);
          },
        );
      },
    );
  }
}
