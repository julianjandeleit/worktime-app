import 'package:flutter/material.dart';
import 'package:work_time_app/models/basic_neutral.dart';

import '../util/recipeable.dart';

class ClassRecipe<T extends Recipeable> extends StatelessWidget {
  final String name;
  final T item;
  final void Function(T) onChanged;
  // Important: this should call fromJson constructors, not pass on existing instances
  final Recipeable Function(Map<String, dynamic>, {String? attrname}) fromJson;

  const ClassRecipe({super.key, 
    required this.name,
    required this.item,
    required this.onChanged,
    required this.fromJson,
  });

  @override
  Widget build(BuildContext context) {
    //widget.item.toJson().entries.map((e) => widget.fromJsonT({e.key: e.value}))
    //print(item.toJson().entries.map((e) => e.key));
    final children = item.toJson().entries;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: children.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            margin: const EdgeInsets.all(
                12), //TODO: make number/size dependant on available space
            child: Text(
              this.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        }
        final listIndex = index - 1;
        final attributeName = children.elementAt(listIndex).key;
        final attributeJson = children.elementAt(listIndex).value;

        //print("full model ${item.toJson()}");
        // print("attr model json ${attributeName} ${attributeJson}");
        late final Recipeable model;
        if (attributeJson == null) {
          model = BasicNeutral();
        } else {
          model = fromJson(attributeJson, attrname: attributeName);
        }
        //return Container();
        return Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(attributeName)),
            model.buildRecipe(
              onChanged: (p0) {
                final updated =
                    fromJson({...item.toJson(), attributeName: p0.toJson()});
                //    print("inrecipe changed to $p0");
                //    print("calling class onchanged on $updated");
                onChanged(updated as T);
              },
            ),
          ],
        );
      },
    );
  }
}
