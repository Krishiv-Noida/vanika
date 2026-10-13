export function ProductImages({ images }: { images: string[] }) {
  return <div className="aspect-square bg-muted rounded-2xl flex items-center justify-center">📷 Product images</div>;
}

export function ProductInfo({ slug }: { slug: string }) {
  return <div className="flex flex-col gap-4"><h1 className="font-display text-3xl font-bold">Plant Name</h1><p className="text-muted-foreground">Product info coming soon…</p></div>;
}

export function ProductTabs({ slug }: { slug: string }) {
  return <div className="mt-12 border-t pt-8"><p className="text-muted-foreground">Care guide & reviews tabs coming soon…</p></div>;
}

export function RelatedProducts() {
  return <div className="mt-12"><h3 className="font-display text-2xl font-bold mb-6">You might also like</h3><p className="text-muted-foreground">Related products coming soon…</p></div>;
}
