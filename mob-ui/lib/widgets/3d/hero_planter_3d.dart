import 'package:flutter/material.dart';
import '../../core/colors.dart';

class HeroPlanter3D extends StatefulWidget {
  final VoidCallback? onExploreTap;

  const HeroPlanter3D({super.key, this.onExploreTap});

  @override
  State<HeroPlanter3D> createState() => _HeroPlanter3DState();
}

class _HeroPlanter3DState extends State<HeroPlanter3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnim;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnim = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Epicenter Concentric Glow Rings
          Positioned(
            top: 60,
            child: SizedBox(
              width: 320,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer Glow Halo
                  Container(
                    width: 290,
                    height: 290,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: VanikaColors.brand400.withValues(alpha: 0.08),
                        width: 1.5,
                      ),
                      gradient: RadialGradient(
                        colors: [
                          VanikaColors.brand500.withValues(alpha: 0.18),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Middle Ring
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: VanikaColors.brand300.withValues(alpha: 0.14),
                        width: 1.5,
                      ),
                    ),
                  ),

                  // Inner Core Glow Ring
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: VanikaColors.brand300.withValues(alpha: 0.25),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: VanikaColors.brand500.withValues(alpha: 0.22),
                          blurRadius: 36,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Plant Assembly
          AnimatedBuilder(
            animation: _floatAnim,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _floatAnim.value),
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Hero Planter Image
                Image.asset(
                  'assets/images/plants/hero_hanging_plant.png',
                  height: 310,
                  fit: BoxFit.contain,
                  errorBuilder: (_, err, stack) => Image.asset(
                    'assets/images/plants/hanging_pothos.jpg',
                    height: 260,
                    fit: BoxFit.contain,
                  ),
                ),

                // Floating Satellites / Badges
                Positioned(
                  left: 16,
                  top: 90,
                  child: _FloatingBadge(
                    icon: Icons.star_rounded,
                    iconColor: VanikaColors.ratingStar,
                    title: '4.9★ Botanical Choice',
                    subtitle: 'Certified Organic',
                  ),
                ),

                Positioned(
                  right: 16,
                  bottom: 70,
                  child: _FloatingBadge(
                    icon: Icons.eco_rounded,
                    iconColor: VanikaColors.brand400,
                    title: '100% Eco Packaging',
                    subtitle: 'Safe Doorstep Delivery',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _FloatingBadge({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xCC082F1B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VanikaColors.cardBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66020E07),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 16),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 9,
                  color: VanikaColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
