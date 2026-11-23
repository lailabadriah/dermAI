import 'package:flutter/material.dart';

import '../../ai_assistant/screens/ai_assistant_screen.dart';
import '../../analyze/screens/analyze_screen.dart';
import '../../consultation/screens/consultation_screen.dart';
import '../../ingredient_checker/screens/ingredient_checker_screen.dart';
import '../../recommendations/screens/recommendation_screen.dart';
import '../../skin_type/screens/skin_type_quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning,',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Laila 👋',
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0xFFF3B7C6),
                    child: const Icon(Icons.face_2_outlined, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF7DDE5), Color(0xFFFDE9E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Skin profile',
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Combination Skin',
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Moderate acne-prone and dry around cheeks.',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '84%',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B1A1F),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const AnalyzeScreen()),
                        );
                      },
                      icon: const Icon(Icons.face_retouching_natural_rounded),
                      label: const Text('Analyze My Skin'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        backgroundColor: const Color(0xFFF3B7C6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const SkinTypeQuizScreen()),
                        );
                      },
                      icon: const Icon(Icons.psychology_alt_outlined),
                      label: const Text('Check skin type'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        side: const BorderSide(color: Color(0xFFF3B7C6)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const IngredientCheckerScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search_rounded, color: Color(0xFFE59EB8)),
                            SizedBox(width: 10),
                            Expanded(child: Text('Ingredient checker')),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const AiAssistantScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.smart_toy_outlined, color: Color(0xFFE59EB8)),
                            SizedBox(width: 10),
                            Expanded(child: Text('AI assistant')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _SectionTitle(title: 'Latest analysis', trailing: 'View all'),
              const SizedBox(height: 12),
              _InfoCard(
                title: 'Acne & pigmentation',
                subtitle: '3 days ago · mild inflammation around cheeks',
                value: 'Healthy trend',
                icon: Icons.favorite_rounded,
              ),
              const SizedBox(height: 22),
              _SectionTitle(title: 'Recommended for you', trailing: 'See more'),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const RecommendationScreen()),
                        );
                      },
                      child: const _ProductRecommendationCard(
                        title: 'The Ordinary Niacinamide 10%',
                        tag: 'BHA + barrier support',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const RecommendationScreen()),
                        );
                      },
                      child: const _ProductRecommendationCard(
                        title: 'CeraVe PM Facial Moisturizing Lotion',
                        tag: 'Hydration + repair',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(builder: (_) => const RecommendationScreen()),
                        );
                      },
                      child: const _ProductRecommendationCard(
                        title: 'La Roche-Posay Anthelios',
                        tag: 'Daily sunscreen',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              _SectionTitle(title: 'AI Assistant', trailing: 'Open chat'),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const AiAssistantScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDE9E7),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.smart_toy_outlined, color: Color(0xFFE59EB8)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Skincare consult'),
                            SizedBox(height: 4),
                            Text(
                              'Ask about ingredients, routine timing, or irritation.',
                              style: TextStyle(color: Color(0xFF6C6670)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const ConsultationScreen()),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7DDE5),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(Icons.medical_services_outlined, color: Color(0xFFE59EB8)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Dermatologist consult'),
                            SizedBox(height: 4),
                            Text(
                              'Book a specialist for deeper skin review and treatment plan.',
                              style: TextStyle(color: Color(0xFF6C6670)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        Text(trailing, style: const TextStyle(color: Color(0xFFE59EB8), fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF7DDE5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: const Color(0xFFE59EB8)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE59EB8))),
        ],
      ),
    );
  }
}

class _ProductRecommendationCard extends StatelessWidget {
  const _ProductRecommendationCard({required this.title, required this.tag});

  final String title;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 204,
      margin: const EdgeInsets.only(right: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFFDE9E7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.medication_liquid_rounded, color: Color(0xFFE59EB8)),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(tag, style: const TextStyle(color: Color(0xFF6C6670))),
        ],
      ),
    );
  }
}
