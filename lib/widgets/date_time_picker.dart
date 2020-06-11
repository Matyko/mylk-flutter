import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerField extends StatefulWidget {
  final DateTime dateTime;
  final Function(DateTime) callback;

  DateTimePickerField(this.dateTime, this.callback);

  @override
  _DateTimePickerFieldState createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {
  final _controller = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.dateTime;
    _controller.value = _controller.value.copyWith(
        text: DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: _selectedDate,
        lastDate: new DateTime(DateTime.now().year + 2));

    if (pickedDate == null) return;

    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: _selectedDate.hour, minute: _selectedDate.minute));

    if (pickedTime != null) {
      final DateTime newDateTime = new DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute);

      _controller.value = _controller.value.copyWith(
          text: DateFormat('yyyy-MM-dd - kk:mm').format(newDateTime)
      );
      setState(() {
        _selectedDate = newDateTime;
      });
      widget.callback(newDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white60,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10.0)
                ),
                labelText: 'Task due'),
            controller: _controller,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please select a time';
              }
              return null;
            },
          ),
        ));
  }
}
