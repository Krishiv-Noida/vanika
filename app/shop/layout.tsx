import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Shop Plants",
  description: "Browse our collection of indoor plants, succulents, outdoor plants, and rare botanicals.",
};

export default function ShopLayout({ children }: { children: React.ReactNode }) {
  return <div className="container mx-auto px-4 py-8">{children}</div>;
}
