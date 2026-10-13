import 'package:flutter/foundation.dart';
import '../models/plant.dart';

enum SortBy {
  featured('Featured'),
  priceAsc('Price: Low to High'),
  priceDesc('Price: High to Low'),
  rating('Highest Rated');

  final String label;
  const SortBy(this.label);
}

class FilterProvider extends ChangeNotifier {
  String _searchQuery = '';
  PlantCategory? _selectedCategory;
  LightRequirement? _selectedLight;
  CareLevel? _selectedCare;
  bool _petFriendlyOnly = false;
  SortBy _sortBy = SortBy.featured;

  String get searchQuery => _searchQuery;
  PlantCategory? get selectedCategory => _selectedCategory;
  LightRequirement? get selectedLight => _selectedLight;
  CareLevel? get selectedCare => _selectedCare;
  bool get petFriendlyOnly => _petFriendlyOnly;
  SortBy get sortBy => _sortBy;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(PlantCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setLight(LightRequirement? light) {
    _selectedLight = light;
    notifyListeners();
  }

  void setCare(CareLevel? care) {
    _selectedCare = care;
    notifyListeners();
  }

  void togglePetFriendly() {
    _petFriendlyOnly = !_petFriendlyOnly;
    notifyListeners();
  }

  void setSortBy(SortBy sort) {
    _sortBy = sort;
    notifyListeners();
  }

  void reset() {
    _searchQuery = '';
    _selectedCategory = null;
    _selectedLight = null;
    _selectedCare = null;
    _petFriendlyOnly = false;
    _sortBy = SortBy.featured;
    notifyListeners();
  }

  List<Plant> apply(List<Plant> plants) {
    var result = plants.where((plant) {
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final match = plant.name.toLowerCase().contains(query) ||
            plant.scientificName.toLowerCase().contains(query) ||
            plant.description.toLowerCase().contains(query);
        if (!match) return false;
      }
      if (_selectedCategory != null && plant.category != _selectedCategory) {
        return false;
      }
      if (_selectedLight != null && plant.lightRequirement != _selectedLight) {
        return false;
      }
      if (_selectedCare != null && plant.careLevel != _selectedCare) {
        return false;
      }
      if (_petFriendlyOnly && !plant.petFriendly) {
        return false;
      }
      return true;
    }).toList();

    switch (_sortBy) {
      case SortBy.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortBy.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortBy.rating:
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortBy.featured:
        result.sort((a, b) => (b.isFeatured ? 1 : 0).compareTo(a.isFeatured ? 1 : 0));
        break;
    }

    return result;
  }
}
