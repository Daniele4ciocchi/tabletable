import 'package:flutter/material.dart';

/// Widget contenuto da passare a [showModalBottomSheet].
///
/// Esempio d'uso:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   shape: const RoundedRectangleBorder(
///     borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
///   ),
///   builder: (_) => CustomBottomSheet(
///     title: 'Titolo',
///     child: Text('Contenuto'),
///   ),
/// );
/// ```
class CustomBottomSheet extends StatelessWidget {
  /// Titolo opzionale mostrato in cima al bottom sheet.
  final String? title;

  /// Contenuto principale del bottom sheet.
  final Widget child;

  const CustomBottomSheet({super.key, this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      // Evita che la tastiera copra il contenuto
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // ── Titolo opzionale ──
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Divider(height: 1, color: colorScheme.outlineVariant),
          ],

          // ── Contenuto ──
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: child,
          ),
        ],
      ),
    );
  }
}
