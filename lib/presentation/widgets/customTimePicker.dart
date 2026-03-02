import 'package:flutter/material.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final Function(TimeOfDay) onTimeSelected;
  final TimeOfDay initialTime;

  const CustomTimePickerDialog({
    super.key,
    required this.onTimeSelected,
    required this.initialTime,
  });

  @override
  State<CustomTimePickerDialog> createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return TimePickerDialog(
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
  }
}
