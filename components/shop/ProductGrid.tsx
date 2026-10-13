// Placeholder shop components — to be fully implemented

export function ProductGrid({ searchParams }: { searchParams: Record<string, string | undefined> }) {
  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mt-6">
      <p className="text-muted-foreground col-span-full text-center py-12">
        Products will appear here once the database is connected.
      </p>
    </div>
  );
}
