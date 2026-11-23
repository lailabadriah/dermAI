import 'dart:convert';

import 'package:http/http.dart' as http;

class SkinAnalysisResult {
  const SkinAnalysisResult({
    required this.skinType,
    required this.concern,
    required this.confidence,
    required this.summary,
    required this.riskLevel,
    required this.backendStatus,
    required this.recommendations,
  });

  final String skinType;
  final String concern;
  final double confidence;
  final String summary;
  final String riskLevel;
  final bool backendStatus;
  final List<String> recommendations;

  factory SkinAnalysisResult.fromJson(Map<String, dynamic> json) {
    return SkinAnalysisResult(
      skinType: json['skinType'] as String? ?? 'Combination',
      concern: json['concern'] as String? ?? 'Mild uneven texture',
      confidence: ((json['confidence'] as num?) ?? 0.0).toDouble(),
      summary: json['summary'] as String? ?? 'Your skin appears balanced with minor signs of dryness and congestion.',
      riskLevel: json['riskLevel'] as String? ?? 'Low',
      backendStatus: json['backendStatus'] as bool? ?? true,
      recommendations: List<String>.from(
        json['recommendations'] as List? ?? const [
          'Use a gentle cleanser twice daily.',
          'Apply sunscreen every morning.',
          'Keep your hydration and barrier repair routine consistent.',
        ],
      ),
    );
  }
}

class SkinAnalysisService {
  static const String baseUrl = 'https://example.com/api/v1/skin-analysis';

  static Future<SkinAnalysisResult> analyzeImage({
    required String imagePath,
    String? userId,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl))
        ..files.add(await http.MultipartFile.fromPath('image', imagePath))
        ..fields['userId'] = userId ?? 'demo-user';

      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(body);
        if (decoded is Map<String, dynamic>) {
          return SkinAnalysisResult.fromJson(decoded);
        }
      }
    } catch (_) {
      // fallback to simulated result when backend is not live yet.
    }

    return const SkinAnalysisResult(
      skinType: 'Combination',
      concern: 'Mild acne and dehydration',
      confidence: 0.88,
      summary: 'The image suggests combination skin with mild congestion and minor dehydration around cheek areas.',
      riskLevel: 'Moderate',
      backendStatus: false,
      recommendations: [
        'Use a gentle cleanser twice daily.',
        'Apply niacinamide serum in the morning.',
        'Use lightweight moisturizer and SPF 30+ daily.',
        'Reduce over-exfoliation until redness improves.',
      ],
    );
  }
}
