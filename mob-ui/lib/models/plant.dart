enum PlantCategory {
  indoor('Indoor'),
  outdoor('Outdoor'),
  succulent('Succulent'),
  rare('Rare Find'),
  hanging('Hanging'),
  airPurifying('Air Purifying');

  final String label;
  const PlantCategory(this.label);
}

enum LightRequirement {
  low('Low Light'),
  medium('Indirect Light'),
  high('Bright Light'),
  fullSun('Full Sun');

  final String label;
  const LightRequirement(this.label);
}

enum CareLevel {
  easy('Beginner Friendly'),
  moderate('Moderate Care'),
  expert('Plant Connoisseur');

  final String label;
  const CareLevel(this.label);
}

enum WaterFrequency {
  daily('Once Daily'),
  weekly('Once a Week'),
  biweekly('Every 2 Weeks'),
  monthly('Once a Month');

  final String label;
  const WaterFrequency(this.label);
}

class Plant {
  final String id;
  final String slug;
  final String name;
  final String scientificName;
  final String description;
  final String shortDescription;
  final double price;
  final double? comparePrice;
  final double rating;
  final int reviewCount;
  final PlantCategory category;
  final LightRequirement lightRequirement;
  final CareLevel careLevel;
  final WaterFrequency waterFrequency;
  final bool petFriendly;
  final bool airPurifying;
  final bool isFeatured;
  final bool isNew;
  final String imagePath;
  final String? humidity;
  final String? temperature;

  const Plant({
    required this.id,
    required this.slug,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.shortDescription,
    required this.price,
    this.comparePrice,
    required this.rating,
    required this.reviewCount,
    required this.category,
    required this.lightRequirement,
    required this.careLevel,
    required this.waterFrequency,
    this.petFriendly = false,
    this.airPurifying = true,
    this.isFeatured = false,
    this.isNew = false,
    required this.imagePath,
    this.humidity,
    this.temperature,
  });

  bool get hasDiscount => comparePrice != null && comparePrice! > price;
  int get discountPercent => hasDiscount ? (((comparePrice! - price) / comparePrice!) * 100).round() : 0;
}
