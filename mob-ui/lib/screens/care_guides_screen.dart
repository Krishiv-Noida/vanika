import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/3d/botanical_particles_3d.dart';
import '../widgets/3d/card_3d.dart';

class CareGuidesScreen extends StatelessWidget {
  const CareGuidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BotanicalParticles3D(
      count: 14,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Plant Care Guides',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            children: [
              // Header Banner Card
              Card3D(
                maxTilt: 0.08,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [VanikaColors.bgDarkElevated, Color(0xFF042412)],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: VanikaColors.cardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: VanikaColors.brand500.withValues(alpha: 0.18),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.menu_book_rounded, color: VanikaColors.brand300, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Master Plant Parenting',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Expert nursery advice to keep your foliage thriving year-round.',
                              style: TextStyle(fontSize: 11, color: VanikaColors.textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Guide 1: Watering
              const _GuideCard(
                icon: Icons.water_drop_outlined,
                iconColor: Color(0xFF60A5FA),
                title: 'The Art of Hydration',
                subtitle: 'Avoid root rot with the 2-inch knuckle moisture test',
                content:
                    'Overwatering is the #1 reason houseplants suffer. Instead of watering on a fixed calendar, insert your finger 2 inches into the soil. If it feels dry and powdery, drench thoroughly until water drains from the bottom hole.',
                tip: 'Pro-Tip: Always empty the drip tray 15 minutes after watering to prevent soggy roots.',
              ),

              const SizedBox(height: 16),

              // Guide 2: Light
              const _GuideCard(
                icon: Icons.wb_sunny_outlined,
                iconColor: Color(0xFFFBBF24),
                title: 'Decoding Sunlight Needs',
                subtitle: 'Direct vs Bright Indirect vs Low Light',
                content:
                    'Bright indirect light is where shadows are soft and blurry. Most tropical foliage (Pothos, Monsteras, Philodendrons) thrives 3–5 feet away from an east or south-facing window. Protect leaves from harsh noon sun which causes scorching.',
                tip: 'Pro-Tip: Rotate your plant by 90 degrees each week so growth stays balanced and symmetrical.',
              ),

              const SizedBox(height: 16),

              // Guide 3: Humidity & Cleaning
              const _GuideCard(
                icon: Icons.air_outlined,
                iconColor: Color(0xFF34D399),
                title: 'Humidity & Dust Free Foliage',
                subtitle: 'Maximize chlorophyll absorption & stomata breathing',
                content:
                    'Household dust coats plant leaves and blocks sunlight absorption. Gently wipe leaves monthly with a soft damp microfiber cloth. For humidity-loving ferns and Calatheas, group plants together or use a pebble tray.',
                tip: 'Pro-Tip: Misting gives temporary humidity, but a pebble tray provides constant moisture evaporation.',
              ),

              const SizedBox(height: 16),

              // Guide 4: Soil & Repotting
              const _GuideCard(
                icon: Icons.terrain_outlined,
                iconColor: VanikaColors.earth300,
                title: 'Soil Aeration & Repotting',
                subtitle: 'When to upgrade to a larger planter diameter',
                content:
                    'Only repot when roots circle the pot perimeter or push out through drainage holes. Select a pot only 2 inches larger in diameter. Use well-draining potting mix containing perlite, coco coir, and pine bark for root breathing.',
                tip: 'Pro-Tip: Spring and early summer are the ideal seasons to repot due to active growth surges.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideCard extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String content;
  final String tip;

  const _GuideCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.tip,
  });

  @override
  State<_GuideCard> createState() => _GuideCardState();
}

class _GuideCardState extends State<_GuideCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: VanikaColors.cardDark,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: VanikaColors.cardBorder),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          onExpansionChanged: (val) => setState(() => _isExpanded = val),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.iconColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 22),
          ),
          title: Text(
            widget.title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            widget.subtitle,
            style: const TextStyle(fontSize: 11, color: VanikaColors.textMuted),
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
            color: VanikaColors.brand300,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              widget.content,
              style: const TextStyle(fontSize: 12.5, height: 1.55, color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: VanikaColors.bgDarkElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: VanikaColors.brand400.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb_outline_rounded, color: VanikaColors.ratingStar, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.tip,
                      style: const TextStyle(fontSize: 11, color: VanikaColors.brand200, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
