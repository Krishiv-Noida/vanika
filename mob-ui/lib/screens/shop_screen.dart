import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/colors.dart';
import '../data/plant_repository.dart';
import '../models/plant.dart';
import '../providers/filter_provider.dart';
import '../widgets/3d/botanical_particles_3d.dart';
import '../widgets/common/plant_card.dart';
import 'product_detail_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterProvider>();
    final allPlants = PlantRepository.getAll();
    final filteredPlants = filter.apply(allPlants);

    return BotanicalParticles3D(
      count: 15,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Botanical Catalog',
            style: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune_rounded, color: VanikaColors.brand300),
              onPressed: () => _showFilterBottomSheet(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Search Input
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: VanikaColors.cardDark,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: VanikaColors.cardBorder),
                  ),
                  child: TextField(
                    onChanged: (val) => filter.setSearchQuery(val),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Search by plant or scientific name...',
                      hintStyle: const TextStyle(color: VanikaColors.textMuted, fontSize: 13),
                      prefixIcon: const Icon(Icons.search_rounded, color: VanikaColors.brand400, size: 20),
                      suffixIcon: filter.searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded, size: 18, color: Colors.white70),
                              onPressed: () => filter.setSearchQuery(''),
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),

              // Category Filter Pills
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _FilterChipItem(
                      label: 'All Botanicals',
                      isSelected: filter.selectedCategory == null,
                      onTap: () => filter.setCategory(null),
                    ),
                    const SizedBox(width: 8),
                    ...PlantCategory.values.map(
                      (cat) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _FilterChipItem(
                          label: cat.label,
                          isSelected: filter.selectedCategory == cat,
                          onTap: () => filter.setCategory(
                            filter.selectedCategory == cat ? null : cat,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Results Count & Sort Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredPlants.length} Plants Available',
                      style: const TextStyle(
                        fontSize: 12,
                        color: VanikaColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    DropdownButton<SortBy>(
                      value: filter.sortBy,
                      dropdownColor: VanikaColors.cardDark,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, color: VanikaColors.brand300, size: 18),
                      style: const TextStyle(fontSize: 12, color: VanikaColors.brand300, fontWeight: FontWeight.w600),
                      items: SortBy.values.map((sort) {
                        return DropdownMenuItem(
                          value: sort,
                          child: Text(sort.label),
                        );
                      }).toList(),
                      onChanged: (newSort) {
                        if (newSort != null) filter.setSortBy(newSort);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Plant Cards Grid
              Expanded(
                child: filteredPlants.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.nature_people_rounded, size: 56, color: VanikaColors.textMuted),
                            const SizedBox(height: 14),
                            Text(
                              'No Botanicals Found',
                              style: GoogleFonts.playfairDisplay(fontSize: 18, color: Colors.white),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Try adjusting your search query or filters',
                              style: TextStyle(fontSize: 12, color: VanikaColors.textMuted),
                            ),
                            const SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () => filter.reset(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: VanikaColors.brand600,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text('Reset Filters', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredPlants.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.63,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final plant = filteredPlants[index];
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
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: VanikaColors.bgDarkElevated,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) {
        return Consumer<FilterProvider>(
          builder: (context, filter, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filter Botanicals',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          filter.reset();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Reset All', style: TextStyle(color: VanikaColors.brand300)),
                      ),
                    ],
                  ),
                  const Divider(color: VanikaColors.cardBorder),
                  const SizedBox(height: 12),

                  // Light Requirements
                  const Text('Light Requirement', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: LightRequirement.values.map((l) {
                      final isSel = filter.selectedLight == l;
                      return ChoiceChip(
                        label: Text(l.label),
                        selected: isSel,
                        selectedColor: VanikaColors.brand600,
                        backgroundColor: VanikaColors.cardDark,
                        labelStyle: TextStyle(color: isSel ? Colors.white : VanikaColors.textMuted, fontSize: 11),
                        onSelected: (_) => filter.setLight(isSel ? null : l),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Care Difficulty
                  const Text('Care Difficulty', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: CareLevel.values.map((c) {
                      final isSel = filter.selectedCare == c;
                      return ChoiceChip(
                        label: Text(c.label),
                        selected: isSel,
                        selectedColor: VanikaColors.brand600,
                        backgroundColor: VanikaColors.cardDark,
                        labelStyle: TextStyle(color: isSel ? Colors.white : VanikaColors.textMuted, fontSize: 11),
                        onSelected: (_) => filter.setCare(isSel ? null : c),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Pet Friendly Switch
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Pet-Friendly Only', style: TextStyle(color: Colors.white, fontSize: 13)),
                    subtitle: const Text('Non-toxic for cats and dogs', style: TextStyle(color: VanikaColors.textMuted, fontSize: 11)),
                    activeThumbColor: VanikaColors.brand400,
                    value: filter.petFriendlyOnly,
                    onChanged: (_) => filter.togglePetFriendly(),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: VanikaColors.brand500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _FilterChipItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChipItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? VanikaColors.brand500 : VanikaColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? VanikaColors.brand300 : VanikaColors.cardBorder,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : VanikaColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
