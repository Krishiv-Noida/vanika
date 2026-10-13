import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/plant.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  String? _appliedPromoCode;
  double _promoDiscount = 0.0;

  List<CartItem> get items => _items.values.toList();

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shippingCost => subtotal > 1999.0 || _items.isEmpty ? 0.0 : 149.0;

  double get discount => _promoDiscount;

  double get total => (subtotal + shippingCost - discount).clamp(0.0, double.infinity);

  String? get promoCode => _appliedPromoCode;

  void addItem(Plant plant, {int quantity = 1, String potSize = 'Medium (6")'}) {
    final key = '${plant.id}_$potSize';
    if (_items.containsKey(key)) {
      _items[key]!.quantity += quantity;
    } else {
      _items[key] = CartItem(
        plant: plant,
        quantity: quantity,
        selectedPotSize: potSize,
      );
    }
    notifyListeners();
  }

  void increment(String key) {
    if (_items.containsKey(key)) {
      _items[key]!.quantity += 1;
      notifyListeners();
    }
  }

  void decrement(String key) {
    if (_items.containsKey(key)) {
      if (_items[key]!.quantity > 1) {
        _items[key]!.quantity -= 1;
      } else {
        _items.remove(key);
      }
      notifyListeners();
    }
  }

  void removeItem(String key) {
    _items.remove(key);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _appliedPromoCode = null;
    _promoDiscount = 0.0;
    notifyListeners();
  }

  bool applyPromo(String code) {
    final cleanCode = code.trim().toUpperCase();
    if (cleanCode == 'VANIKA20') {
      _appliedPromoCode = 'VANIKA20';
      _promoDiscount = subtotal * 0.20;
      notifyListeners();
      return true;
    } else if (cleanCode == 'NATURE10') {
      _appliedPromoCode = 'NATURE10';
      _promoDiscount = subtotal * 0.10;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromo() {
    _appliedPromoCode = null;
    _promoDiscount = 0.0;
    notifyListeners();
  }
}
