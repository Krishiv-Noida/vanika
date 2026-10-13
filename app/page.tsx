import { HeroSection } from "@/components/home/HeroSection";
import { FeaturedPlants } from "@/components/home/FeaturedPlants";
import { CategorySection } from "@/components/home/CategorySection";
import { WhyVanika } from "@/components/home/WhyVanika";
import { Testimonials } from "@/components/home/Testimonials";
import { Newsletter } from "@/components/home/Newsletter";
import { CareGuidesBanner } from "@/components/home/CareGuidesBanner";

export default function HomePage() {
  return (
    <>
      <HeroSection />
      <CategorySection />
      <FeaturedPlants />
      <WhyVanika />
      <CareGuidesBanner />
      <Testimonials />
      <Newsletter />
    </>
  );
}
