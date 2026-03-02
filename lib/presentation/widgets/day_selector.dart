import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DaySelector({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  String _label(DateTime d) {
    final oggi = DateTime.now();
    if (d.year == oggi.year && d.month == oggi.month && d.day == oggi.day) {
      return 'Oggi';
    }
    return '${d.day}/${d.month}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () =>
                onDateChanged(selectedDate.subtract(const Duration(days: 1))),
          ),
          GestureDetector(
            onTap: () async {
              final scelto = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (scelto != null) {
                onDateChanged(scelto);
              }
            },
            child: Text(
              _label(selectedDate),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () =>
                onDateChanged(selectedDate.add(const Duration(days: 1))),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final scelto = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (scelto != null) {
                onDateChanged(scelto);
              }
            },
          ),
        ],
      ),
    );
  }
}
