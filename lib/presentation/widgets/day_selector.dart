import 'package:flutter/material.dart';
import 'package:tabletable/l10n/app_localizations.dart';

class DaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DaySelector({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  String _label(DateTime d, AppLocalizations l10n) {
    final oggi = DateTime.now();
    if (d.year == oggi.year && d.month == oggi.month && d.day == oggi.day) {
      return l10n.daySelectorToday;
    }
    return '${d.day}/${d.month}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
              _label(selectedDate, l10n),
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
