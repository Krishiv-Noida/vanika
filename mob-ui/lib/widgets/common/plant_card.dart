import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/colors.dart';
import '../../models/plant.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wishlist_provider.dart';
import '../3d/card_3d.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantCard({
    super.key,
    required this.plant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();
    final cart = context.read<CartProvider>();
    final isWishlisted = wishlist.isWishlisted(plant.id);

    return Card3D(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        decoration: BoxDecoration(
          color: VanikaColors.cardDark,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: VanikaColors.cardBorder, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image & Top Badges Stack
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
                  child: AspectRatio(
                    aspectRatio: 1.05,
                    child: Image.asset(
                      plant.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, err, stack) => Container(
                        color: VanikaColors.bgDarkElevated,
                        child: const Icon(Icons.eco, color: VanikaColors.brand400, size: 40),
                      ),
                    ),
                  ),
                ),

                // Category Tag
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xD9052E16),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: VanikaColors.cardBorder, width: 0.8),
                    ),
                    child: Text(
                      plant.category.label,
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: VanikaColors.brand300,
                      ),
                    ),
                  ),
                ),

                // Wishlist Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      wishlist.toggle(plant);
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 1000),
                          backgroundColor: VanikaColors.cardDark,
                          content: Text(
                            isWishlisted
                                ? 'Removed ${plant.name} from Wishlist'
                                : 'Added ${plant.name} to Wishlist ❤️',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xB3052E16),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isWishlisted ? Colors.redAccent.withValues(alpha: 0.5) : VanikaColors.cardBorder,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        isWishlisted ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: isWishlisted ? Colors.redAccent : Colors.white70,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                // Discount Badge
                if (plant.hasDiscount)
                  Positioned(
                    bottom: 8,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: VanikaColors.earth500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${plant.discountPercent}%',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Plant Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating & Reviews
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: VanikaColors.ratingStar, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        plant.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${plant.reviewCount})',
                        style: const TextStyle(
                          fontSize: 10,
                          color: VanikaColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Plant Name
                  Text(
                    plant.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  // Scientific Name
                  Text(
                    plant.scientificName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                      color: VanikaColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Price and Quick Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹${plant.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: VanikaColors.brand300,
                            ),
                          ),
                          if (plant.hasDiscount)
                            Text(
                              '₹${plant.comparePrice!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                                color: VanikaColors.textSubtle,
                              ),
                            ),
                        ],
                      ),

                      // Add to Cart Action
                      GestureDetector(
                        onTap: () {
                          cart.addItem(plant);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 1000),
                              backgroundColor: VanikaColors.cardDark,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                'Added ${plant.name} to Cart 🌿',
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [VanikaColors.brand500, VanikaColors.brand700],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: VanikaColors.brand500.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
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
