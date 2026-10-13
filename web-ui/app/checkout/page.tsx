import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Checkout",
  description: "Complete your plant order.",
};

export default function CheckoutPage() {
  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-3xl font-display font-bold mb-8">Checkout</h1>
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-12">
        {/* ShippingForm component will go here */}
        <div>
          <h2 className="text-xl font-semibold mb-4">Shipping Details</h2>
        </div>
        {/* OrderReview component will go here */}
        <div>
          <h2 className="text-xl font-semibold mb-4">Order Review</h2>
        </div>
      </div>
    </div>
  );
}
