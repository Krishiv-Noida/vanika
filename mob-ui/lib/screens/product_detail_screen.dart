import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../models/plant.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/3d/card_3d.dart';

class ProductDetailScreen extends StatefulWidget {
  final Plant plant;

  const ProductDetailScreen({super.key, required this.plant});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  String _selectedPotSize = 'Medium (6")';
  final List<String> _potSizes = const [
    'Small (4")',
    'Medium (6")',
    'Large (8")',
  ];

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;
    final wishlist = context.watch<WishlistProvider>();
    final cart = context.read<CartProvider>();
    final isWishlisted = wishlist.isWishlisted(plant.id);

    return Scaffold(
      backgroundColor: VanikaColors.bgDark,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Image App Bar
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: VanikaColors.bgDark,
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xB3052E16),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xB3052E16),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isWishlisted ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: isWishlisted ? Colors.redAccent : Colors.white,
                        size: 20,
                      ),
                      onPressed: () => wishlist.toggle(plant),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Card3D(
                    maxTilt: 0.1,
                    scale: 1.0,
                    borderRadius: BorderRadius.zero,
                    child: Image.asset(
                      plant.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, err, stack) => Container(
                        color: VanikaColors.bgDarkElevated,
                        child: const Icon(Icons.eco, size: 80, color: VanikaColors.brand400),
                      ),
                    ),
                  ),
                ),
              ),

              // Plant Details Body
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Tag & Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: VanikaColors.brand500.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: VanikaColors.cardBorder),
                            ),
                            child: Text(
                              plant.category.label,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: VanikaColors.brand300,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: VanikaColors.ratingStar, size: 18),
                              const SizedBox(width: 4),
                              Text(
                                '${plant.rating} (${plant.reviewCount} customer reviews)',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // Plant Name
                      Text(
                        plant.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      // Scientific Botanical Name
                      Text(
                        plant.scientificName,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: VanikaColors.brand300,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Price Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '₹${plant.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (plant.hasDiscount) ...[
                            const SizedBox(width: 10),
                            Text(
                              '₹${plant.comparePrice!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                                color: VanikaColors.textSubtle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: VanikaColors.earth500,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'SAVE ${plant.discountPercent}%',
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Botanical Specs Grid
                      Text(
                        'Plant Care Specifications',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _SpecCard(
                              icon: Icons.wb_sunny_outlined,
                              label: 'Sunlight',
                              value: plant.lightRequirement.label,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _SpecCard(
                              icon: Icons.water_drop_outlined,
                              label: 'Watering',
                              value: plant.waterFrequency.label,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _SpecCard(
                              icon: Icons.spa_outlined,
                              label: 'Difficulty',
                              value: plant.careLevel.label,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _SpecCard(
                              icon: Icons.pets_outlined,
                              label: 'Pet Safety',
                              value: plant.petFriendly ? 'Pet Safe' : 'Toxic if eaten',
                              valueColor: plant.petFriendly ? VanikaColors.brand300 : Colors.orangeAccent,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Pot Size Selector
                      Text(
                        'Select Planter Diameter',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: _potSizes.map((size) {
                          final isSel = _selectedPotSize == size;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedPotSize = size),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSel ? VanikaColors.brand500 : VanikaColors.cardDark,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSel ? VanikaColors.brand300 : VanikaColors.cardBorder,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: isSel ? Colors.white : VanikaColors.textMuted,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),

                      // Description
                      Text(
                        'Botanical Overview',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plant.description,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.6,
                          color: VanikaColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sticky Bottom "Add to Cart" Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              decoration: BoxDecoration(
                color: const Color(0xF2052E16),
                border: const Border(top: BorderSide(color: VanikaColors.cardBorder, width: 1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Quantity Stepper
                  Container(
                    decoration: BoxDecoration(
                      color: VanikaColors.cardDark,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: VanikaColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 16, color: Colors.white70),
                          onPressed: () {
                            if (_quantity > 1) setState(() => _quantity--);
                          },
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 16, color: Colors.white70),
                          onPressed: () => setState(() => _quantity++),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Add To Cart Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        cart.addItem(plant, quantity: _quantity, potSize: _selectedPotSize);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: VanikaColors.cardDark,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Added $_quantity x ${plant.name} to Cart 🌿',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VanikaColors.brand500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Add to Cart • ₹${(plant.price * _quantity).toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _SpecCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: VanikaColors.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: VanikaColors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: VanikaColors.brand500.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: VanikaColors.brand300, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: VanikaColors.textMuted),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? Colors.white,
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
