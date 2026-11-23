import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_screen.dart';
import 'image_quality_screen.dart';

class AnalyzeScreen extends StatelessWidget {
  const AnalyzeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future<void> pickImageFromGallery() async {
      final picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (image == null || !context.mounted) {
        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => ImageQualityScreen(imagePath: image.path),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AI Skin Analyzer', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Scan your face with the camera or upload a selfie to assess skin health.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const CameraScreen()),
                  );
                },
                child: const _ActionTile(
                  icon: Icons.camera_alt_rounded,
                  title: 'Live camera',
                  subtitle: 'Front camera, flash, exposure and face guideline',
                  accent: Color(0xFFF3B7C6),
                ),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: pickImageFromGallery,
                child: const _ActionTile(
                  icon: Icons.photo_library_rounded,
                  title: 'Upload from gallery',
                  subtitle: 'Choose a self-portrait already on your device',
                  accent: Color(0xFFE8D8CC),
                ),
              ),
              const SizedBox(height: 24),
              Text('Photo quality checklist', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _Chip(label: 'Face detected'),
                  _Chip(label: 'Centered frame'),
                  _Chip(label: 'Good lighting'),
                  _Chip(label: 'No blur'),
                  _Chip(label: 'No obstruction'),
                  _Chip(label: 'Neutral expression'),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (_) => const CameraScreen()),
                    );
                  },
                  icon: const Icon(Icons.auto_fix_high_rounded),
                  label: const Text('Start analysis'),
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

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(width: 16),
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
          const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF6C6670)),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE9E7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFF1B1A1F), fontWeight: FontWeight.w600)),
    );
  }
}
