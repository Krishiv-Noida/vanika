"use client";

import Image from "next/image";
import { Star, ShoppingBag, Droplets, Sun, Sparkles } from "lucide-react";
import { useCartStore } from "@/store/cartStore";
import toast from "react-hot-toast";
import { Card3D, Card3DItem } from "@/components/3d/Card3D";

const products = [
  {
    id: "monstera-deliciosa",
    slug: "monstera-deliciosa",
    name: "Monstera Deliciosa",
    scientificName: "Monstera deliciosa",
    price: 45.0,
    comparePrice: 58.0,
    image: "/images/plants/desk_plant.jpg",
    category: "Indoor",
    light: "Bright Indirect",
    water: "Weekly",
    rating: 4.9,
    reviews: 142,
    badge: "Bestseller",
  },
  {
    id: "pothos-hanging-featured",
    slug: "hanging-pothos",
    name: "Golden Pothos Hanging",
    scientificName: "Epipremnum aureum",
    price: 36.0,
    comparePrice: 48.0,
    image: "/images/plants/hanging_pothos.jpg",
    category: "Hanging",
    light: "Low to High",
    water: "Every 10 days",
    rating: 5.0,
    reviews: 210,
    badge: "Trending",
  },
  {
    id: "anthurium-andraeanum",
    slug: "anthurium-bloom",
    name: "Anthurium Flamingo Flower",
    scientificName: "Anthurium andraeanum",
    price: 26.0,
    comparePrice: 34.0,
    image: "/images/plants/anthurium.jpg",
    category: "Flowering",
    light: "Bright Filtered",
    water: "Weekly",
    rating: 4.8,
    reviews: 89,
    badge: "Seasonal",
  },
  {
    id: "rubber-tree-burgundy",
    slug: "rubber-tree",
    name: "Burgundy Rubber Tree",
    scientificName: "Ficus elastica",
    price: 28.0,
    comparePrice: 38.0,
    image: "/images/plants/rubber_plant.jpg",
    category: "Air Purifier",
    light: "Medium to High",
    water: "Biweekly",
    rating: 4.9,
    reviews: 164,
    badge: "Easy Care",
  },
];

export function FeaturedPlants() {
  const addItem = useCartStore((s) => s.addItem);

  const handleQuickAdd = (product: (typeof products)[0]) => {
    addItem({
      id: product.id,
      slug: product.slug,
      name: product.name,
      scientificName: product.scientificName,
      description: "A gorgeous botanical specimen curated for indoor spaces.",
      shortDescription: product.scientificName,
      price: product.price,
      comparePrice: product.comparePrice,
      currency: "USD",
      stock: 12,
      sku: `VAN-${product.id.toUpperCase()}`,
      category: "indoor",
      tags: ["featured", product.category.toLowerCase()],
      images: [{ id: "1", url: product.image, alt: product.name, isPrimary: true }],
      lightRequirement: "medium",
      careLevel: "easy",
      waterFrequency: "weekly",
      petFriendly: true,
      airPurifying: true,
      rating: product.rating,
      reviewCount: product.reviews,
      isFeatured: true,
      isNew: false,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    toast.success(`🌿 Added ${product.name} to cart!`, {
      style: {
        background: "#09281e",
        color: "#4ade80",
        border: "1px solid #166534",
      },
    });
  };

  return (
    <section className="bg-gradient-to-b from-[#04160f] to-[#061e15] py-16 text-white border-t border-emerald-500/10">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="text-center max-w-xl mx-auto mb-10">
          <span className="inline-flex items-center gap-1 text-[11px] font-semibold uppercase tracking-widest text-[#4ade80] mb-1.5">
            <Sparkles className="w-3 h-3" /> Handpicked Favorites
          </span>
          <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight mb-2">
            Featured Plants of the Week
          </h2>
          <p className="text-emerald-100/70 text-xs sm:text-sm font-light">
            Nurtured in our sustainable greenhouse and shipped securely to thrive in your space.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 sm:gap-5">
          {products.map((product) => (
            <Card3D
              key={product.id}
              maxTilt={14}
              scale={1.03}
              className="rounded-2xl bg-[#08261c]/90 border border-emerald-500/20 hover:border-emerald-400/50 p-3.5 transition-colors duration-300 flex flex-col justify-between h-full group"
            >
              {/* Product Image Container */}
              <Card3DItem depth={28} className="relative aspect-square w-full rounded-xl overflow-hidden bg-[#051c14] mb-3 border border-emerald-500/15">
                <Image
                  src={product.image}
                  alt={product.name}
                  fill
                  className="object-cover group-hover:scale-105 transition-transform duration-500"
                />

                {/* Badge */}
                <div style={{ transform: "translateZ(38px)" }} className="absolute top-2.5 left-2.5">
                  <span className="px-2 py-0.5 rounded-full text-[10px] font-bold bg-[#0a2f23]/95 text-[#4ade80] border border-emerald-500/35 backdrop-blur-md shadow-sm">
                    {product.badge}
                  </span>
                </div>

                {/* Rating */}
                <div style={{ transform: "translateZ(35px)" }} className="absolute bottom-2.5 left-2.5 px-2 py-0.5 rounded-lg bg-black/70 backdrop-blur-md text-[10px] flex items-center gap-1 shadow-sm">
                  <Star className="w-3 h-3 fill-amber-400 text-amber-400" />
                  <span className="font-bold">{product.rating}</span>
                  <span className="text-emerald-400/60">({product.reviews})</span>
                </div>
              </Card3DItem>

              {/* Product Info */}
              <Card3DItem depth={18} className="space-y-1.5 flex-1 flex flex-col justify-between">
                <div>
                  <span className="text-[10px] font-medium text-emerald-400/80 uppercase tracking-wider">
                    {product.category}
                  </span>
                  <h3 className="font-bold text-sm sm:text-base text-white group-hover:text-[#4ade80] transition-colors leading-tight">
                    {product.name}
                  </h3>
                  <p className="text-[11px] italic text-emerald-300/50">{product.scientificName}</p>
                </div>

                {/* Quick Care Tags */}
                <div className="flex items-center gap-3 py-1.5 text-[11px] text-emerald-200/70 border-y border-emerald-500/15">
                  <div className="flex items-center gap-1">
                    <Sun className="w-3 h-3 text-amber-400" />
                    <span>{product.light}</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <Droplets className="w-3 h-3 text-cyan-400" />
                    <span>{product.water}</span>
                  </div>
                </div>

                {/* Price & Add to Cart */}
                <div className="flex items-center justify-between pt-1.5">
                  <div>
                    <div className="text-base font-bold text-[#4ade80]">
                      ${product.price.toFixed(2)}
                    </div>
                    <div className="text-[10.5px] text-emerald-400/50 line-through">
                      ${product.comparePrice.toFixed(2)}
                    </div>
                  </div>

                  <button
                    onClick={() => handleQuickAdd(product)}
                    style={{ transform: "translateZ(35px)" }}
                    className="p-2.5 rounded-xl bg-[#4ade80] hover:bg-[#34d399] text-[#062419] font-bold transition-all shadow-[0_4px_12px_rgba(74,222,128,0.25)] hover:shadow-[0_6px_18px_rgba(74,222,128,0.4)] active:scale-90"
                    aria-label={`Add ${product.name} to cart`}
                  >
                    <ShoppingBag className="w-3.5 h-3.5" />
                  </button>
                </div>
              </Card3DItem>
            </Card3D>
          ))}
        </div>
      </div>
    </section>
  );
}
