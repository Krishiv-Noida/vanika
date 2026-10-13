// ─────────────────────────────────────────────
// Product Types
// ─────────────────────────────────────────────

export type PlantCategory =
  | "indoor"
  | "outdoor"
  | "succulent"
  | "rare"
  | "hanging"
  | "air-purifying"
  | "flowering"
  | "herbs";

export type LightRequirement = "low" | "medium" | "high" | "full-sun";
export type CareLevel = "easy" | "moderate" | "expert";
export type WaterFrequency = "daily" | "every-2-3-days" | "weekly" | "biweekly" | "monthly";

export interface ProductImage {
  id: string;
  url: string;
  alt: string;
  isPrimary: boolean;
}

export interface Product {
  id: string;
  slug: string;
  name: string;
  scientificName?: string;
  description: string;
  shortDescription: string;
  price: number;
  comparePrice?: number;        // Original price for discounts
  currency: string;
  stock: number;
  sku: string;
  category: PlantCategory;
  tags: string[];
  images: ProductImage[];
  lightRequirement: LightRequirement;
  careLevel: CareLevel;
  waterFrequency: WaterFrequency;
  humidity?: string;
  temperature?: string;
  petFriendly: boolean;
  airPurifying: boolean;
  rating: number;
  reviewCount: number;
  isFeatured: boolean;
  isNew: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export interface ProductFilters {
  category?: PlantCategory;
  minPrice?: number;
  maxPrice?: number;
  lightRequirement?: LightRequirement;
  careLevel?: CareLevel;
  petFriendly?: boolean;
  airPurifying?: boolean;
  inStock?: boolean;
  search?: string;
}

export type SortOption =
  | "featured"
  | "newest"
  | "price-asc"
  | "price-desc"
  | "rating"
  | "name-asc";

// ─────────────────────────────────────────────
// User Types
// ─────────────────────────────────────────────

export type UserRole = "USER" | "ADMIN";

export interface User {
  id: string;
  name: string;
  email: string;
  image?: string;
  role: UserRole;
  phone?: string;
  createdAt: Date;
}

export interface Address {
  id: string;
  userId: string;
  name: string;
  phone: string;
  line1: string;
  line2?: string;
  city: string;
  state: string;
  pincode: string;
  country: string;
  isDefault: boolean;
}

// ─────────────────────────────────────────────
// Cart Types
// ─────────────────────────────────────────────

export interface CartItem {
  productId: string;
  product: Product;
  quantity: number;
}

export interface Cart {
  items: CartItem[];
  total: number;
  itemCount: number;
}

// ─────────────────────────────────────────────
// Order Types
// ─────────────────────────────────────────────

export type OrderStatus =
  | "PENDING"
  | "CONFIRMED"
  | "PROCESSING"
  | "SHIPPED"
  | "OUT_FOR_DELIVERY"
  | "DELIVERED"
  | "CANCELLED"
  | "REFUNDED";

export type PaymentStatus = "PENDING" | "PAID" | "FAILED" | "REFUNDED";

export interface OrderItem {
  id: string;
  productId: string;
  product: Product;
  quantity: number;
  price: number;
}

export interface Order {
  id: string;
  orderNumber: string;
  userId: string;
  items: OrderItem[];
  status: OrderStatus;
  paymentStatus: PaymentStatus;
  shippingAddress: Address;
  subtotal: number;
  shippingCost: number;
  discount: number;
  total: number;
  notes?: string;
  createdAt: Date;
  updatedAt: Date;
}

// ─────────────────────────────────────────────
// Review Types
// ─────────────────────────────────────────────

export interface Review {
  id: string;
  productId: string;
  userId: string;
  user: Pick<User, "name" | "image">;
  rating: number;
  title: string;
  body: string;
  images?: string[];
  isVerifiedPurchase: boolean;
  createdAt: Date;
}

// ─────────────────────────────────────────────
// Care Guide Types
// ─────────────────────────────────────────────

export interface CareGuide {
  id: string;
  productId: string;
  watering: string;
  light: string;
  soil: string;
  temperature: string;
  humidity: string;
  fertilizing: string;
  repotting: string;
  commonProblems: CareIssue[];
}

export interface CareIssue {
  problem: string;
  cause: string;
  solution: string;
}
