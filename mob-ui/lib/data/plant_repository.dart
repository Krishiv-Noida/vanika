import '../models/plant.dart';

class PlantRepository {
  static final List<Plant> samplePlants = [
    const Plant(
      id: '1',
      slug: 'hanging-golden-pothos',
      name: 'Hanging Golden Pothos',
      scientificName: 'Epipremnum aureum',
      description:
          'Celebrated for its cascading heart-shaped foliage marbled with vibrant golden streaks. Golden Pothos thrives in almost any lighting condition and is one of NASA’s top air-purifying botanicals.',
      shortDescription: 'Cascading golden-marbled vines with extreme resilience.',
      price: 1299.0,
      comparePrice: 1599.0,
      rating: 4.9,
      reviewCount: 142,
      category: PlantCategory.hanging,
      lightRequirement: LightRequirement.medium,
      careLevel: CareLevel.easy,
      waterFrequency: WaterFrequency.weekly,
      petFriendly: false,
      airPurifying: true,
      isFeatured: true,
      isNew: true,
      imagePath: 'assets/images/plants/hanging_pothos.jpg',
      humidity: '40% - 60%',
      temperature: '18°C - 29°C',
    ),
    const Plant(
      id: '2',
      slug: 'ruby-ficus-elastica',
      name: 'Burgundy Rubber Tree',
      scientificName: 'Ficus elastica Burgundy',
      description:
          'Features large, glossy leaves in striking deep burgundy and rich forest green tones. Adds an architectural silhouette to modern living rooms while absorbing airborne toxins.',
      shortDescription: 'Bold architectural plant with glossy crimson leaves.',
      price: 1899.0,
      comparePrice: 2299.0,
      rating: 4.8,
      reviewCount: 98,
      category: PlantCategory.indoor,
      lightRequirement: LightRequirement.high,
      careLevel: CareLevel.easy,
      waterFrequency: WaterFrequency.weekly,
      petFriendly: false,
      airPurifying: true,
      isFeatured: true,
      isNew: false,
      imagePath: 'assets/images/plants/rubber_plant.jpg',
      humidity: '50% - 70%',
      temperature: '16°C - 26°C',
    ),
    const Plant(
      id: '3',
      slug: 'peace-lily-wallisii',
      name: 'Spathiphyllum Peace Lily',
      scientificName: 'Spathiphyllum wallisii',
      description:
          'Renowned for its pure ivory sail-like blooms and lush emerald leaves. Not only visually serene, but also a moisture-loving champion at filtering benzene and carbon monoxide.',
      shortDescription: 'Elegant ivory white spathes and lush emerald foliage.',
      price: 1450.0,
      comparePrice: 1750.0,
      rating: 4.7,
      reviewCount: 115,
      category: PlantCategory.indoor,
      lightRequirement: LightRequirement.low,
      careLevel: CareLevel.easy,
      waterFrequency: WaterFrequency.weekly,
      petFriendly: false,
      airPurifying: true,
      isFeatured: true,
      isNew: false,
      imagePath: 'assets/images/plants/peace_lily.jpg',
      humidity: '55% - 80%',
      temperature: '18°C - 27°C',
    ),
    const Plant(
      id: '4',
      slug: 'anthurium-andraeanum',
      name: 'Crimson Heart Anthurium',
      scientificName: 'Anthurium andraeanum',
      description:
          'Flaunts glossy, bright crimson heart-shaped spathes with a contrasting golden spadix. Blooms continuously throughout the year when given gentle, dappled window light.',
      shortDescription: 'Year-round heart blooms with exotic lacquer finish.',
      price: 1699.0,
      comparePrice: 1999.0,
      rating: 4.9,
      reviewCount: 84,
      category: PlantCategory.rare,
      lightRequirement: LightRequirement.medium,
      careLevel: CareLevel.moderate,
      waterFrequency: WaterFrequency.weekly,
      petFriendly: false,
      airPurifying: true,
      isFeatured: true,
      isNew: true,
      imagePath: 'assets/images/plants/anthurium.jpg',
      humidity: '60% - 80%',
      temperature: '18°C - 28°C',
    ),
    const Plant(
      id: '5',
      slug: 'sansevieria-desk-plant',
      name: 'Architectural Desk Snake Plant',
      scientificName: 'Sansevieria trifasciata',
      description:
          'The ultimate indestructible companion. Upright sword-shaped foliage bordered in golden chartreuse. Releases oxygen at night, making it ideal for bedrooms and executive desks.',
      shortDescription: 'Virtually unkillable desk centerpiece that purifies nighttime air.',
      price: 999.0,
      comparePrice: 1199.0,
      rating: 5.0,
      reviewCount: 210,
      category: PlantCategory.airPurifying,
      lightRequirement: LightRequirement.low,
      careLevel: CareLevel.easy,
      waterFrequency: WaterFrequency.biweekly,
      petFriendly: true,
      airPurifying: true,
      isFeatured: false,
      isNew: false,
      imagePath: 'assets/images/plants/desk_plant.jpg',
      humidity: '30% - 50%',
      temperature: '15°C - 30°C',
    ),
    const Plant(
      id: '6',
      slug: 'boho-macrame-pothos',
      name: 'Artisan Macramé Pothos',
      scientificName: 'Epipremnum aureum x macrame',
      description:
          'Hand-knotted 100% organic cotton macramé hanging planter cradling a lush, full-volume variegated Pothos. Adds instant bohemian vertical charm to sunlit corners.',
      shortDescription: 'Hand-crafted bohemian macramé planter with full trailing vines.',
      price: 2199.0,
      comparePrice: 2699.0,
      rating: 4.9,
      reviewCount: 67,
      category: PlantCategory.hanging,
      lightRequirement: LightRequirement.medium,
      careLevel: CareLevel.easy,
      waterFrequency: WaterFrequency.weekly,
      petFriendly: false,
      airPurifying: true,
      isFeatured: true,
      isNew: true,
      imagePath: 'assets/images/plants/hero_macrame_pothos.jpg',
      humidity: '40% - 70%',
      temperature: '18°C - 28°C',
    ),
  ];

  static List<Plant> getAll() => samplePlants;

  static List<Plant> getFeatured() =>
      samplePlants.where((p) => p.isFeatured).toList();

  static List<Plant> getByCategory(PlantCategory category) =>
      samplePlants.where((p) => p.category == category).toList();

  static Plant? getBySlug(String slug) {
    try {
      return samplePlants.firstWhere((p) => p.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
