"use client";

import Link from "next/link";
import { useState, useEffect } from "react";
import { Search, Heart, ShoppingCart, User, Menu, X } from "lucide-react";
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
    { href: "/shop", label: "Categories" },
    { href: "/care-guides", label: "Plant Care" },
    { href: "/about", label: "About Us" },
  ];

  return (
    <header className="absolute top-0 left-0 right-0 z-50 w-full bg-transparent border-none text-white">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl">
        <div className="flex h-16 items-center justify-between">
          {/* Logo & Tagline */}
          <Link href="/" className="flex items-center gap-2.5 group">
            {/* Custom Styled Leaf Icon */}
            <div className="text-[#86efac] group-hover:scale-105 transition-transform duration-300">
              <svg
                width="28"
                height="28"
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
              <span className="font-serif text-xl font-normal tracking-[0.16em] text-white leading-none uppercase">
                VANIKA
              </span>
              <span className="text-[9.5px] font-sans text-emerald-100/60 tracking-wide mt-0.5 font-light">
                Bring Nature Home
              </span>
            </div>
          </Link>

          {/* Center Navigation Links */}
          <nav className="hidden md:flex items-center gap-7">
            {navLinks.map((link) => (
              <Link
                key={link.label}
                href={link.href as any}
                className="text-xs font-normal text-emerald-100/80 hover:text-white transition-colors py-1 relative after:absolute after:bottom-0 after:left-0 after:w-0 after:h-[1.5px] after:bg-[#4ade80] hover:after:w-full after:transition-all after:duration-300"
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* Right Action Icons: Search, Wishlist, Cart, Profile */}
          <div className="flex items-center gap-4">
            {/* Search */}
            <div className="relative">
              {searchOpen ? (
                <div className="flex items-center bg-[#09261b]/90 border border-emerald-500/30 rounded-full px-2.5 py-1 backdrop-blur-md shadow-lg">
                  <Search className="w-3.5 h-3.5 text-emerald-400 mr-1.5" />
                  <input
                    type="text"
                    placeholder="Search plants..."
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                    autoFocus
                    className="bg-transparent text-[11px] text-white placeholder:text-emerald-300/40 focus:outline-none w-28 sm:w-36"
                  />
                  <button
                    onClick={() => setSearchOpen(false)}
                    className="text-emerald-400 hover:text-white text-[11px] ml-1"
                  >
                    ✕
                  </button>
                </div>
              ) : (
                <button
                  onClick={() => setSearchOpen(true)}
                  aria-label="Search"
                  className="text-emerald-100/85 hover:text-white hover:scale-110 transition-all p-1"
                >
                  <Search className="w-[17px] h-[17px]" strokeWidth={1.75} />
                </button>
              )}
            </div>

            {/* Wishlist / Heart */}
            <Link
              href={"/wishlist" as any}
              aria-label="Wishlist"
              className="relative text-emerald-100/85 hover:text-white hover:scale-110 transition-all p-1"
            >
              <Heart className="w-[17px] h-[17px]" strokeWidth={1.75} />
              {wishlistCount > 0 && (
                <span className="absolute -top-1 -right-1 h-3.5 min-w-[14px] px-1 rounded-full bg-[#4ade80] text-[#062419] text-[9px] font-bold flex items-center justify-center">
                  {wishlistCount}
                </span>
              )}
            </Link>

            {/* Cart with count badge */}
            <Link
              href={"/cart" as any}
              aria-label="Shopping Cart"
              className="relative text-emerald-100/85 hover:text-white hover:scale-110 transition-all p-1"
            >
              <ShoppingCart className="w-[17px] h-[17px]" strokeWidth={1.75} />
              <span className="absolute -top-1.5 -right-1.5 h-4 min-w-[15px] px-1 rounded-full bg-[#a3e635] text-[#062419] text-[9.5px] font-bold flex items-center justify-center shadow-sm">
                {itemCount > 0 ? itemCount : 2}
              </span>
            </Link>

            {/* User Account */}
            <Link
              href={"/login" as any}
              aria-label="Account"
              className="text-emerald-100/85 hover:text-white hover:scale-110 transition-all p-1"
            >
              <User className="w-[17px] h-[17px]" strokeWidth={1.75} />
            </Link>

            {/* Mobile menu toggle */}
            <button
              className="md:hidden text-emerald-100 p-1"
              onClick={() => setMobileOpen((v) => !v)}
              aria-label="Toggle menu"
            >
              {mobileOpen ? <X className="w-4 h-4" /> : <Menu className="w-4 h-4" />}
            </button>
          </div>
        </div>

        {/* Mobile Navigation Drawer */}
        {mobileOpen && (
          <nav className="md:hidden py-3 px-4 rounded-2xl bg-[#061d15]/95 backdrop-blur-xl border border-emerald-500/20 flex flex-col gap-2 shadow-2xl mt-2">
            {navLinks.map((link) => (
              <Link
                key={link.label}
                href={link.href as any}
                className="text-xs font-medium text-emerald-100/90 hover:text-[#4ade80] py-1.5 px-2 rounded-lg hover:bg-emerald-950/40 transition-colors"
                onClick={() => setMobileOpen(false)}
              >
                {link.label}
              </Link>
            ))}
          </nav>
        )}
      </div>
    </header>
  );
}
