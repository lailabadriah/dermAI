import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final Map<String, bool> _morningSteps = {
    'Facial wash': true,
    'Toner': true,
    'Niacinamide serum': false,
    'Moisturizer': true,
    'Sunscreen SPF 50': false,
  };

  final Map<String, bool> _nightSteps = {
    'Facial wash': true,
    'Retinoid 0.25% 2x/week': false,
    'Moisturizer': true,
    'Barrier repair cream': true,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Skin routine', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Personalized morning and night routine based on skin profile.', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 20),
              _RoutineCard(
                title: 'Morning routine',
                steps: _morningSteps,
                accent: const Color(0xFFF3B7C6),
              ),
              const SizedBox(height: 16),
              _RoutineCard(
                title: 'Night routine',
                steps: _nightSteps,
                accent: const Color(0xFFE8D8CC),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Checklist', style: theme.textTheme.titleLarge),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDE9E7),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      '08:30 AM',
                      style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFFE59EB8)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _ChecklistTile(label: 'Facial wash', done: true),
              const _ChecklistTile(label: 'Sunscreen applied', done: false),
              const _ChecklistTile(label: 'Moisturizer refreshed', done: true),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: const Text('Set reminder'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
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

class _RoutineCard extends StatefulWidget {
  const _RoutineCard({required this.title, required this.steps, required this.accent});

  final String title;
  final Map<String, bool> steps;
  final Color accent;

  @override
  State<_RoutineCard> createState() => _RoutineCardState();
}

class _RoutineCardState extends State<_RoutineCard> {
  @override
  Widget build(BuildContext context) {
    final steps = widget.steps.entries.toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.accent.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.auto_awesome_rounded, color: widget.accent),
              ),
              const SizedBox(width: 12),
              Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 12),
          ...steps.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.steps[entry.key] = !entry.value;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        entry.value ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                        size: 18,
                        color: entry.value ? const Color(0xFFE59EB8) : const Color(0xFF6C6670),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(entry.key, style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class _ChecklistTile extends StatelessWidget {
  const _ChecklistTile({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
            color: done ? const Color(0xFFE59EB8) : const Color(0xFF6C6670),
          ),
          const SizedBox(width: 12),
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
