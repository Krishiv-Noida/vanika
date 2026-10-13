"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Home, Compass, Sparkles, Heart, ShoppingBag } from "lucide-react";
import { useCartStore } from "@/store/cartStore";
import { useWishlistStore } from "@/store/wishlistStore";
import { useState, useEffect } from "react";

export function MobileBottomNav() {
  const pathname = usePathname();
  const [mounted, setMounted] = useState(false);

  const cartCount = useCartStore((s) => s.itemCount());
  const wishlistCount = useWishlistStore((s) => s.productIds.length);

  useEffect(() => {
    setMounted(true);
  }, []);

  const navItems = [
    { href: "/", label: "Home", icon: Home },
    { href: "/shop", label: "Plants", icon: Compass },
    { href: "/care-guides", label: "Care", icon: Sparkles },
    { href: "/wishlist", label: "Wishlist", icon: Heart, badge: wishlistCount },
    { href: "/cart", label: "Cart", icon: ShoppingBag, badge: cartCount },
  ];

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 z-50 bg-[#03150e]/95 backdrop-blur-xl border-t border-[#1d5743]/60 px-2 py-2 safe-area-pb shadow-[0_-10px_30px_rgba(0,0,0,0.6)]">
      <div className="flex items-center justify-around max-w-md mx-auto">
        {navItems.map((item) => {
          const Icon = item.icon;
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.label}
              href={item.href as any}
              className={`relative flex flex-col items-center justify-center py-1 px-3 rounded-xl transition-all duration-200 active:scale-90 ${
                isActive
                  ? "text-[#7ee787]"
                  : "text-[#8bb5a2] hover:text-white"
              }`}
            >
              <div className="relative">
                <Icon className={`w-5 h-5 ${isActive ? "stroke-[2.25]" : "stroke-[1.75]"}`} />
                {mounted && item.badge !== undefined && item.badge > 0 && (
                  <span className="absolute -top-1.5 -right-2 h-4 min-w-[15px] px-1 rounded-full bg-[#7ee787] text-[#041d13] text-[9.5px] font-bold flex items-center justify-center shadow-sm">
                    {item.badge}
                  </span>
                )}
              </div>
              <span className={`text-[10px] tracking-tight mt-1 font-medium ${isActive ? "text-[#7ee787]" : "text-[#8bb5a2]"}`}>
                {item.label}
              </span>
              {isActive && (
                <span className="absolute bottom-0 w-4 h-[2px] bg-[#7ee787] rounded-full shadow-[0_0_8px_#7ee787]" />
              )}
            </Link>
          );
        })}
      </div>
    </nav>
  );
}
