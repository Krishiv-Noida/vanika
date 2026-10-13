import { ProductGrid } from "@/components/shop/ProductGrid";
import { FilterSidebar } from "@/components/shop/FilterSidebar";
import { SortBar } from "@/components/shop/SortBar";

interface ShopPageProps {
  searchParams: {
    category?: string;
    sort?: string;
    minPrice?: string;
    maxPrice?: string;
    light?: string;
    care?: string;
    page?: string;
    q?: string;
  };
}

export default async function ShopPage({ searchParams }: ShopPageProps) {
  return (
    <div className="flex flex-col lg:flex-row gap-8">
      {/* Filter Sidebar */}
      <aside className="w-full lg:w-64 shrink-0">
        <FilterSidebar />
      </aside>

      {/* Main Content */}
      <div className="flex-1">
        <SortBar totalCount={0} />
        <ProductGrid searchParams={searchParams} />
      </div>
    </div>
  );
}
