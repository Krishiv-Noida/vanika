import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Plant Care Guides",
  description: "Expert care guides for all your plants — watering, light, soil, and more.",
};

export default function CareGuidesPage() {
  return (
    <div className="container mx-auto px-4 py-12">
      <h1 className="text-3xl font-display font-bold mb-4">Plant Care Guides 🌿</h1>
      <p className="text-muted-foreground text-lg">
        Expert tips to keep every plant thriving. Coming soon…
      </p>
    </div>
  );
}
