import 'package:flutter/material.dart';

import '../models/skin_type_result.dart';
import 'skin_type_result_screen.dart';

class SkinTypeQuizScreen extends StatefulWidget {
  const SkinTypeQuizScreen({super.key});

  @override
  State<SkinTypeQuizScreen> createState() => _SkinTypeQuizScreenState();
}

class _SkinTypeQuizScreenState extends State<SkinTypeQuizScreen> {
  final List<_Question> _questions = const [
    _Question(
      question: 'Bagaimana kondisi wajah setelah mencuci muka?',
      options: [
        _AnswerOption(label: 'Melembutkan dan terasa nyaman', score: {'normal': 2, 'dry': 1, 'sensitive': 1}),
        _AnswerOption(label: 'Terasa berminyak di area T-zone', score: {'oily': 2, 'combination': 1}),
        _AnswerOption(label: 'Terasa kaku atau tertarik', score: {'dry': 2, 'sensitive': 1}),
        _AnswerOption(label: 'Mudah merah setelah bersih', score: {'sensitive': 2}),
      ],
    ),
    _Question(
      question: 'Apakah wajah mudah berminyak?',
      options: [
        _AnswerOption(label: 'Ya, terutama di dahi dan hidung', score: {'oily': 2, 'combination': 1}),
        _AnswerOption(label: 'Kadang-kadang, tetapi tidak terus menerus', score: {'combination': 2, 'normal': 1}),
        _AnswerOption(label: 'Jarang sekali', score: {'dry': 2, 'normal': 1}),
        _AnswerOption(label: 'Ya, tetapi sering disertai iritasi', score: {'sensitive': 2}),
      ],
    ),
    _Question(
      question: 'Apakah kulit terasa kering atau tertarik?',
      options: [
        _AnswerOption(label: 'Sering terasa kaku atau tertarik', score: {'dry': 2, 'sensitive': 1}),
        _AnswerOption(label: 'Hanya di beberapa area', score: {'combination': 2}),
        _AnswerOption(label: 'Jarang', score: {'normal': 2, 'oily': 1}),
        _AnswerOption(label: 'Iya, terkadang disertai kemerahan', score: {'sensitive': 2}),
      ],
    ),
    _Question(
      question: 'Apakah sering mengalami kemerahan?',
      options: [
        _AnswerOption(label: 'Ya, mudah kemerahan', score: {'sensitive': 2}),
        _AnswerOption(label: 'Kadang saat stres atau cuaca', score: {'sensitive': 1, 'combination': 1}),
        _AnswerOption(label: 'Jarang sekali', score: {'normal': 2}),
        _AnswerOption(label: 'Bukan masalah utama', score: {'oily': 1, 'dry': 1}),
      ],
    ),
    _Question(
      question: 'Bagaimana kondisi kulit di area T-zone?',
      options: [
        _AnswerOption(label: 'Berminyak dan mudah terlihat glossy', score: {'oily': 2}),
        _AnswerOption(label: 'Cenderung berminyak di T-zone, kering di pipi', score: {'combination': 2}),
        _AnswerOption(label: 'Cenderung seimbang', score: {'normal': 2}),
        _AnswerOption(label: 'Bisa terasa kering dan sensitif', score: {'dry': 1, 'sensitive': 2}),
      ],
    ),
  ];

  final Map<String, int> _scores = {
    'oily': 0,
    'dry': 0,
    'combination': 0,
    'normal': 0,
    'sensitive': 0,
  };

  int _currentIndex = 0;

  void _submitAnswer(_AnswerOption option) {
    for (final entry in option.score.entries) {
      _scores[entry.key] = (_scores[entry.key] ?? 0) + entry.value;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
      return;
    }

    final result = SkinTypeResultData.fromScores(_scores);
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => SkinTypeResultScreen(result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Skin type quiz')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${_currentIndex + 1} / ${_questions.length}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                question.question,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              ...question.options.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: FilledButton.tonal(
                    onPressed: () => _submitAnswer(option),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(option.label),
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

class _Question {
  const _Question({required this.question, required this.options});

  final String question;
  final List<_AnswerOption> options;
}

class _AnswerOption {
  const _AnswerOption({required this.label, required this.score});

  final String label;
  final Map<String, int> score;
}
