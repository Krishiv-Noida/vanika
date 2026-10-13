import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Shopping Cart",
  description: "Review your selected plants before checkout.",
};

export default function CartPage() {
  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-3xl font-display font-bold mb-8">Your Cart 🛒</h1>
      {/* TODO: CartItems + OrderSummary components */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2">
          {/* CartItems component will go here */}
          <p className="text-muted-foreground">Your cart is empty. Start shopping!</p>
        </div>
        <div className="lg:col-span-1">
          {/* OrderSummary component will go here */}
        </div>
      </div>
    </div>
  );
}
