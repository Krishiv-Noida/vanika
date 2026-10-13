"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { Search, Heart, ShoppingCart, User, Menu, X, Smartphone, Download } from "lucide-react";
import { useCartStore } from "@/store/cartStore";
import { useWishlistStore } from "@/store/wishlistStore";

export function Navbar() {
  const [mobileOpen, setMobileOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");
  const [mounted, setMounted] = useState(false);

  const itemCount = useCartStore((s) => s.itemCount());
  const wishlistCount = useWishlistStore((s) => s.productIds.length);

  useEffect(() => {
    setMounted(true);
  }, []);

  const navLinks = [
    { href: "/", label: "Home" },
    { href: "/shop", label: "Plants" },
    { href: "/care-guides", label: "Plant Care" },
    { href: "/download", label: "Get App" },
  ];

  return (
    <header className="sticky top-0 z-50 w-full bg-[#031811]/90 backdrop-blur-xl border-b border-emerald-500/15 text-white transition-all">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="flex h-18 sm:h-20 items-center justify-between">
          {/* Logo & Tagline */}
          <Link href="/" className="flex items-center gap-3 group shrink-0">
            {/* Custom Styled Leaf Icon */}
            <div className="text-[#86efac] group-hover:scale-105 transition-transform duration-300">
              <svg
                width="30"
                height="30"
                viewBox="0 0 34 34"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
                className="drop-shadow-[0_0_8px_rgba(134,239,172,0.25)]"
              >
                <path
                  d="M17 3C17 3 29 5 30 18C31 28 21 31 17 31C13 31 3 28 4 18C5 5 17 3 17 3Z"
                  fill="#4ade80"
                  fillOpacity="0.15"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M17 3V31"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 11L24 7"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 17L26 13"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 23L24 20"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 11L10 7"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 17L8 13"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
                <path
                  d="M17 23L10 20"
                  stroke="#4ade80"
                  strokeWidth="2"
                  strokeLinecap="round"
                />
              </svg>
            </div>

            <div className="flex flex-col">
              <span className="font-serif text-xl sm:text-2xl font-normal tracking-[0.16em] text-white leading-none uppercase">
                VANIKA
              </span>
              <span className="text-[10px] font-sans text-emerald-100/60 tracking-wider mt-1 font-light">
                Bring Nature Home
              </span>
            </div>
          </Link>

          {/* Center Navigation Links */}
          <nav className="hidden md:flex items-center gap-8">
            {navLinks.map((link) => (
              <Link
                key={link.label}
                href={link.href as any}
                className="text-xs sm:text-sm font-medium text-emerald-100/80 hover:text-white transition-colors py-1 relative after:absolute after:bottom-0 after:left-0 after:w-0 after:h-[2px] after:bg-[#4ade80] hover:after:w-full after:transition-all after:duration-300"
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* Right Action Icons: Search, Wishlist, Cart, Profile, Download Button */}
          <div className="flex items-center gap-2 sm:gap-3">
            {/* Search */}
            <div className="relative">
              {searchOpen ? (
                <div className="flex items-center bg-[#09261b] border border-emerald-500/40 rounded-full px-3 py-1.5 backdrop-blur-md shadow-lg">
                  <Search className="w-3.5 h-3.5 text-emerald-400 mr-2" />
                  <input
                    type="text"
                    placeholder="Search plants..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    autoFocus
                    className="bg-transparent text-xs text-white placeholder:text-emerald-300/40 focus:outline-none w-28 sm:w-40"
                  />
                  <button
                    onClick={() => setSearchOpen(false)}
                    className="text-emerald-400 hover:text-white text-xs ml-1.5 p-0.5"
                  >
                    ✕
                  </button>
                </div>
              ) : (
                <button
                  onClick={() => setSearchOpen(true)}
                  aria-label="Search"
                  className="w-9 h-9 rounded-full flex items-center justify-center text-emerald-100/85 hover:text-white hover:bg-emerald-900/30 transition-all"
                >
                  <Search className="w-[18px] h-[18px]" strokeWidth={1.75} />
                </button>
              )}
            </div>

            {/* Wishlist / Heart */}
            <Link
              href={"/wishlist" as any}
              aria-label="Wishlist"
              className="relative w-9 h-9 rounded-full flex items-center justify-center text-emerald-100/85 hover:text-white hover:bg-emerald-900/30 transition-all"
            >
              <Heart className="w-[18px] h-[18px]" strokeWidth={1.75} />
              {wishlistCount > 0 && (
                <span className="absolute top-1 right-1 h-3.5 min-w-[14px] px-1 rounded-full bg-[#4ade80] text-[#062419] text-[9px] font-bold flex items-center justify-center">
                  {wishlistCount}
                </span>
              )}
            </Link>

            {/* Cart with count badge */}
            <Link
              href={"/cart" as any}
              aria-label="Shopping Cart"
              className="relative w-9 h-9 rounded-full flex items-center justify-center text-emerald-100/85 hover:text-white hover:bg-emerald-900/30 transition-all"
            >
              <ShoppingCart className="w-[18px] h-[18px]" strokeWidth={1.75} />
              <span className="absolute top-0.5 right-0.5 h-4 min-w-[16px] px-1 rounded-full bg-[#a3e635] text-[#062419] text-[9.5px] font-bold flex items-center justify-center shadow-sm">
                {itemCount > 0 ? itemCount : 2}
              </span>
            </Link>

            {/* User Account */}
            <Link
              href={"/login" as any}
              aria-label="Account"
              className="w-9 h-9 rounded-full flex items-center justify-center text-emerald-100/85 hover:text-white hover:bg-emerald-900/30 transition-all"
            >
              <User className="w-[18px] h-[18px]" strokeWidth={1.75} />
            </Link>

            {/* Download App Pill Button */}
            <Link
              href={"/download" as any}
              className="hidden lg:inline-flex items-center gap-1.5 px-4 py-2 rounded-full text-xs font-semibold text-[#041d13] bg-[#7ee787] hover:bg-[#86efac] transition-all duration-300 shadow-[0_2px_12px_rgba(126,231,135,0.3)] hover:scale-105 active:scale-95 ml-1"
            >
              <Smartphone className="w-3.5 h-3.5 text-[#041d13]" />
              <span>Download App</span>
            </Link>

            {/* Mobile menu toggle */}
            <button
              className="md:hidden w-9 h-9 rounded-full flex items-center justify-center text-emerald-100 hover:bg-emerald-900/30 transition-all ml-1"
              onClick={() => setMobileOpen((v) => !v)}
              aria-label="Toggle menu"
            >
              {mobileOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </button>
          </div>
        </div>

        {/* Mobile Navigation Drawer */}
        {mobileOpen && (
          <nav className="md:hidden py-4 px-5 rounded-2xl bg-[#061d15]/98 backdrop-blur-2xl border border-emerald-500/25 flex flex-col gap-2.5 shadow-2xl my-3">
            {navLinks.map((link) => (
              <Link
                key={link.label}
                href={link.href as any}
                className="text-sm font-medium text-emerald-100/90 hover:text-[#4ade80] py-2 px-3 rounded-xl hover:bg-emerald-950/50 transition-colors"
                onClick={() => setMobileOpen(false)}
              >
                {link.label}
              </Link>
            ))}
            <Link
              href={"/download" as any}
              className="inline-flex items-center justify-center gap-2 px-4 py-2.5 rounded-xl text-xs font-semibold text-[#041d13] bg-[#7ee787] hover:bg-[#86efac] transition-all duration-200 mt-1"
              onClick={() => setMobileOpen(false)}
            >
              <Smartphone className="w-4 h-4 text-[#041d13]" />
              <span>Download Android App</span>
            </Link>
          </nav>
        )}
      </div>
    </header>
  );
}
