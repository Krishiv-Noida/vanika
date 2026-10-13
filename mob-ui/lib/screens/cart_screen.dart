import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../providers/cart_provider.dart';
import '../widgets/3d/botanical_particles_3d.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback onExploreTap;

  const CartScreen({super.key, required this.onExploreTap});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoCtrl = TextEditingController();

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;

    return BotanicalParticles3D(
      count: 12,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Shopping Cart',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            if (items.isNotEmpty)
              TextButton(
                onPressed: () => cart.clear(),
                child: const Text('Clear', style: TextStyle(color: Colors.redAccent, fontSize: 13)),
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
                            Icons.shopping_basket_outlined,
                            size: 64,
                            color: VanikaColors.brand400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your Plant Cart is Empty',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Invite living nature into your living space today.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: VanikaColors.textMuted, fontSize: 13),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: widget.onExploreTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VanikaColors.brand500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text('Explore Botanicals 🌿', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  child: Column(
                    children: [
                      // Cart Items List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (_, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final key = '${item.plant.id}_${item.selectedPotSize}';

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: VanikaColors.cardDark,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: VanikaColors.cardBorder),
                            ),
                            child: Row(
                              children: [
                                // Thumbnail
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.asset(
                                    item.plant.imagePath,
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // Title, Pot Size, Price
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.plant.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        item.selectedPotSize,
                                        style: const TextStyle(fontSize: 11, color: VanikaColors.brand300),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        '₹${item.totalPrice.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Quantity Controls
                                Row(
                                  children: [
                                    _QuantityBtn(
                                      icon: Icons.remove,
                                      onTap: () => cart.decrement(key),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        '${item.quantity}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    _QuantityBtn(
                                      icon: Icons.add,
                                      onTap: () => cart.increment(key),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Promo Code Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: VanikaColors.cardDark,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: VanikaColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.confirmation_number_outlined, color: VanikaColors.brand300, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _promoCtrl,
                                style: const TextStyle(color: Colors.white, fontSize: 13),
                                decoration: const InputDecoration(
                                  hintText: 'Enter coupon (Try VANIKA20)',
                                  hintStyle: TextStyle(color: VanikaColors.textMuted, fontSize: 12),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final applied = cart.applyPromo(_promoCtrl.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: VanikaColors.cardDark,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      applied
                                          ? 'Coupon Applied! 20% Discount saved 🎉'
                                          : 'Invalid coupon code. Try VANIKA20',
                                      style: TextStyle(
                                        color: applied ? VanikaColors.brand300 : Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: VanikaColors.brand600,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Text('Apply', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Order Summary Card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: VanikaColors.cardDark,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: VanikaColors.cardBorder),
                        ),
                        child: Column(
                          children: [
                            _SummaryRow(label: 'Subtotal', value: '₹${cart.subtotal.toStringAsFixed(0)}'),
                            const SizedBox(height: 8),
                            _SummaryRow(
                              label: 'Eco Delivery',
                              value: cart.shippingCost == 0 ? 'FREE' : '₹${cart.shippingCost.toStringAsFixed(0)}',
                              valueColor: cart.shippingCost == 0 ? VanikaColors.brand300 : Colors.white,
                            ),
                            if (cart.discount > 0) ...[
                              const SizedBox(height: 8),
                              _SummaryRow(
                                label: 'Discount (${cart.promoCode})',
                                value: '-₹${cart.discount.toStringAsFixed(0)}',
                                valueColor: VanikaColors.brand300,
                              ),
                            ],
                            const Divider(color: VanikaColors.cardBorder, height: 22),
                            _SummaryRow(
                              label: 'Total Amount',
                              value: '₹${cart.total.toStringAsFixed(0)}',
                              isBold: true,
                              fontSize: 17,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Checkout Action Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showCheckoutSuccessDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: VanikaColors.brand500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                          ),
                          child: Text(
                            'Proceed to Checkout • ₹${cart.total.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _showCheckoutSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: VanikaColors.bgDarkElevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: VanikaColors.cardBorder),
        ),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0x3322C55E),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: VanikaColors.brand400, size: 48),
            ),
            const SizedBox(height: 14),
            Text(
              'Order Placed!',
              style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        content: const Text(
          'Thank you for your order! Your plants are being carefully potted in nursery-fresh organic soil and scheduled for carbon-neutral delivery.',
          textAlign: TextAlign.center,
          style: TextStyle(color: VanikaColors.textMuted, fontSize: 13, height: 1.5),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<CartProvider>().clear();
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: VanikaColors.brand500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: VanikaColors.bgDarkElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: VanikaColors.cardBorder),
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;
  final Color? valueColor;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize = 13,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: isBold ? Colors.white : VanikaColors.textMuted,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            color: valueColor ?? Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
