import 'plant.dart';

class CartItem {
  final Plant plant;
  int quantity;
  final String selectedPotSize;

  CartItem({
    required this.plant,
    this.quantity = 1,
    this.selectedPotSize = 'Medium (6")',
  });

  double get totalPrice => plant.price * quantity;
}
