import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../data/plant_repository.dart';
import '../models/plant.dart';
import '../providers/filter_provider.dart';
import '../widgets/3d/botanical_particles_3d.dart';
import '../widgets/3d/hero_planter_3d.dart';
import '../widgets/common/plant_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onTabChange;

  const HomeScreen({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final featuredPlants = PlantRepository.getFeatured();

    return BotanicalParticles3D(
      count: 28,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: VanikaColors.brand500.withValues(alpha: 0.18),
                              shape: BoxShape.circle,
                              border: Border.all(color: VanikaColors.cardBorder),
                            ),
                            child: const Icon(Icons.eco_rounded, color: VanikaColors.brand400, size: 22),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VANIKA',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.5,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Nature Meets Your Doorstep',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: VanikaColors.brand300,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Notification / Offer Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: VanikaColors.cardDark,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: VanikaColors.cardBorder),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_offer_rounded, color: VanikaColors.earth300, size: 14),
                            SizedBox(width: 4),
                            Text(
                              '20% OFF',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: VanikaColors.earth300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar Preview (Tap opens Shop)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: GestureDetector(
                    onTap: () => onTabChange(1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: VanikaColors.cardDark.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: VanikaColors.cardBorder),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search_rounded, color: VanikaColors.textMuted, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'Search indoor, succulents, rare plants...',
                            style: TextStyle(color: VanikaColors.textMuted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 3D Hero Planter Section
                HeroPlanter3D(
                  onExploreTap: () => onTabChange(1),
                ),

                // Hero CTA Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => onTabChange(1),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VanikaColors.brand500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: VanikaColors.brand500.withValues(alpha: 0.4),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Explore Collection',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => onTabChange(2),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                          side: const BorderSide(color: VanikaColors.cardBorder),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Care Guides', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Categories Horizontal Carousel
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Botanical Categories',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () => onTabChange(1),
                        child: const Text(
                          'View All',
                          style: TextStyle(color: VanikaColors.brand400, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 48,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: PlantCategory.values.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final cat = PlantCategory.values[index];
                      return GestureDetector(
                        onTap: () {
                          context.read<FilterProvider>().setCategory(cat);
                          onTabChange(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: VanikaColors.cardDark,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: VanikaColors.cardBorder),
                          ),
                          child: Center(
                            child: Text(
                              cat.label,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Featured 3D Plants Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Botanicals',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${featuredPlants.length} Plants',
                        style: const TextStyle(color: VanikaColors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // 3D Plant Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: featuredPlants.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.63,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final plant = featuredPlants[index];
                      return PlantCard(
                        plant: plant,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(plant: plant),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 36),

                // Why Vanika Trust Badges
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: VanikaColors.cardDark.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: VanikaColors.cardBorder),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Why Choose Vanika?',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const _TrustRow(
                        icon: Icons.local_shipping_outlined,
                        title: 'Free Eco-Transit',
                        desc: 'Sustainable packaging on orders above ₹1,999.',
                      ),
                      const Divider(color: VanikaColors.cardBorder, height: 24),
                      const _TrustRow(
                        icon: Icons.health_and_safety_outlined,
                        title: '14-Day Health Guarantee',
                        desc: 'Every plant is nursery-inspected before transit.',
                      ),
                      const Divider(color: VanikaColors.cardBorder, height: 24),
                      const _TrustRow(
                        icon: Icons.volunteer_activism_outlined,
                        title: 'Lifetime Plant Care Support',
                        desc: 'Botanical experts available whenever leaves droop.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrustRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _TrustRow({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: VanikaColors.brand500.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: VanikaColors.brand400, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 11,
                  color: VanikaColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
