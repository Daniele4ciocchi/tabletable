import 'package:flutter/material.dart';
import 'package:tabletable/presentation/screens/aggiungi_fornitore.dart';
import 'package:tabletable/presentation/screens/mostra_fornitore.dart';
import 'package:tabletable/presentation/widgets/expansible_card.dart';
import 'package:tabletable/presentation/widgets/upper_banner.dart';

import '../../data/models/fornitore.dart';
import '../../data/repositories/fornitori_repository.dart';

class FornitoriScreen extends StatefulWidget {
  const FornitoriScreen({super.key});

  @override
  State<FornitoriScreen> createState() => _FornitoriScreenState();
}

class _FornitoriScreenState extends State<FornitoriScreen> {
  late List<Fornitore> _fornitori;

  @override
  void initState() {
    super.initState();
    fetchFornitori();
  }

  void _ricarica() {
    setState(() {
      fetchFornitori();
    });
  }

  void fetchFornitori() {
    _fornitori = FornitoriRepository.instance.readAll();
  }

  Future<void> _apriDettagli(Fornitore f) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => FornitoreScreen(fornitore: f)),
    );
    _ricarica();
  }

  Future<void> _aggiungi() async {
    final nuova = await apriSchermataAggiungiFornitore(context);
    if (nuova == null) return;
    await FornitoriRepository.instance.create(nuova);
    _ricarica();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Header: banner + separatore ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  UpperBanner(
                    icon: Icons.store_rounded,
                    title:
                        '${_fornitori.length} ${_fornitori.length == 1 ? "fornitore" : "fornitori"}',
                    subtitle: 'segna cosa e dove compri qui',
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    indent: 30,
                    endIndent: 30,
                    thickness: 1,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),

          // ── Lista fornitori ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 96),
            sliver: SliverList.builder(
              itemCount: _fornitori.length,
              itemBuilder: (context, index) {
                final f = _fornitori[index];
                return ExpansibleCard(
                  icon: Icons.store_rounded,
                  title: f.nome,
                  subtitle: f.descrizione,
                  onTap: () => _apriDettagli(f),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _aggiungi,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Aggiungi fornitore'),
      ),
    );
  }
}
