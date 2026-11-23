enum SkinType { oily, dry, combination, normal, sensitive }

class SkinTypeResultData {
  const SkinTypeResultData({
    required this.type,
    required this.label,
    required this.summary,
    required this.description,
    required this.careTips,
    required this.avoidIngredients,
  });

  final SkinType type;
  final String label;
  final String summary;
  final String description;
  final List<String> careTips;
  final List<String> avoidIngredients;

  static SkinTypeResultData fromScores(Map<String, int> scores) {
    final entries = scores.entries.toList();
    final maxScore = entries.reduce((a, b) => a.value >= b.value ? a : b).value;
    final best = entries.where((entry) => entry.value == maxScore).map((entry) => entry.key).first;

    final type = SkinType.values.firstWhere(
      (item) => item.name == best,
      orElse: () => SkinType.combination,
    );

    switch (type) {
      case SkinType.oily:
        return const SkinTypeResultData(
          type: SkinType.oily,
          label: 'Oily Skin',
          summary: 'Kulit cenderung berminyak dan lebih cepat menghasilkan sebum.',
          description:
              'Kulit Anda biasanya terlihat berkilau, mudah berminyak di area T-zone, dan rentan terhadap komedo maupun breakout.',
          careTips: [
            'Gunakan facial wash yang lembut namun membersihkan sebum berlebih.',
            'Pilih toner yang membantu menyeimbangkan minyak tanpa membuat kulit kering.',
            'Gunakan moisturizer ringan dengan tekstur gel atau lotion.',
            'Jangan skip sunscreen, pilih formula yang tidak berminyak.',
          ],
          avoidIngredients: ['Heavy occlusive cream', 'Produk terlalu parfum', 'Eksfolian keras berlebihan'],
        );
      case SkinType.dry:
        return const SkinTypeResultData(
          type: SkinType.dry,
          label: 'Dry Skin',
          summary: 'Kulit cenderung terasa kaku, kasar, atau mudah tertarik.',
          description:
              'Kulit Anda lebih cepat kehilangan kelembapan dan cenderung memerlukan hidrasi yang lebih intensif untuk menjaga barrier skin.',
          careTips: [
            'Gunakan cleanser yang lembut dan tidak menghilangkan minyak alami berlebih.',
            'Tambahkan humectant dan ceramide pada rutinitas malam.',
            'Pilih moisturizer yang lebih creamy untuk menjaga barrier.',
            'Gunakan sunscreen yang tidak membuat kulit terasa kering.',
          ],
          avoidIngredients: ['Foaming cleanser yang agresif', 'Eksfolian berfrekuensi tinggi', 'Bahan yang membuat kulit terasa tertarik'],
        );
      case SkinType.combination:
        return const SkinTypeResultData(
          type: SkinType.combination,
          label: 'Combination Skin',
          summary: 'Kulit memiliki area berminyak dan area kering secara bersamaan.',
          description:
              'Area T-zone biasanya lebih berminyak, sementara pipi dan area tertentu terasa lebih kering atau sensitif.',
          careTips: [
            'Gunakan cleanser yang seimbang dan tidak terlalu stripping.',
            'Beri perhatian pada area T-zone dengan formula ringan.',
            'Gunakan moisturizer yang cukup lembap namun tidak berat di seluruh wajah.',
            'Pilih serum target sesuai kebutuhan area tertentu.',
          ],
          avoidIngredients: ['Produk terlalu berat untuk area T-zone', 'Retinoid terlalu agresif tanpa hidrasi cukup', 'Skincare yang menimbulkan iritasi bertahap'],
        );
      case SkinType.normal:
        return const SkinTypeResultData(
          type: SkinType.normal,
          label: 'Normal Skin',
          summary: 'Kulit cenderung seimbang dengan keseimbangan minyak dan kelembapan yang relatif stabil.',
          description:
              'Kulit Anda biasanya tidak terlalu berminyak, tidak terlalu kering, dan lebih mudah disesuaikan dengan berbagai formula produk.',
          careTips: [
            'Pertahankan keseimbangan dengan rutinitas yang konsisten.',
            'Jangan melewatkan sunscreen setiap pagi.',
            'Gunakan produk aktif secara terukur agar kulit tetap stabil.',
            'Ciptakan rutinitas yang menjaga barrier dan mencegah iritasi.',
          ],
          avoidIngredients: ['Over-exfoliation', 'Bahan aktif berlebihan di rutinitas harian', 'Produk yang terlalu menyegarkan dan mengiritasi'],
        );
      case SkinType.sensitive:
        return const SkinTypeResultData(
          type: SkinType.sensitive,
          label: 'Sensitive Skin',
          summary: 'Kulit lebih cepat bereaksi terhadap produk atau perubahan lingkungan.',
          description:
              'Kulit Anda cenderung mudah kemerahan, terasa panas, kering, atau iritasi saat menggunakan formula yang terlalu aktif atau keras.',
          careTips: [
            'Pilih produk dengan formulasi sederhana dan minimal fragrance.',
            'Perkenalkan bahan aktif satu per satu agar respon kulit terpantau.',
            'Prioritaskan ceramide, panthenol, dan soothing agent.',
            'Hindari over-exfoliating dan rutinitas yang terlalu padat.',
          ],
          avoidIngredients: ['Fragrance tinggi', 'Asam kuat tanpa pemantauan', 'Produk dengan banyak bahan aktif sekaligus'],
        );
    }
  }
}
