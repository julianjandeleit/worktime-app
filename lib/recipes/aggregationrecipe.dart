import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AggregationRecipe extends StatefulWidget {
  final String heading;
  final List<String> names;
  final List<String> values;
  //final void Function(String) onChanged;
  final Widget Function()? buildDetails;

  const AggregationRecipe(
      {super.key, required this.heading,
      required this.names,
      required this.values,
      this.buildDetails});

  @override
  _AggregationRecipeState createState() => _AggregationRecipeState();
}

Iterable<T> zip_alternating<T>(Iterable<T> a, Iterable<T> b) sync* {
  final ita = a.iterator;
  final itb = b.iterator;
  bool hasa, hasb;
  while ((hasa = ita.moveNext()) | (hasb = itb.moveNext())) {
    if (hasa) yield ita.current;
    if (hasb) yield itb.current;
  }
}

class _AggregationRecipeState extends State<AggregationRecipe> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.names.length != widget.values.length) {
      throw Exception("same number of names and values required");
    }

    var names = widget.names.map(
      (e) => Align(
        alignment: Alignment.center,
        child: Text(
          e,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );

    var values = widget.values.map(
      (e) => Align(
        alignment: Alignment.center,
        child: Text(
          e,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    );

    final widgets = zip_alternating(names, values).toList();

    return MouseRegion(
      cursor: widget.buildDetails != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onLongPress: widget.buildDetails != null
            ? () {
                //TODO: how to make dialog keep changes
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                          'Edit ${widget.heading} (does not reflect changes)'),
                      content: SizedBox(
                          height: 400,
                          width: 500,
                          child: widget.buildDetails!.call()),
                    );
                  },
                );
              }
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(widget.heading),
            ),
            AlignedGridView.count(
              shrinkWrap: true,
              itemCount: widgets.length,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return widgets[index];
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
