import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

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
              Text('Skin progress', style: theme.textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Compare your skin condition over time and track visible improvements.', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 20),
              Container(
                height: 240,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: LineChart(
                  LineChartData(
                    minY: 0,
                    maxY: 5,
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            const labels = ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'];
                            if (value >= 0 && value < labels.length) {
                              return Text(labels[value.toInt()], style: const TextStyle(fontSize: 10));
                            }
                            return const Text('');
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: const Color(0xFFE59EB8),
                        barWidth: 4,
                        dotData: FlDotData(show: true),
                        spots: const [
                          FlSpot(0, 4),
                          FlSpot(1, 3.7),
                          FlSpot(2, 3.3),
                          FlSpot(3, 2.8),
                          FlSpot(4, 2.1),
                          FlSpot(5, 1.8),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: const [
                  _MiniMetric(label: 'Acne', value: '↓ 18%'),
                  SizedBox(width: 10),
                  _MiniMetric(label: 'Texture', value: '↑ 12%'),
                  SizedBox(width: 10),
                  _MiniMetric(label: 'Hydration', value: '↑ 9%'),
                ],
              ),
              const SizedBox(height: 22),
              Text('Recent checkpoints', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              const _ProgressItem(date: 'Nov 12', status: 'Acne reduced by 18%'),
              const _ProgressItem(date: 'Nov 08', status: 'Skin texture improved'),
              const _ProgressItem(date: 'Nov 01', status: 'Hydration stable after routine update'),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE59EB8))),
          ],
        ),
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  const _ProgressItem({required this.date, required this.status});

  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF7DDE5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                date,
                style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE59EB8)),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(status, style: Theme.of(context).textTheme.bodyLarge),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFF6C6670)),
        ],
      ),
    );
  }
}
