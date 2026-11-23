import 'package:flutter/material.dart';

import '../../recommendations/screens/recommendation_screen.dart';
import '../models/skin_type_result.dart';

class SkinTypeResultScreen extends StatelessWidget {
  const SkinTypeResultScreen({super.key, required this.result});

  final SkinTypeResultData result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skin type result')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF7DDE5), Color(0xFFFDE9E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your skin type', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text(result.label, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 12),
                    Text(result.summary, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('What it means', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(result.description, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 22),
              Text('Care recommendations', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...result.careTips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Color(0xFFE59EB8)),
                      const SizedBox(width: 10),
                      Expanded(child: Text(tip)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text('Avoid', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: result.avoidIngredients
                    .map(
                      (ingredient) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDE9E7),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(ingredient),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => const RecommendationScreen()),
                    );
                  },
                  icon: const Icon(Icons.recommend_rounded),
                  label: const Text('Get skincare recommendations'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
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
