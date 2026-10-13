import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/3d/botanical_particles_3d.dart';
import '../widgets/common/plant_card.dart';
import 'product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  final VoidCallback onExploreTap;

  const WishlistScreen({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final cart = context.read<CartProvider>();
    final items = wishlist.items;

    return BotanicalParticles3D(
      count: 14,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Saved Favorites',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            if (items.isNotEmpty)
              TextButton(
                onPressed: () {
                  for (final plant in items) {
                    cart.addItem(plant);
                  }
                  wishlist.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: VanikaColors.cardDark,
                      behavior: SnackBarBehavior.floating,
                      content: Text('Moved all saved botanicals to Cart 🌿', style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
                child: const Text('Move All to Cart', style: TextStyle(color: VanikaColors.brand300, fontSize: 12)),
              ),
          ],
        ),
        body: SafeArea(
          child: items.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: VanikaColors.cardDark,
                            shape: BoxShape.circle,
                            border: Border.all(color: VanikaColors.cardBorder),
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            size: 64,
                            color: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No Saved Botanicals Yet',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tap the heart icon on any plant card to save it for later.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: VanikaColors.textMuted, fontSize: 13),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: onExploreTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VanikaColors.brand500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Discover Plants ✨', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.63,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final plant = items[index];
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
      ),
    );
  }
}
