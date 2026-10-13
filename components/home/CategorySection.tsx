"use client";

import Link from "next/link";
import { Sparkles, ArrowUpRight } from "lucide-react";
import { Card3D, Card3DItem } from "@/components/3d/Card3D";

const categories = [
  {
    label: "Indoor Plants",
    emoji: "🪴",
    value: "indoor",
    count: "42 Varieties",
    description: "Air-purifying foliage for living rooms & desks",
  },
  {
    label: "Hanging Plants",
    emoji: "🌿",
    value: "hanging",
    count: "18 Varieties",
    description: "Cascading vines for hooks & high shelves",
  },
  {
    label: "Succulents & Cacti",
    emoji: "🌵",
    value: "succulent",
    count: "35 Varieties",
    description: "Low-maintenance architectural shapes",
  },
  {
    label: "Rare & Exotic",
    emoji: "🌺",
    value: "rare",
    count: "12 Varieties",
    description: "Variegated & collector botanical treasures",
  },
  {
    label: "Flowering Beauties",
    emoji: "🌸",
    value: "flowering",
    count: "24 Varieties",
    description: "Vibrant tropical blooms and sweet scents",
  },
  {
    label: "Herb Garden",
    emoji: "🍃",
    value: "herbs",
    count: "16 Varieties",
    description: "Fresh aromatic greens for home cooking",
  },
];

export function CategorySection() {
  return (
    <section className="bg-[#04160f] py-14 border-t border-emerald-500/10 text-white">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="flex flex-col md:flex-row md:items-end justify-between mb-8">
          <div>
            <span className="inline-flex items-center gap-1 text-[11px] font-semibold uppercase tracking-widest text-[#4ade80] mb-1.5">
              <Sparkles className="w-3 h-3" /> Curated Botanicals
            </span>
            <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal text-white tracking-tight">
              Explore by Category
            </h2>
          </div>
          <Link
            href="/shop"
            className="mt-3 md:mt-0 inline-flex items-center gap-1 text-xs font-semibold text-emerald-400 hover:text-emerald-300 group"
          >
            <span>View All Collections</span>
            <ArrowUpRight className="w-3.5 h-3.5 transition-transform group-hover:translate-x-0.5 group-hover:-translate-y-0.5" />
          </Link>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {categories.map((cat) => (
            <Card3D
              key={cat.value}
              maxTilt={12}
              scale={1.03}
              className="rounded-2xl bg-gradient-to-b from-[#08261c]/80 to-[#051a13]/90 border border-emerald-500/20 hover:border-emerald-400/50 p-5 transition-colors duration-300 h-full group"
            >
              <Link
                href={`/shop?category=${cat.value}` as any}
                className="block h-full [transform-style:preserve-3d]"
              >
                <div className="flex items-start justify-between mb-4">
                  <Card3DItem depth={32} className="w-11 h-11 rounded-xl bg-emerald-500/15 border border-emerald-400/25 flex items-center justify-center text-2xl group-hover:scale-110 transition-transform shadow-sm">
                    {cat.emoji}
                  </Card3DItem>
                  <Card3DItem depth={24}>
                    <span className="text-[10.5px] font-medium px-2.5 py-0.5 rounded-full bg-emerald-500/10 text-emerald-300 border border-emerald-500/20 shadow-sm">
                      {cat.count}
                    </span>
                  </Card3DItem>
                </div>

                <Card3DItem depth={22}>
                  <h3 className="text-base font-bold text-white group-hover:text-[#4ade80] transition-colors mb-1">
                    {cat.label}
                  </h3>
                  <p className="text-emerald-100/60 text-xs leading-relaxed font-light">
                    {cat.description}
                  </p>
                </Card3DItem>

                <Card3DItem depth={26} className="mt-4 flex items-center gap-1 text-[11px] font-semibold text-emerald-400 group-hover:translate-x-1.5 transition-transform">
                  <span>Browse Category</span>
                  <span>→</span>
                </Card3DItem>
              </Link>
            </Card3D>
          ))}
        </div>
      </div>
    </section>
  );
}
