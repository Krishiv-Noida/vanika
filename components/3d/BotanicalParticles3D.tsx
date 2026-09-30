"use client";

import React, { useEffect, useRef } from "react";

interface Particle3D {
  x: number;
  y: number;
  z: number;
  origZ: number;
  radius: number;
  speed: number;
  alpha: number;
  phase: number;
  color: string;
}

export function BotanicalParticles3D({
  count = 45,
  className = "",
}: {
  count?: number;
  className?: string;
}) {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext("2d");
    if (!ctx) return;

    let animationFrameId: number;
    let width = (canvas.width = canvas.offsetWidth);
    let height = (canvas.height = canvas.offsetHeight);

    const handleResize = () => {
      if (!canvas) return;
      width = canvas.width = canvas.offsetWidth;
      height = canvas.height = canvas.offsetHeight;
    };

    window.addEventListener("resize", handleResize);

    // Mouse tracking for 3D camera pan
    let mouseX = 0;
    let mouseY = 0;
    let targetMouseX = 0;
    let targetMouseY = 0;

    const handleMouseMove = (e: MouseEvent) => {
      const rect = canvas.getBoundingClientRect();
      targetMouseX = (e.clientX - rect.left - width / 2) * 0.12;
      targetMouseY = (e.clientY - rect.top - height / 2) * 0.12;
    };

    window.addEventListener("mousemove", handleMouseMove);

    // Palette of luminous botanical spores
    const colors = [
      "rgba(134, 239, 172,", // Emerald light
      "rgba(74, 222, 128,",  // Mint green
      "rgba(250, 204, 21,",  // Golden botanical pollen
      "rgba(187, 247, 208,", // Pale glow
    ];

    // Initialize 3D particles
    const particles: Particle3D[] = [];
    const fov = 400; // Focal length / field of view

    for (let i = 0; i < count; i++) {
      const z = Math.random() * 800 + 50;
      particles.push({
        x: (Math.random() - 0.5) * width * 1.5,
        y: (Math.random() - 0.5) * height * 1.5,
        z: z,
        origZ: z,
        radius: Math.random() * 2.2 + 0.8,
        speed: Math.random() * 0.4 + 0.15,
        alpha: Math.random() * 0.5 + 0.25,
        phase: Math.random() * Math.PI * 2,
        color: colors[Math.floor(Math.random() * colors.length)],
      });
    }

    let time = 0;

    const render = () => {
      time += 0.015;

      // Smooth mouse camera damping
      mouseX += (targetMouseX - mouseX) * 0.05;
      mouseY += (targetMouseY - mouseY) * 0.05;

      ctx.clearRect(0, 0, width, height);

      const cx = width / 2;
      const cy = height / 2;

      // Sort by Z for proper depth rendering
      particles.sort((a, b) => b.z - a.z);

      for (let i = 0; i < particles.length; i++) {
        const p = particles[i];

        // Slowly drift along Z & Y
        p.z -= p.speed;
        p.y += Math.sin(time + p.phase) * 0.3;
        p.x += Math.cos(time + p.phase * 0.7) * 0.2;

        // Reset if particle moves behind camera
        if (p.z <= 10) {
          p.z = 850;
          p.x = (Math.random() - 0.5) * width * 1.5;
          p.y = (Math.random() - 0.5) * height * 1.5;
        }

        // 3D Perspective Projection
        const scale = fov / (fov + p.z);
        const projX = cx + (p.x - mouseX) * scale;
        const projY = cy + (p.y - mouseY) * scale;
        const projRadius = p.radius * scale * 1.6;

        // Skip if outside canvas
        if (
          projX < -50 ||
          projX > width + 50 ||
          projY < -50 ||
          projY > height + 50
        ) {
          continue;
        }

        // Pulse brightness with depth
        const depthAlpha = Math.max(0.05, Math.min(0.85, (1 - p.z / 900) * p.alpha));
        const pulse = 0.8 + 0.2 * Math.sin(time * 2 + p.phase);

        // Draw particle with soft 3D bloom
        ctx.save();
        ctx.beginPath();
        ctx.arc(projX, projY, Math.max(0.5, projRadius), 0, Math.PI * 2);

        // Radial glow gradient for 3D light feel
        const grad = ctx.createRadialGradient(
          projX,
          projY,
          0,
          projX,
          projY,
          projRadius * 3.5
        );
        grad.addColorStop(0, `${p.color} ${depthAlpha * pulse})`);
        grad.addColorStop(0.4, `${p.color} ${depthAlpha * 0.4 * pulse})`);
        grad.addColorStop(1, `${p.color} 0)`);

        ctx.fillStyle = grad;
        ctx.beginPath();
        ctx.arc(projX, projY, projRadius * 3.5, 0, Math.PI * 2);
        ctx.fill();

        // Core bright point
        ctx.fillStyle = `${p.color} ${depthAlpha * 1.2 * pulse})`;
        ctx.beginPath();
        ctx.arc(projX, projY, Math.max(0.4, projRadius * 0.6), 0, Math.PI * 2);
        ctx.fill();

        ctx.restore();
      }

      animationFrameId = requestAnimationFrame(render);
    };

    render();

    return () => {
      window.removeEventListener("resize", handleResize);
      window.removeEventListener("mousemove", handleMouseMove);
      cancelAnimationFrame(animationFrameId);
    };
  }, [count]);

  return (
    <canvas
      ref={canvasRef}
      className={`pointer-events-none absolute inset-0 w-full h-full z-[1] ${className}`}
    />
  );
}
