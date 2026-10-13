import 'package:flutter/foundation.dart';
import '../models/plant.dart';

class WishlistProvider extends ChangeNotifier {
  final Map<String, Plant> _items = {};

  List<Plant> get items => _items.values.toList();
  int get count => _items.length;

  bool isWishlisted(String plantId) => _items.containsKey(plantId);

  void toggle(Plant plant) {
    if (_items.containsKey(plant.id)) {
      _items.remove(plant.id);
    } else {
      _items[plant.id] = plant;
    }
    notifyListeners();
  }

  void remove(String plantId) {
    if (_items.containsKey(plantId)) {
      _items.remove(plantId);
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
