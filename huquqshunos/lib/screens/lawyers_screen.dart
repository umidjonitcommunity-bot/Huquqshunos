// lib/screens/lawyers_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/lawyer_model.dart';
import '../services/theme_service.dart';
import '../widgets/lawyer_card.dart';
import 'lawyer_detail_screen.dart';

class LawyersScreen extends StatefulWidget {
  const LawyersScreen({super.key});

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  final _searchController = TextEditingController();
  String _selectedSpec = 'all';
  String _sortBy = 'rating';
  List<LawyerModel> _lawyers = LawyerModel.sampleLawyers;

  final _specs = {
    'all': 'Hammasi',
    'civilLaw': 'Fuqarolik',
    'criminalLaw': 'Jinoyat',
    'familyLaw': 'Oilaviy',
    'businessLaw': 'Biznes',
    'laborLaw': 'Mehnat',
    'realEstateLaw': 'Ko\'chmas mulk',
  };

  void _filter() {
    final q = _searchController.text.toLowerCase();
    setState(() {
      _lawyers = LawyerModel.sampleLawyers.where((l) {
        final matchesSpec = _selectedSpec == 'all' || l.specialization == _selectedSpec;
        final matchesSearch = q.isEmpty ||
            l.fullName.toLowerCase().contains(q) ||
            l.specialization.toLowerCase().contains(q);
        return matchesSpec && matchesSearch;
      }).toList();

      _lawyers.sort((a, b) {
        if (_sortBy == 'rating') return b.rating.compareTo(a.rating);
        if (_sortBy == 'price_asc') return a.pricePerConsultation.compareTo(b.pricePerConsultation);
        if (_sortBy == 'price_desc') return b.pricePerConsultation.compareTo(a.pricePerConsultation);
        return 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yuristlar', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (val) {
              _sortBy = val;
              _filter();
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'rating', child: Text('Reyting bo\'yicha')),
              const PopupMenuItem(value: 'price_asc', child: Text('Narx (arzon)')),
              const PopupMenuItem(value: 'price_desc', child: Text('Narx (qimmat)')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => _filter(),
              decoration: InputDecoration(
                hintText: 'Yurist qidirish...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filter();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Specialization filter
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _specs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final key = _specs.keys.elementAt(i);
                final label = _specs.values.elementAt(i);
                final isSelected = _selectedSpec == key;
                return ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() => _selectedSpec = key);
                    _filter();
                  },
                  selectedColor: AppTheme.primary,
                  labelStyle: GoogleFonts.inter(
                    color: isSelected ? Colors.white : AppTheme.textDark,
                    fontSize: 13,
                  ),
                  backgroundColor: AppTheme.surface,
                  side: BorderSide(
                    color: isSelected ? AppTheme.primary : AppTheme.divider,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${_lawyers.length} yurist topildi',
                  style: GoogleFonts.inter(color: AppTheme.textGrey, fontSize: 13),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: _lawyers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 60, color: AppTheme.textGrey.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        Text(
                          'Yuristlar topilmadi',
                          style: GoogleFonts.inter(color: AppTheme.textGrey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                    itemCount: _lawyers.length,
                    itemBuilder: (context, i) => LawyerCard(
                      lawyer: _lawyers[i],
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LawyerDetailScreen(lawyer: _lawyers[i]),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
