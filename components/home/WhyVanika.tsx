"use client";

import { Truck, ShieldCheck, BookOpen, Leaf, Users, RefreshCw } from "lucide-react";
import { Card3D, Card3DItem } from "@/components/3d/Card3D";

const perks = [
  {
    icon: Truck,
    title: "Eco Fast Delivery",
    description: "Packed with biodegradable insulators and delivered healthy within 48-72 hours.",
  },
  {
    icon: ShieldCheck,
    title: "30-Day Plant Guarantee",
    description: "If your botanical friend struggles in its first month, we replace it free of charge.",
  },
  {
    icon: BookOpen,
    title: "Botanist Care Guides",
    description: "Custom watering calendars, light diagnostics, and soil health tips for every specimen.",
  },
  {
    icon: Leaf,
    title: "Sustainably Grown",
    description: "100% peat-free organic potting mix and eco-conscious nursery cultivation.",
  },
  {
    icon: Users,
    title: "15,000+ Plant Parents",
    description: "Join our thriving community of plant lovers, apartment gardeners, and collectors.",
  },
  {
    icon: RefreshCw,
    title: "Lifetime Plant Doctor",
    description: "Direct WhatsApp & AI diagnosis support whenever your plant needs a checkup.",
  },
];

export function WhyVanika() {
  return (
    <section className="bg-[#051c14] py-16 text-white border-t border-emerald-500/10">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="text-center max-w-xl mx-auto mb-10">
          <span className="text-[11px] font-semibold uppercase tracking-widest text-[#4ade80] mb-1.5 block">
            The Vanika Difference
          </span>
          <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight mb-2">
            Why Plant Lovers Choose Vanika
          </h2>
          <p className="text-emerald-100/70 text-xs sm:text-sm font-light">
            We don't just ship plants; we ensure they thrive in your sanctuary with unmatched care.
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
          {perks.map((perk) => {
            const Icon = perk.icon;
            return (
              <Card3D
                key={perk.title}
                maxTilt={12}
                scale={1.03}
                className="p-5 rounded-2xl bg-[#08261c]/60 border border-emerald-500/15 hover:border-emerald-400/40 hover:bg-[#0b3225]/80 transition-colors duration-300 h-full group"
              >
                <Card3DItem depth={30} className="w-10 h-10 rounded-xl bg-[#0f3427] border border-emerald-400/25 flex items-center justify-center mb-3.5 text-[#4ade80] group-hover:scale-110 transition-transform shadow-sm">
                  <Icon className="w-5 h-5" />
                </Card3DItem>
                <Card3DItem depth={20}>
                  <h3 className="text-sm font-bold text-white mb-1 group-hover:text-[#4ade80] transition-colors">
                    {perk.title}
                  </h3>
                  <p className="text-emerald-100/60 text-xs leading-relaxed font-light">
                    {perk.description}
                  </p>
                </Card3DItem>
              </Card3D>
            );
          })}
        </div>
      </div>
    </section>
  );
}
