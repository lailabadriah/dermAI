import 'package:flutter/material.dart';

class IngredientCheckerScreen extends StatefulWidget {
  const IngredientCheckerScreen({super.key});

  @override
  State<IngredientCheckerScreen> createState() => _IngredientCheckerScreenState();
}

class _IngredientCheckerScreenState extends State<IngredientCheckerScreen> {
  final TextEditingController _controller = TextEditingController(
    text: 'Niacinamide, Salicylic Acid, Hyaluronic Acid, Fragrance',
  );

  final Map<String, _IngredientDetail> _ingredientLibrary = {
    'niacinamide': const _IngredientDetail(
      note: 'Good for acne-prone and redness-prone skin.',
      suitability: 'Suitable for most skin types',
      tone: Color(0xFFE59EB8),
    ),
    'salicylic acid': const _IngredientDetail(
      note: 'Helps unclog pores and reduce blackheads.',
      suitability: 'Best for oily / acne-prone skin',
      tone: Color(0xFFBFC9FF),
    ),
    'hyaluronic acid': const _IngredientDetail(
      note: 'Boosts hydration without heavy residue.',
      suitability: 'Good for dry and dehydrated skin',
      tone: Color(0xFF9ADCC0),
    ),
    'retinol': const _IngredientDetail(
      note: 'Strong anti-aging ingredient; start low and slow.',
      suitability: 'Use with caution if sensitive',
      tone: Color(0xFFF7C48F),
    ),
    'fragrance': const _IngredientDetail(
      note: 'May irritate sensitive skin or trigger redness.',
      suitability: 'Avoid if reactive skin',
      tone: Color(0xFFF59AA0),
    ),
    'benzoyl peroxide': const _IngredientDetail(
      note: 'Effective for active acne; may cause dryness.',
      suitability: 'Use with moisturizer and sunscreen',
      tone: Color(0xFFE8C99A),
    ),
    'ceramides': const _IngredientDetail(
      note: 'Helps restore skin barrier and reduce irritation.',
      suitability: 'Excellent for dry and barrier-compromised skin',
      tone: Color(0xFFC7B7F7),
    ),
  };

  List<String> get _ingredients {
    final input = _controller.text
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (input.isEmpty) {
      return const <String>[];
    }

    return input;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ingredients = _ingredients;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingredient checker'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Check ingredients', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Review each ingredient for irritation risk, compatibility, and acne support.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              TextField(
                controller: _controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type ingredients separated by commas',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => setState(() {}),
                  icon: const Icon(Icons.search_rounded),
                  label: const Text('Analyze ingredients'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: const Color(0xFFF3B7C6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              if (ingredients.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text('No ingredients entered yet. Add a few to check compatibility.'),
                )
              else ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDE9E7),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Overall review', style: TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      Text(
                        ingredients.any((item) => item.toLowerCase().contains('fragrance'))
                            ? 'Some ingredients may trigger sensitivity, especially if your skin is reactive.'
                            : 'This combination looks generally compatible for balanced skincare routines.',
                        style: const TextStyle(color: Color(0xFF3A3640)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ...ingredients.map((ingredient) {
                  final detail = _ingredientLibrary[ingredient.toLowerCase()] ??
                      const _IngredientDetail(
                        note: 'Ingredient is common in skincare; check product concentration and skin sensitivity.',
                        suitability: 'Use with routine monitoring',
                        tone: Color(0xFFE6D6D9),
                      );

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: detail.tone.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.science_rounded,
                            color: detail.tone,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ingredient,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 4),
                              Text(detail.suitability, style: const TextStyle(color: Color(0xFF6C6670))),
                              const SizedBox(height: 6),
                              Text(detail.note, style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientDetail {
  const _IngredientDetail({
    required this.note,
    required this.suitability,
    required this.tone,
  });

  final String note;
  final String suitability;
  final Color tone;
}
