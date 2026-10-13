import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Wishlist",
  description: "Your saved plants wishlist.",
};

export default function WishlistPage() {
  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-3xl font-display font-bold mb-8">My Wishlist ❤️</h1>
      <p className="text-muted-foreground">Your wishlisted plants will appear here.</p>
    </div>
  );
}
