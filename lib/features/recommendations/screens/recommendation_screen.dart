import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      _SkincareProduct(
        name: 'CeraVe PM Facial Moisturizing Lotion',
        brand: 'CeraVe',
        price: 'Rp 120.000',
        benefit: 'Hydration + barrier repair',
        skinType: 'Dry, Combination, Sensitive',
        concern: 'Dryness, irritated skin',
      ),
      _SkincareProduct(
        name: 'The Ordinary Niacinamide 10% + Zinc 1%',
        brand: 'The Ordinary',
        price: 'Rp 180.000',
        benefit: 'Oil control + visible pores',
        skinType: 'Oily, Combination',
        concern: 'Sebum, pore appearance',
      ),
      _SkincareProduct(
        name: 'La Roche-Posay Anthelios SPF 50',
        brand: 'La Roche-Posay',
        price: 'Rp 260.000',
        benefit: 'Daily sunscreen protection',
        skinType: 'All skin types',
        concern: 'Sun protection',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Skincare recommendations')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE9E7),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.medication_liquid_rounded, color: Color(0xFFE59EB8)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(product.brand, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 6),
                          Text(product.price, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFE59EB8))),
                          const SizedBox(height: 8),
                          Text(product.benefit, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('Skin type: ${product.skinType}'),
                          const SizedBox(height: 4),
                          Text('Targets: ${product.concern}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SkincareProduct {
  const _SkincareProduct({
    required this.name,
    required this.brand,
    required this.price,
    required this.benefit,
    required this.skinType,
    required this.concern,
  });

  final String name;
  final String brand;
  final String price;
  final String benefit;
  final String skinType;
  final String concern;
}
