import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool remindersEnabled = true;
  bool hydrationAlerts = true;
  bool weeklyCheckins = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color(0xFFF3B7C6),
                    child: const Icon(Icons.person_rounded, size: 28, color: Colors.white),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(auth.displayName, style: theme.textTheme.headlineMedium),
                        const SizedBox(height: 4),
                        Text('Skin profile · Combination', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: const [
                    _ProfileRow(label: 'Email', value: 'laila@email.com'),
                    _ProfileRow(label: 'Skin type', value: 'Combination Skin'),
                    _ProfileRow(label: 'Sensitivity', value: 'Mildly sensitive'),
                    _ProfileRow(label: 'Current concern', value: 'Acne & pigmentation'),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Skin goals', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Current goals', style: TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    const _GoalItem(label: 'Reduce acne marks by 20% in 6 weeks'),
                    const _GoalItem(label: 'Keep hydration level stable after routine updates'),
                    const _GoalItem(label: 'Use SPF daily without skipping'),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Preferences', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: remindersEnabled,
                      onChanged: (value) => setState(() => remindersEnabled = value),
                      title: const Text('Daily skincare reminders'),
                      subtitle: const Text('Morning and night routine alerts'),
                      activeColor: const Color(0xFFF3B7C6),
                    ),
                    SwitchListTile(
                      value: hydrationAlerts,
                      onChanged: (value) => setState(() => hydrationAlerts = value),
                      title: const Text('Hydration check-ins'),
                      subtitle: const Text('Gentle reminders to rehydrate skin'),
                      activeColor: const Color(0xFFF3B7C6),
                    ),
                    SwitchListTile(
                      value: weeklyCheckins,
                      onChanged: (value) => setState(() => weeklyCheckins = value),
                      title: const Text('Weekly skin progress'),
                      subtitle: const Text('Review progress and routine changes weekly'),
                      activeColor: const Color(0xFFF3B7C6),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text('Account', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              const _SettingTile(label: 'Personal info', icon: Icons.person_outline_rounded),
              const _SettingTile(label: 'Notifications', icon: Icons.notifications_none_rounded),
              const _SettingTile(label: 'Privacy & security', icon: Icons.lock_outline_rounded),
              const _SettingTile(label: 'Help center', icon: Icons.help_outline_rounded),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    context.read<AuthProvider>().signOut();
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sign out'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    backgroundColor: const Color(0xFF1B1A1F),
                    foregroundColor: Colors.white,
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

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _GoalItem extends StatelessWidget {
  const _GoalItem({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, size: 18, color: Color(0xFFE59EB8)),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFE59EB8)),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF6C6670)),
        ],
      ),
    );
  }
}
