import 'package:flutter/material.dart';

class DatetimeRecipe extends StatefulWidget {
  final DateTime initialValue;
  final void Function(DateTime) onChanged;

  DatetimeRecipe({required this.initialValue, required this.onChanged});

  @override
  _DatetimeRecipeState createState() => _DatetimeRecipeState();
}

class _DatetimeRecipeState extends State<DatetimeRecipe> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );

      if (pickedTime != null) {
        final DateTime newDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = newDateTime;
          widget.onChanged(_selectedDate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 8.0),
            Text(_selectedDate.toLocal().toString(),
                style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
