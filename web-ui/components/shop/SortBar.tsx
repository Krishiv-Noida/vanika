export function SortBar({ totalCount }: { totalCount: number }) {
  return (
    <div className="flex items-center justify-between mb-4">
      <p className="text-muted-foreground text-sm">{totalCount} plants found</p>
    </div>
  );
}
