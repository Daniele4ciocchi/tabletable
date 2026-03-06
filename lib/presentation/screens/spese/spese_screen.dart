import 'package:flutter/material.dart';
import 'package:tabletable/data/models/spesa.dart';
import 'package:tabletable/data/repositories/spesa_repository.dart';
import 'package:tabletable/presentation/widgets/custom_bottom_scheet.dart';
import 'package:tabletable/presentation/widgets/summary_banner.dart';

class SpeseScreen extends StatefulWidget {
  const SpeseScreen({super.key});

  @override
  State<SpeseScreen> createState() => _SpeseScreenState();
}

class _SpeseScreenState extends State<SpeseScreen> {
  late List<Spesa> _spese;

  @override
  void initState() {
    super.initState();
    fetchSpese();
  }

  void fetchSpese() {
    _spese = SpesaRepository.instance.readAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            sliver: SliverToBoxAdapter(
              child: SummaryBanner(
                icon: Icons.receipt_long_outlined,
                title:
                    '${_spese.length} ${_spese.length == 1 ? "spesa" : "spese"}',
                subtitle: 'Tutte le spese registrate',
              ),
            ),
          ),
          if (_spese.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('Nessuna spesa registrata')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
              sliver: SliverList.builder(
                itemCount: _spese.length,
                itemBuilder: (context, index) {
                  final s = _spese[index];
                  return ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: Text(
                      s.alimento +
                          (s.prezzo != null
                              ? ' - €${s.prezzo!.toStringAsFixed(2)}'
                              : ''),
                    ),
                    subtitle: s.dettagli.isNotEmpty ? Text(s.dettagli) : null,
                    trailing: Text(
                      '${s.dataOra.day.toString().padLeft(2, '0')}/${s.dataOra.month.toString().padLeft(2, '0')}/${s.dataOra.year}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        builder: (_) => CustomBottomSheet(
                          title: s.alimento,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (s.prezzo != null)
                                Text(
                                  'Prezzo: €${s.prezzo!.toStringAsFixed(2)}',
                                ),
                              if (s.fornitore != null)
                                Text('Fornitore: ${s.fornitore!.nome}'),
                              Text(
                                'Data: ${s.dataOra.day.toString().padLeft(2, '0')}/${s.dataOra.month.toString().padLeft(2, '0')}/${s.dataOra.year} ${s.dataOra.hour.toString().padLeft(2, '0')}:${s.dataOra.minute.toString().padLeft(2, '0')}',
                              ),
                              if (s.dettagli.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Text('Dettagli:'),
                                Text(s.dettagli),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
