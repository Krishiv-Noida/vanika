import type { Metadata } from "next";
import { Inter, Playfair_Display } from "next/font/google";
import "./globals.css";
import { Navbar } from "@/components/layout/Navbar";
import { Footer } from "@/components/layout/Footer";
import { MobileBottomNav } from "@/components/layout/MobileBottomNav";
import { Toaster } from "react-hot-toast";

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
});

const playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-playfair",
});

export const metadata: Metadata = {
  metadataBase: new URL(
    process.env.NEXT_PUBLIC_APP_URL ||
      (process.env.VERCEL_URL ? `https://${process.env.VERCEL_URL}` : "http://localhost:3000")
  ),
  title: {
    default: "Vanika — Where Nature Meets Your Doorstep",
    template: "%s | Vanika",
  },
  description:
    "Discover and shop the finest indoor plants, succulents, and rare botanical treasures. Delivered fresh to your door with expert care guides.",
  keywords: ["plants", "indoor plants", "succulents", "rare plants", "plant shop", "vanika"],
  authors: [{ name: "Vanika" }],
  creator: "Vanika",
  openGraph: {
    type: "website",
    locale: "en_IN",
    url: "https://vanika.in",
    siteName: "Vanika",
    title: "Vanika — Where Nature Meets Your Doorstep",
    description:
      "Shop the finest indoor plants, succulents, and rare botanicals. Fresh delivery with expert care guides.",
    images: [{ url: "/og-image.jpg" }],
  },
  twitter: {
    card: "summary_large_image",
    title: "Vanika — Plants E-Commerce",
    description: "Shop the finest plants delivered fresh to your door.",
    images: ["/og-image.jpg"],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${inter.variable} ${playfair.variable} font-sans antialiased`}>
        <Navbar />
        <main className="min-h-screen pb-14 md:pb-0">{children}</main>
        <Footer />
        <MobileBottomNav />
        <Toaster position="bottom-right" />
      </body>
    </html>
  );
}
