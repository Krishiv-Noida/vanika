"use client";

import React, { useRef, useCallback } from "react";
import Image from "next/image";
import Link from "next/link";
import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";
import { ArrowRight, Leaf, Truck, ShieldCheck, Headphones, Sprout } from "lucide-react";
import { useCartStore } from "@/store/cartStore";
import toast from "react-hot-toast";
import { BotanicalParticles3D } from "@/components/3d/BotanicalParticles3D";

const features = [
  {
    icon: Leaf,
    title: "Healthy Plants",
    description: "Handpicked with care",
  },
  {
    icon: Truck,
    title: "Fast Delivery",
    description: "Safe & on-time delivery",
  },
  {
    icon: ShieldCheck,
    title: "Secure Packaging",
    description: "Plants packed with love",
  },
  {
    icon: Headphones,
    title: "Plant Support",
    description: "We are here to help you",
  },
];

export function HeroSection() {
  const addItem = useCartStore((s) => s.addItem);
  const heroRef = useRef<HTMLElement>(null);

  // 3D Mouse Tracking Coordinates (-0.5 to 0.5)
  const mouseX = useMotionValue(0);
  const mouseY = useMotionValue(0);

  const springConfig = { damping: 22, stiffness: 140, mass: 0.8 };
  const plantSpringConfig = { damping: 16, stiffness: 85, mass: 0.9 };

  // 3D Scene Rotations
  const sceneRotateX = useSpring(useTransform(mouseY, [-0.5, 0.5], [5, -5]), springConfig);
  const sceneRotateY = useSpring(useTransform(mouseX, [-0.5, 0.5], [-7, 7]), springConfig);

  // Physical 3D Pendulum Sway for Hanging Plant
  const plantRotateZ = useSpring(useTransform(mouseX, [-0.5, 0.5], [-3.5, 3.5]), plantSpringConfig);
  const plantRotateY = useSpring(useTransform(mouseX, [-0.5, 0.5], [-9, 9]), plantSpringConfig);
  const plantTranslateX = useSpring(useTransform(mouseX, [-0.5, 0.5], [-10, 10]), plantSpringConfig);

  // Dynamic 3D Orbit Ring Gyroscope
  const orbitRotateY = useSpring(useTransform(mouseX, [-0.5, 0.5], [-12, 12]), springConfig);
  const orbitRotateX = useSpring(useTransform(mouseY, [-0.5, 0.5], [10, -10]), springConfig);

  const handleMouseMove = useCallback(
    (e: React.MouseEvent<HTMLElement>) => {
      if (!heroRef.current) return;
      const rect = heroRef.current.getBoundingClientRect();
      const normX = (e.clientX - rect.left) / rect.width - 0.5;
      const normY = (e.clientY - rect.top) / rect.height - 0.5;
      mouseX.set(normX);
      mouseY.set(normY);
    },
    [mouseX, mouseY]
  );

  const handleMouseLeave = useCallback(() => {
    mouseX.set(0);
    mouseY.set(0);
  }, [mouseX, mouseY]);

  const handleShopPlants = () => {
    addItem({
      id: "hanging-pothos-hero",
      slug: "golden-pothos-hanging",
      name: "Golden Pothos in Macrame Planter",
      description: "A vibrant trailing indoor plant suspended in artisan braided macrame.",
      shortDescription: "Indoor Trailing Botanical",
      price: 38.0,
      comparePrice: 48.0,
      currency: "USD",
      stock: 20,
      sku: "VAN-POTHOS-MACRAME",
      category: "hanging",
      tags: ["indoor", "hanging", "bestseller"],
      images: [{ id: "1", url: "/images/plants/hero_exact_pothos.jpg", alt: "Hanging Pothos", isPrimary: true }],
      lightRequirement: "medium",
      careLevel: "easy",
      waterFrequency: "weekly",
      petFriendly: true,
      airPurifying: true,
      rating: 5.0,
      reviewCount: 248,
      isFeatured: true,
      isNew: true,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    toast.success("🌿 Golden Pothos added to your cart!", {
      style: {
        background: "#06241a",
        color: "#7ee787",
        border: "1px solid #1d5743",
      },
    });
  };

  return (
    <section
      ref={heroRef}
      onMouseMove={handleMouseMove}
      onMouseLeave={handleMouseLeave}
      style={{ perspective: 1400 }}
      className="relative min-h-[90vh] lg:min-h-screen w-full bg-[#031811] text-white overflow-hidden flex flex-col justify-between pt-16 sm:pt-18 lg:pt-0 pb-4 sm:pb-6 select-none"
    >
      {/* 3D Botanical Depth Spore Field */}
      <BotanicalParticles3D count={45} />

      {/* Background Soft Ambient Glows */}
      <div className="absolute top-[5%] right-[10%] w-[320px] sm:w-[500px] h-[320px] sm:h-[500px] bg-[#22c55e]/[0.08] rounded-full blur-[100px] sm:blur-[140px] pointer-events-none" />
      <div className="absolute bottom-[5%] left-[5%] w-[260px] sm:w-[400px] h-[260px] sm:h-[400px] bg-[#16a34a]/[0.05] rounded-full blur-[90px] sm:blur-[130px] pointer-events-none" />

      <motion.div
        style={{
          rotateX: sceneRotateX,
          rotateY: sceneRotateY,
          transformStyle: "preserve-3d",
        }}
        className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl relative z-10 flex-1 flex flex-col justify-between my-auto lg:my-0 h-full"
      >
        {/* Main Hero Content Grid — Mobile-First Stack & Desktop Side-by-Side */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-8 lg:gap-10 items-center lg:items-stretch flex-1 my-auto lg:my-0 py-2 lg:py-0 [transform-style:preserve-3d]">
          {/* Left Column: Responsive Center-to-Left Alignment with 3D Depth Elevation */}
          <div
            style={{
              transform: "translateZ(45px)",
              transformStyle: "preserve-3d",
            }}
            className="lg:col-span-6 flex flex-col items-center text-center lg:items-start lg:text-left justify-center space-y-4 lg:space-y-4.5 z-20 my-auto lg:my-0 lg:pt-20 lg:pb-8"
          >
            {/* Pill Badge floating in 3D */}
            <motion.div
              initial={{ y: 8 }}
              animate={{ y: 0 }}
              transition={{ duration: 0.4 }}
              style={{ transform: "translateZ(25px)" }}
              className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#08281d] border border-[#1e5843] text-[#7ee787] text-[11px] sm:text-xs font-semibold uppercase tracking-wider shadow-[0_4px_14px_rgba(4,24,17,0.4)]"
            >
              <Leaf className="w-3.5 h-3.5 text-[#7ee787]" />
              <span>INDOOR PLANTS</span>
            </motion.div>

            {/* Serif Main Headline with Spatial 3D Depth Shadow */}
            <motion.div
              initial={{ y: 12 }}
              animate={{ y: 0 }}
              transition={{ duration: 0.45 }}
              style={{
                transform: "translateZ(55px)",
                textShadow: "0 15px 30px rgba(0,0,0,0.65)",
              }}
              className="space-y-0.5"
            >
              <h1 className="font-serif text-3xl sm:text-5xl lg:text-[56px] font-normal text-[#f4f8f5] tracking-tight leading-[1.08]">
                Bring Nature
              </h1>
              <h2 className="font-serif text-3xl sm:text-5xl lg:text-[56px] font-normal text-[#6ee787] tracking-tight leading-[1.08] drop-shadow-[0_0_20px_rgba(110,231,135,0.25)]">
                Into Your Home
              </h2>
            </motion.div>

            {/* Subparagraph */}
            <motion.p
              initial={{ y: 6 }}
              animate={{ y: 0 }}
              transition={{ duration: 0.5 }}
              style={{ transform: "translateZ(35px)" }}
              className="text-[#a6c7b9] text-xs sm:text-sm md:text-[14px] leading-relaxed font-light max-w-md lg:max-w-lg mx-auto lg:mx-0"
            >
              Discover a wide variety of indoor plants, handpicked for your space and delivered fresh to your doorstep.
            </motion.p>

            {/* Action Buttons with 3D Elevation and Tactile Click Depth */}
            <motion.div
              initial={{ y: 8 }}
              animate={{ y: 0 }}
              transition={{ duration: 0.55 }}
              style={{ transform: "translateZ(65px)" }}
              className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-3 w-full sm:w-auto pt-1"
            >
              <button
                onClick={handleShopPlants}
                className="w-full sm:w-auto group inline-flex items-center justify-center gap-2 px-7 py-3.5 rounded-full bg-[#7ee787] hover:bg-[#68dc72] text-[#041d13] font-semibold text-xs sm:text-sm transition-all duration-300 shadow-[0_10px_25px_rgba(126,231,135,0.4)] hover:shadow-[0_15px_35px_rgba(126,231,135,0.6)] hover:-translate-y-0.5 active:translate-y-1 active:scale-[0.97]"
              >
                <span>Shop Plants</span>
                <ArrowRight className="w-4 h-4 transition-transform group-hover:translate-x-1" />
              </button>

              <Link
                href={"/shop" as any}
                className="w-full sm:w-auto inline-flex items-center justify-center px-6 py-3.5 rounded-full bg-transparent hover:bg-[#09291f] border border-[#215945] hover:border-[#4ade80]/50 text-white hover:text-[#7ee787] font-medium text-xs sm:text-sm transition-all duration-300 hover:-translate-y-0.5 active:translate-y-1 active:scale-[0.97]"
              >
                <span>Explore Categories</span>
              </Link>
            </motion.div>
          </div>

          {/* Right Column: Plant Hanging Directly from Top Navbar / Ceiling with 3D Spatial Suspensions */}
          <div className="lg:col-span-6 flex justify-center items-center lg:items-start relative min-h-[360px] sm:min-h-[440px] lg:min-h-full [transform-style:preserve-3d]">
            {/* Unified Hanging Plant Assembly (Circles Centered Behind Pot + Knot in Navbar) */}
            <div className="relative w-[260px] h-[400px] sm:w-[340px] sm:h-[500px] lg:w-[420px] lg:h-[min(calc(100vh-140px),620px)] xl:w-[440px] xl:h-[min(calc(100vh-130px),660px)] -mt-6 sm:-mt-10 lg:mt-0 pt-0 lg:pt-3 flex items-start justify-center [transform-style:preserve-3d]">
              {/* Concentric Green Geometric Circles Recessed in Background 3D Space — Centered Exactly Behind Pot */}
              <div className="absolute top-[48%] left-1/2 -translate-x-1/2 -translate-y-1/2 w-[280px] h-[280px] sm:w-[380px] sm:h-[380px] lg:w-[460px] lg:h-[460px] pointer-events-none flex items-center justify-center z-0 [transform-style:preserve-3d]">
                <motion.div
                  style={{
                    transform: "translateZ(-45px)",
                    rotateX: orbitRotateX,
                    rotateY: orbitRotateY,
                    transformStyle: "preserve-3d",
                  }}
                  className="w-full h-full relative flex items-center justify-center"
                >
                  {/* Outer Orbit Circle with 3D Elevated Satellite Nodes */}
                  <div className="w-full h-full rounded-full border border-[#1f5a45]/60 relative shadow-[0_0_50px_rgba(31,90,69,0.25)]">
                    {/* Satellite Node 1 (Mid Left): Leaf Icon */}
                    <div
                      style={{ transform: "translateZ(30px)" }}
                      className="absolute top-[46%] -left-3 sm:-left-3.5 w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-[#052217] border border-[#2b6d55] flex items-center justify-center text-[#7ee787] shadow-[0_0_20px_rgba(126,231,135,0.35)]"
                    >
                      <Leaf className="w-3.5 h-3.5 sm:w-4 sm:h-4 text-[#7ee787]" />
                    </div>

                    {/* Satellite Node 2 (Top Right): Potted Plant Icon */}
                    <div
                      style={{ transform: "translateZ(30px)" }}
                      className="absolute top-[16%] right-[2%] w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-[#052217] border border-[#2b6d55] flex items-center justify-center text-[#7ee787] shadow-[0_0_20px_rgba(126,231,135,0.35)]"
                    >
                      <Sprout className="w-3.5 h-3.5 sm:w-4 sm:h-4 text-[#7ee787]" />
                    </div>

                    {/* Satellite Node 3 (Bottom Right): Botanical Sprout Icon */}
                    <div
                      style={{ transform: "translateZ(30px)" }}
                      className="absolute bottom-[16%] right-[2%] w-7 h-7 sm:w-8 sm:h-8 rounded-full bg-[#052217] border border-[#2b6d55] flex items-center justify-center text-[#7ee787] shadow-[0_0_20px_rgba(126,231,135,0.35)]"
                    >
                      <Sprout className="w-3.5 h-3.5 sm:w-4 sm:h-4 text-[#7ee787]" />
                    </div>
                  </div>

                  {/* Middle Concentric Circle */}
                  <div className="absolute w-[78%] h-[78%] rounded-full border border-[#1f5a45]/45" />

                  {/* Inner Concentric Circle */}
                  <div className="absolute w-[56%] h-[56%] rounded-full border border-[#1f5a45]/35" />
                </motion.div>
              </div>

              {/* Seamless Free-Hanging Botanical Visual — True 3D Pendulum Physics Suspended from Top Knot */}
              <motion.div
                style={{
                  transform: "translateZ(85px)",
                  rotateZ: plantRotateZ,
                  rotateY: plantRotateY,
                  transformOrigin: "50% 12px",
                  transformStyle: "preserve-3d",
                }}
                initial={{ scale: 0.98 }}
                animate={{ scale: 1 }}
                transition={{ duration: 0.6, ease: "easeOut" }}
                className="relative z-10 w-full h-full flex items-start justify-center overflow-visible pointer-events-auto cursor-grab active:cursor-grabbing"
              >
                {/* Plant Image as Pure Transparent PNG with Deep 3D Cast Shadow */}
                <div className="relative w-full h-full [transform-style:preserve-3d]">
                  <Image
                    src="/images/plants/hero_hanging_plant.png"
                    alt="Golden Pothos Hanging from Ceiling"
                    fill
                    priority
                    unoptimized
                    sizes="(max-width: 768px) 100vw, 50vw"
                    className="object-contain object-top drop-shadow-[0_28px_50px_rgba(0,0,0,0.85)] filter transition-transform duration-500 hover:scale-[1.03]"
                  />
                </div>
              </motion.div>
            </div>
          </div>
        </div>

        {/* Bottom Feature Bar: Elevated 3D Glass Surface */}
        <motion.div
          initial={{ y: 8 }}
          animate={{ y: 0 }}
          transition={{ duration: 0.5, delay: 0.1 }}
          style={{
            transform: "translateZ(40px)",
            transformStyle: "preserve-3d",
          }}
          className="mt-4 sm:mt-2 rounded-2xl bg-[#06241a]/95 border border-[#1d5743] p-3 sm:p-3.5 backdrop-blur-xl shadow-[0_20px_40px_rgba(0,0,0,0.6)] z-20 transition-all duration-300 hover:border-[#2b6d55]"
        >
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3 sm:gap-4 divide-y-0 sm:divide-y md:divide-y-0 lg:divide-x divide-[#1d5743]/50">
            {features.map((feature, idx) => {
              const Icon = feature.icon;
              return (
                <div
                  key={feature.title}
                  className={`flex items-center gap-2.5 sm:gap-3 transition-transform duration-300 hover:translate-x-1 ${
                    idx > 0 ? "lg:pl-4" : ""
                  }`}
                >
                  <div className="w-7 h-7 sm:w-8 sm:h-8 rounded-xl bg-[#0a2f22] border border-[#2b6d55]/60 flex items-center justify-center text-[#7ee787] shrink-0 shadow-[0_4px_10px_rgba(0,0,0,0.3)]">
                    <Icon className="w-3.5 h-3.5 sm:w-4 sm:h-4 text-[#7ee787]" />
                  </div>
                  <div>
                    <h4 className="text-[11px] sm:text-xs lg:text-[13px] font-semibold text-white tracking-tight">
                      {feature.title}
                    </h4>
                    <p className="text-[9.5px] sm:text-[10px] text-[#8bb5a2] font-light mt-0.5 leading-tight">
                      {feature.description}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>
        </motion.div>
      </motion.div>
    </section>
  );
}
