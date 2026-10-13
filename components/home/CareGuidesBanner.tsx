"use client";

import Link from "next/link";
import { ArrowRight, HeartPulse } from "lucide-react";
import { Card3D, Card3DItem } from "@/components/3d/Card3D";

export function CareGuidesBanner() {
  return (
    <section className="bg-[#04160f] py-12 text-white border-t border-emerald-500/10">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <Card3D
          maxTilt={8}
          scale={1.01}
          glare={true}
          className="relative overflow-hidden rounded-2xl bg-gradient-to-r from-[#0a2f23] via-[#08261c] to-[#051a13] border border-emerald-500/30 p-6 sm:p-10 lg:p-12 shadow-xl"
        >
          {/* Background decoration */}
          <div className="absolute -right-12 -bottom-12 w-80 h-80 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />

          <div className="relative z-10 grid grid-cols-1 lg:grid-cols-12 gap-8 items-center [transform-style:preserve-3d]">
            {/* Left Column: Headline and CTA */}
            <div className="lg:col-span-7 space-y-4">
              <Card3DItem depth={25} className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-emerald-500/15 border border-emerald-400/30 text-[#4ade80] text-xs font-semibold shadow-sm">
                <HeartPulse className="w-3.5 h-3.5" />
                <span>Plant Hospital & Care System</span>
              </Card3DItem>

              <Card3DItem depth={35}>
                <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight text-white leading-snug drop-shadow-[0_10px_20px_rgba(0,0,0,0.5)]">
                  New to Plant Parenthood? <br />
                  <span className="text-[#4ade80]">We&apos;ve Got Your Back.</span>
                </h2>
              </Card3DItem>

              <Card3DItem depth={20}>
                <p className="text-emerald-100/70 text-xs sm:text-sm font-light leading-relaxed max-w-lg">
                  Explore 100+ botanist-written guides covering light requirements, watering schedules, pest prevention, and repotting tutorials.
                </p>
              </Card3DItem>

              <Card3DItem depth={30} className="pt-2">
                <Link
                  href="/care-guides"
                  className="inline-flex items-center gap-2 px-6 py-3 rounded-full bg-[#4ade80] hover:bg-[#34d399] text-[#062419] font-bold text-xs sm:text-sm transition-all shadow-[0_6px_20px_rgba(74,222,128,0.3)] hover:shadow-[0_8px_25px_rgba(74,222,128,0.45)] hover:scale-105 active:scale-95"
                >
                  <span>Browse Free Care Guides</span>
                  <ArrowRight className="w-4 h-4" />
                </Link>
              </Card3DItem>
            </div>

            {/* Right Column: Quick Care Perks */}
            <div className="lg:col-span-5 space-y-3">
              <Card3DItem depth={28} className="p-3.5 rounded-xl bg-[#041911]/90 border border-emerald-500/20 flex items-center gap-3">
                <span className="text-xl">💧</span>
                <div>
                  <h4 className="text-xs font-semibold text-white">Custom Watering Schedules</h4>
                  <p className="text-[11px] text-emerald-200/60 font-light">Seasonally calibrated watering diagnostics</p>
                </div>
              </Card3DItem>

              <Card3DItem depth={24} className="p-3.5 rounded-xl bg-[#041911]/90 border border-emerald-500/20 flex items-center gap-3">
                <span className="text-xl">☀️</span>
                <div>
                  <h4 className="text-xs font-semibold text-white">Light Requirement Guides</h4>
                  <p className="text-[11px] text-emerald-200/60 font-light">Window direction & foot-candle recommendations</p>
                </div>
              </Card3DItem>

              <Card3DItem depth={20} className="p-3.5 rounded-xl bg-[#041911]/90 border border-emerald-500/20 flex items-center gap-3">
                <span className="text-xl">🩺</span>
                <div>
                  <h4 className="text-xs font-semibold text-white">Emergency Plant Doctor</h4>
                  <p className="text-[11px] text-emerald-200/60 font-light">Visual pest diagnosis & repotting assistance</p>
                </div>
              </Card3DItem>
            </div>
          </div>
        </Card3D>
      </div>
    </section>
  );
}
