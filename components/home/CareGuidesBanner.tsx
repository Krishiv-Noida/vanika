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
          <div className="absolute -right-12 -bottom-12 w-64 h-64 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none" />

          <div className="relative z-10 max-w-xl space-y-4 [transform-style:preserve-3d]">
            <Card3DItem depth={25} className="inline-flex items-center gap-1.5 px-3 py-0.5 rounded-full bg-emerald-500/15 border border-emerald-400/30 text-[#4ade80] text-[11px] font-semibold shadow-sm">
              <HeartPulse className="w-3 h-3" />
              <span>Plant Hospital & Care System</span>
            </Card3DItem>

            <Card3DItem depth={35}>
              <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight text-white leading-snug drop-shadow-[0_10px_20px_rgba(0,0,0,0.5)]">
                New to Plant Parenthood? <br />
                <span className="text-[#4ade80]">We've Got Your Back.</span>
              </h2>
            </Card3DItem>

            <Card3DItem depth={20}>
              <p className="text-emerald-100/70 text-xs sm:text-sm font-light leading-relaxed">
                Explore 100+ botanist-written guides covering light requirements, watering schedules, pest prevention, and repotting tutorials.
              </p>
            </Card3DItem>

            <Card3DItem depth={30} className="pt-1">
              <Link
                href="/care-guides"
                className="inline-flex items-center gap-1.5 px-6 py-3 rounded-full bg-[#4ade80] hover:bg-[#34d399] text-[#062419] font-bold text-xs sm:text-sm transition-all shadow-[0_6px_20px_rgba(74,222,128,0.3)] hover:shadow-[0_8px_25px_rgba(74,222,128,0.45)] hover:scale-105 active:scale-95"
              >
                <span>Browse Free Care Guides</span>
                <ArrowRight className="w-3.5 h-3.5" />
              </Link>
            </Card3DItem>
          </div>
        </Card3D>
      </div>
    </section>
  );
}
