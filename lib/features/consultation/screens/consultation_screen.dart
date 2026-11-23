import 'package:flutter/material.dart';

class ConsultationScreen extends StatelessWidget {
  const ConsultationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consult a specialist'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Professional skin care support', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Connect with certified dermatology professionals when your skin concern needs deeper review.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF7DDE5), Color(0xFFFDE9E7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Care summary', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text('AI triage suggests: mild inflammation, acne pattern, and barrier support consultation.'),
                    SizedBox(height: 12),
                    Text('Recommended: 1 review session in 3–5 days', style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Available specialists', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              const _DoctorCard(
                name: 'Dr. Maya Rahardjo',
                specialty: 'Dermatologist',
                availability: 'Today · 15:00',
                rating: '4.9',
              ),
              const SizedBox(height: 12),
              const _DoctorCard(
                name: 'Dr. Nabila Putri',
                specialty: 'Acne & Barrier Care',
                availability: 'Tomorrow · 10:30',
                rating: '4.8',
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today_rounded),
                  label: const Text('Book consultation'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                    backgroundColor: const Color(0xFFF3B7C6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Before consultation', style: TextStyle(fontWeight: FontWeight.w700)),
                    SizedBox(height: 8),
                    Text('• Bring recent skin photos'),
                    Text('• Mention current routine and products'),
                    Text('• Note any irritation or acne trigger'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({
    required this.name,
    required this.specialty,
    required this.availability,
    required this.rating,
  });

  final String name;
  final String specialty;
  final String availability;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
            child: const Icon(Icons.person_rounded, color: Color(0xFFE59EB8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(specialty, style: const TextStyle(color: Color(0xFF6C6670))),
                const SizedBox(height: 6),
                Text(availability, style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF7DDE5),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, size: 16, color: Color(0xFFE59EB8)),
                const SizedBox(width: 4),
                Text(rating),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
