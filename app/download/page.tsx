"use client";

import Link from "next/link";
import { useState } from "react";
import { 
  Download, 
  Smartphone, 
  ShieldCheck, 
  Sparkles, 
  CheckCircle2, 
  AlertCircle, 
  ArrowLeft,
  Bell,
  Leaf,
  Heart,
  QrCode,
  ScanLine
} from "lucide-react";
import { QRCodeSVG } from "qrcode.react";

const GITHUB_RELEASE_BASE = "https://github.com/Krishiv-Noida/vanika/releases/latest/download";
const UNIVERSAL_APK_URL = `${GITHUB_RELEASE_BASE}/vanika-android-universal.apk`;
const ARM64_APK_URL = `${GITHUB_RELEASE_BASE}/vanika-android-arm64-v8a.apk`;

export default function DownloadPage() {
  const [selectedVariant, setSelectedVariant] = useState<"universal" | "arm64">("universal");
  const activeUrl = selectedVariant === "universal" ? UNIVERSAL_APK_URL : ARM64_APK_URL;

  return (
    <div className="min-h-screen bg-[#020b08] text-white pt-10 sm:pt-14 pb-20 px-6 sm:px-12 lg:px-20">
      <div className="container mx-auto max-w-5xl">
        
        {/* Back Link */}
        <Link 
          href="/" 
          className="inline-flex items-center gap-2 text-xs font-medium text-emerald-300/80 hover:text-white transition-colors mb-8 group"
        >
          <ArrowLeft className="w-4 h-4 transition-transform group-hover:-translate-x-1" />
          Back to Home
        </Link>

        {/* Hero Section */}
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center mb-16">
          <div className="lg:col-span-7 space-y-6">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-[#08281d] border border-emerald-500/30 text-[#7ee787] text-xs font-semibold uppercase tracking-wider shadow-sm">
              <Sparkles className="w-3.5 h-3.5 text-[#7ee787]" />
              <span>Official Android App</span>
            </div>

            <h1 className="font-serif text-4xl sm:text-5xl lg:text-6xl font-normal text-[#f4f8f5] tracking-tight leading-[1.1]">
              Bring Vanika to Your <span className="text-[#6ee787]">Android Phone</span>
            </h1>

            <p className="text-[#a6c7b9] text-sm sm:text-base leading-relaxed font-light max-w-xl">
              Enjoy a faster, smoother botanical shopping experience. Browse curated indoor plants, track deliveries live, and access plant care guides on the go.
            </p>

            {/* Download Buttons */}
            <div className="pt-2 flex flex-col sm:flex-row gap-4">
              <a
                href={UNIVERSAL_APK_URL}
                className="inline-flex items-center justify-center gap-3.5 px-7 py-4 rounded-2xl bg-[#7ee787] hover:bg-[#68dc72] text-[#041d13] font-bold text-sm sm:text-base transition-all duration-300 shadow-[0_10px_30px_rgba(126,231,135,0.35)] hover:shadow-[0_15px_40px_rgba(126,231,135,0.5)] hover:-translate-y-0.5 active:translate-y-0"
              >
                <Download className="w-5 h-5 text-[#041d13] shrink-0" />
                <div className="text-left leading-tight">
                  <div className="font-bold">Download APK (Universal)</div>
                  <div className="text-[11px] font-normal opacity-80 mt-0.5">Works on all Android phones • ~59 MB</div>
                </div>
              </a>

              <a
                href={ARM64_APK_URL}
                className="inline-flex items-center justify-center gap-3 px-6 py-4 rounded-2xl bg-[#09261b] hover:bg-[#0f3a2b] border border-emerald-500/30 hover:border-emerald-400 text-emerald-100 font-semibold text-sm transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0"
              >
                <Smartphone className="w-5 h-5 text-emerald-400 shrink-0" />
                <div className="text-left leading-tight">
                  <div className="font-semibold text-white">ARM64 Version</div>
                  <div className="text-[11px] font-normal text-emerald-300/60 mt-0.5">Modern Phones • ~26 MB</div>
                </div>
              </a>
            </div>

            {/* Quick Safety Badge */}
            <div className="flex items-center gap-2 text-xs text-emerald-200/60 pt-1">
              <ShieldCheck className="w-4 h-4 text-[#7ee787]" />
              <span>Direct official build • Virus-free • Verified signature</span>
            </div>
          </div>

          {/* Interactive QR Code Card */}
          <div className="lg:col-span-5 flex justify-center">
            <div className="relative w-full max-w-sm p-6 sm:p-7 rounded-3xl bg-gradient-to-b from-[#0a2f22] to-[#041811] border border-emerald-500/30 shadow-[0_25px_60px_rgba(0,0,0,0.7)] text-center space-y-4">
              
              <div className="flex items-center justify-between">
                <div className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full bg-[#03170f] border border-emerald-500/25 text-[#7ee787] text-[11px] font-semibold">
                  <QrCode className="w-3.5 h-3.5 text-[#7ee787]" />
                  <span>Scan to Download</span>
                </div>
                <span className="text-[11px] text-emerald-300/70 font-mono">
                  v1.0.2 APK
                </span>
              </div>

              {/* Scannable QR Code */}
              <div className="relative mx-auto w-fit p-4 rounded-2xl bg-white shadow-[0_12px_36px_rgba(0,0,0,0.6)] border border-emerald-400/30 flex items-center justify-center">
                <QRCodeSVG
                  value={activeUrl}
                  size={180}
                  level="H"
                  includeMargin={false}
                  bgColor="#ffffff"
                  fgColor="#031811"
                />
                {/* Center Vanika Mini Badge */}
                <div className="absolute inset-0 m-auto w-10 h-10 rounded-xl bg-[#041d13] border-2 border-[#7ee787] flex items-center justify-center text-[#7ee787] shadow-lg pointer-events-none">
                  <Leaf className="w-5 h-5 fill-[#7ee787]" />
                </div>
              </div>

              {/* Variant Selector Tabs */}
              <div className="space-y-1.5 pt-1">
                <div className="grid grid-cols-2 gap-1.5 bg-[#03150f] p-1.5 rounded-xl border border-emerald-500/20 text-xs">
                  <button
                    type="button"
                    onClick={() => setSelectedVariant("universal")}
                    className={`py-1.5 px-2 rounded-lg font-medium transition-all ${
                      selectedVariant === "universal"
                        ? "bg-[#7ee787] text-[#041d13] shadow-sm font-semibold"
                        : "text-emerald-100/70 hover:text-white"
                    }`}
                  >
                    Universal APK
                  </button>
                  <button
                    type="button"
                    onClick={() => setSelectedVariant("arm64")}
                    className={`py-1.5 px-2 rounded-lg font-medium transition-all ${
                      selectedVariant === "arm64"
                        ? "bg-[#7ee787] text-[#041d13] shadow-sm font-semibold"
                        : "text-emerald-100/70 hover:text-white"
                    }`}
                  >
                    ARM64 APK
                  </button>
                </div>
                <p className="text-[11px] text-emerald-200/60 font-light">
                  {selectedVariant === "universal" 
                    ? "Point phone camera to download Universal APK (~59 MB)"
                    : "Point phone camera to download ARM64 APK (~26 MB)"}
                </p>
              </div>

              <div className="pt-1 flex items-center justify-center gap-2 text-xs text-emerald-200/80">
                <ScanLine className="w-4 h-4 text-[#7ee787] shrink-0 animate-pulse" />
                <span>Open phone camera &amp; scan code</span>
              </div>

              {/* Feature Highlights */}
              <div className="pt-2 space-y-2 text-left text-xs text-emerald-100/80 border-t border-emerald-500/15">
                <div className="flex items-center gap-2.5 pt-1">
                  <CheckCircle2 className="w-4 h-4 text-[#7ee787] shrink-0" />
                  <span>Direct install on Android</span>
                </div>
                <div className="flex items-center gap-2.5">
                  <Bell className="w-4 h-4 text-[#7ee787] shrink-0" />
                  <span>Live Delivery Tracking &amp; Care Guides</span>
                </div>
                <div className="flex items-center gap-2.5">
                  <Heart className="w-4 h-4 text-[#7ee787] shrink-0" />
                  <span>Curated Nursery-Fresh Plants</span>
                </div>
              </div>

            </div>
          </div>
        </div>

        {/* 3-Step Installation Guide (Crucial for End Users) */}
        <div className="mt-12 p-8 sm:p-10 rounded-3xl bg-[#051912] border border-emerald-500/20 shadow-2xl">
          <div className="text-center max-w-xl mx-auto mb-8">
            <h2 className="font-serif text-2xl sm:text-3xl font-normal text-white">
              How to Install on Your Android Phone
            </h2>
            <p className="text-xs sm:text-sm text-emerald-100/60 mt-2 font-light">
              Since you are installing directly from our official website, follow these 3 simple steps:
            </p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            {/* Step 1 */}
            <div className="p-6 rounded-2xl bg-[#09261c] border border-emerald-500/20 space-y-3">
              <div className="w-8 h-8 rounded-full bg-[#7ee787] text-[#041d13] font-bold text-sm flex items-center justify-center">
                1
              </div>
              <h3 className="font-semibold text-white text-sm">Download the APK</h3>
              <p className="text-xs text-emerald-100/70 leading-relaxed font-light">
                Tap the <strong>Download APK</strong> button above to download the installer file to your phone.
              </p>
            </div>

            {/* Step 2 */}
            <div className="p-6 rounded-2xl bg-[#09261c] border border-emerald-500/20 space-y-3">
              <div className="w-8 h-8 rounded-full bg-[#7ee787] text-[#041d13] font-bold text-sm flex items-center justify-center">
                2
              </div>
              <h3 className="font-semibold text-white text-sm">Allow Download</h3>
              <p className="text-xs text-emerald-100/70 leading-relaxed font-light">
                If your browser shows <em>&quot;File might be harmful&quot;</em>, tap <strong>&quot;Download anyway&quot;</strong> (standard Android warning for direct APK downloads).
              </p>
            </div>

            {/* Step 3 */}
            <div className="p-6 rounded-2xl bg-[#09261c] border border-emerald-500/20 space-y-3">
              <div className="w-8 h-8 rounded-full bg-[#7ee787] text-[#041d13] font-bold text-sm flex items-center justify-center">
                3
              </div>
              <h3 className="font-semibold text-white text-sm">Open &amp; Install</h3>
              <p className="text-xs text-emerald-100/70 leading-relaxed font-light">
                Open the downloaded file from your notifications. If prompted to allow installs from this source, turn it on and tap <strong>Install</strong>.
              </p>
            </div>
          </div>

          <div className="mt-8 p-4 rounded-xl bg-[#03150f] border border-emerald-500/15 flex items-start sm:items-center gap-3 text-xs text-emerald-200/70">
            <AlertCircle className="w-5 h-5 text-[#7ee787] shrink-0 mt-0.5 sm:mt-0" />
            <span>
              <strong>Safe &amp; Official:</strong> This APK is compiled directly from our verified open-source repository and contains no malware or ads.
            </span>
          </div>
        </div>

      </div>
    </div>
  );
}
