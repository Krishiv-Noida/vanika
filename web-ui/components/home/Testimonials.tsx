"use client";

import { Star, Quote } from "lucide-react";
import { Card3D, Card3DItem } from "@/components/3d/Card3D";

const reviews = [
  {
    name: "Aanya Sharma",
    location: "Bangalore",
    text: "The hanging pothos arrived so lush and healthy! The packaging was 100% plastic-free, and the moisture diagnosis card was super helpful.",
    plant: "Hanging Pothos",
    rating: 5,
  },
  {
    name: "Rohan Varma",
    location: "Mumbai",
    text: "My Anthurium is blooming nonstop for 3 months now. Vanika's care guide helped me find the perfect light corner in my apartment.",
    plant: "Anthurium Bloom",
    rating: 5,
  },
  {
    name: "Priya Nair",
    location: "Delhi",
    text: "The rubber plant is gorgeous and architectural. Huge glossy leaves and arrived with zero transit shock. Best online plant experience ever.",
    plant: "Rubber Plant",
    rating: 5,
  },
];

export function Testimonials() {
  return (
    <section className="bg-[#051c14] py-16 text-white border-t border-emerald-500/10">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="text-center max-w-xl mx-auto mb-10">
          <span className="text-[11px] font-semibold uppercase tracking-widest text-[#4ade80] mb-1.5 block">
            Customer Love
          </span>
          <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight mb-2">
            Happy Plant Parents 💚
          </h2>
          <p className="text-emerald-100/70 text-xs sm:text-sm font-light">
            Real stories from homes transformed with green botanical energy.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 sm:gap-5">
          {reviews.map((review, i) => (
            <Card3D
              key={i}
              maxTilt={12}
              scale={1.03}
              className="rounded-2xl bg-[#08261c]/70 border border-emerald-500/20 p-5 sm:p-6 flex flex-col justify-between hover:border-emerald-400/40 transition-colors h-full"
            >
              <Card3DItem depth={28}>
                <Quote className="w-6 h-6 text-emerald-400/25 mb-3" />
              </Card3DItem>

              <Card3DItem depth={18}>
                <p className="text-emerald-100/80 text-xs sm:text-[13px] leading-relaxed mb-4 font-light">
                  "{review.text}"
                </p>
              </Card3DItem>

              <Card3DItem depth={24}>
                <div className="flex items-center gap-0.5 mb-2">
                  {[...Array(review.rating)].map((_, idx) => (
                    <Star key={idx} className="w-3.5 h-3.5 fill-amber-400 text-amber-400" />
                  ))}
                </div>

                <div className="flex items-center justify-between border-t border-emerald-500/15 pt-2.5">
                  <div>
                    <h4 className="font-bold text-xs sm:text-sm text-white">{review.name}</h4>
                    <p className="text-[11px] text-emerald-400/60">{review.location}</p>
                  </div>
                  <span className="text-[10.5px] px-2 py-0.5 rounded-full bg-emerald-500/15 text-[#4ade80] font-medium shadow-sm">
                    {review.plant}
                  </span>
                </div>
              </Card3DItem>
            </Card3D>
          ))}
        </div>
      </div>
    </section>
  );
}
