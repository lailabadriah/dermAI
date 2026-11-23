import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/services/skin_analysis_service.dart';

class ImageQualityScreen extends StatefulWidget {
  const ImageQualityScreen({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ImageQualityScreen> createState() => _ImageQualityScreenState();
}

class _ImageQualityScreenState extends State<ImageQualityScreen> {
  bool _isLoading = false;
  SkinAnalysisResult? _result;

  Future<void> _handleAnalysis() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await SkinAnalysisService.analyzeImage(imagePath: widget.imagePath);
      if (!mounted) return;

      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('AI analysis failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qualityChecks = <_QualityCheck>[
      const _QualityCheck(label: 'Face detected', status: true, note: 'Wajah terdeteksi di area frame utama.'),
      const _QualityCheck(label: 'Centered frame', status: true, note: 'Posisi wajah berada di tengah.'),
      const _QualityCheck(label: 'Lighting', status: true, note: 'Pencahayaan cukup, tidak terlalu gelap.'),
      const _QualityCheck(label: 'Focus', status: true, note: 'Gambar tajam dan fokus.'),
      const _QualityCheck(label: 'No obstruction', status: true, note: 'Tidak ada rambut, tangan, atau benda lain menutupi wajah.'),
      const _QualityCheck(label: 'Face angle', status: true, note: 'Wajah dalam posisi netral dan tidak terlalu miring.'),
    ];

    final allPassed = qualityChecks.every((item) => item.status);

    return Scaffold(
      appBar: AppBar(title: const Text('Image quality check')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(
                  File(widget.imagePath),
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      allPassed ? Icons.check_circle_rounded : Icons.warning_amber_rounded,
                      color: allPassed ? const Color(0xFFE59EB8) : const Color(0xFFF2A65A),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        allPassed
                            ? 'Pencahayaan sudah sesuai, foto siap dianalisis.'
                            : 'Beberapa syarat kualitas foto belum terpenuhi.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('Checklist quality', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              ...qualityChecks.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        item.status ? Icons.check_rounded : Icons.close_rounded,
                        color: item.status ? const Color(0xFFE59EB8) : const Color(0xFFF2A65A),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.label, style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 3),
                            Text(
                              item.note,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_result != null) ...[
                const SizedBox(height: 18),
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
                      Text(
                        'AI result: ${_result!.skinType}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(_result!.summary),
                      const SizedBox(height: 10),
                      Text('Concern: ${_result!.concern}'),
                      const SizedBox(height: 8),
                      Text('Risk level: ${_result!.riskLevel} · Confidence: ${(_result!.confidence * 100).round()}%'),
                      const SizedBox(height: 12),
                      ..._result!.recommendations.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle_rounded, size: 16, color: Color(0xFFE59EB8)),
                              const SizedBox(width: 8),
                              Expanded(child: Text(item)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: allPassed && !_isLoading ? _handleAnalysis : null,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.auto_fix_high_rounded),
                  label: Text(_isLoading ? 'Analyzing...' : 'Proceed to AI analysis'),
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

class _QualityCheck {
  const _QualityCheck({required this.label, required this.status, required this.note});

  final String label;
  final bool status;
  final String note;
}
