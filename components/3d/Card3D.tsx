"use client";

import React, { useRef, useState, useCallback } from "react";
import { motion, useMotionValue, useSpring, useTransform } from "framer-motion";

interface Card3DProps {
  children: React.ReactNode;
  className?: string;
  maxTilt?: number;
  glare?: boolean;
  scale?: number;
  depth?: number;
}

export function Card3D({
  children,
  className = "",
  maxTilt = 12,
  glare = true,
  scale = 1.02,
  depth = 30,
}: Card3DProps) {
  const cardRef = useRef<HTMLDivElement>(null);
  const [isHovered, setIsHovered] = useState(false);

  // Normalized mouse coords (-0.5 to 0.5)
  const x = useMotionValue(0);
  const y = useMotionValue(0);

  // Mouse position in percentage (0 to 100) for glare
  const [glarePos, setGlarePos] = useState({ x: 50, y: 50 });

  const springConfig = { damping: 20, stiffness: 220, mass: 0.6 };

  const rotateX = useSpring(useTransform(y, [-0.5, 0.5], [maxTilt, -maxTilt]), springConfig);
  const rotateY = useSpring(useTransform(x, [-0.5, 0.5], [-maxTilt, maxTilt]), springConfig);
  const cardScale = useSpring(isHovered ? scale : 1, springConfig);

  const handleMouseMove = useCallback(
    (e: React.MouseEvent<HTMLDivElement>) => {
      if (!cardRef.current) return;
      const rect = cardRef.current.getBoundingClientRect();
      const mouseX = e.clientX - rect.left;
      const mouseY = e.clientY - rect.top;

      const normX = mouseX / rect.width - 0.5;
      const normY = mouseY / rect.height - 0.5;

      x.set(normX);
      y.set(normY);

      if (glare) {
        setGlarePos({
          x: (mouseX / rect.width) * 100,
          y: (mouseY / rect.height) * 100,
        });
      }
    },
    [glare, x, y]
  );

  const handleMouseEnter = useCallback(() => {
    setIsHovered(true);
  }, []);

  const handleMouseLeave = useCallback(() => {
    setIsHovered(false);
    x.set(0);
    y.set(0);
  }, [x, y]);

  return (
    <div
      style={{ perspective: 1000 }}
      className="relative [transform-style:preserve-3d]"
    >
      <motion.div
        ref={cardRef}
        onMouseMove={handleMouseMove}
        onMouseEnter={handleMouseEnter}
        onMouseLeave={handleMouseLeave}
        style={{
          rotateX,
          rotateY,
          scale: cardScale,
          transformStyle: "preserve-3d",
        }}
        className={`relative transition-shadow duration-300 ${
          isHovered
            ? "shadow-[0_22px_45px_-10px_rgba(4,24,17,0.85),0_0_20px_rgba(74,222,128,0.15)]"
            : ""
        } ${className}`}
      >
        {children}

        {/* Dynamic 3D Glare Overlay */}
        {glare && isHovered && (
          <div
            className="pointer-events-none absolute inset-0 rounded-[inherit] overflow-hidden transition-opacity duration-300"
            style={{
              background: `radial-gradient(circle 180px at ${glarePos.x}% ${glarePos.y}%, rgba(134, 239, 172, 0.16), transparent 75%)`,
              mixBlendMode: "screen",
              zIndex: 30,
            }}
          />
        )}
      </motion.div>
    </div>
  );
}

/**
 * Helper component for elements inside Card3D that float forward in 3D
 */
export function Card3DItem({
  children,
  className = "",
  depth = 20,
}: {
  children: React.ReactNode;
  className?: string;
  depth?: number;
}) {
  return (
    <div
      style={{
        transform: `translateZ(${depth}px)`,
        transformStyle: "preserve-3d",
      }}
      className={className}
    >
      {children}
    </div>
  );
}
