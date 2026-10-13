"use client";

import { useState } from "react";
import { Mail, CheckCircle } from "lucide-react";
import toast from "react-hot-toast";

export function Newsletter() {
  const [email, setEmail] = useState("");
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!email) return;
    setSubmitted(true);
    toast.success("🌿 Welcome to the Vanika botanical circle!", {
      style: {
        background: "#09281e",
        color: "#4ade80",
        border: "1px solid #166534",
      },
    });
  };

  return (
    <section className="bg-gradient-to-b from-[#051c14] to-[#03110c] py-16 text-white border-t border-emerald-500/10 relative overflow-hidden">
      <div className="container mx-auto px-6 sm:px-12 lg:px-20 max-w-6xl relative z-10">
        <div className="max-w-2xl mx-auto text-center space-y-4">
          <div className="w-10 h-10 rounded-xl bg-emerald-500/15 border border-emerald-400/30 flex items-center justify-center mx-auto text-[#4ade80]">
            <Mail className="w-4 h-4" />
          </div>

          <h2 className="font-serif text-2xl sm:text-3xl md:text-4xl font-normal tracking-tight text-white">
            Get Plant Care Tips & <span className="text-[#4ade80]">15% Off</span>
          </h2>

          <p className="text-emerald-100/70 text-xs sm:text-sm max-w-md mx-auto font-light">
            Subscribe to our weekly botanical journal with seasonal watering advice, repotting calendars, and flash sales.
          </p>

          {submitted ? (
            <div className="inline-flex items-center gap-1.5 px-4 py-2 rounded-full bg-emerald-500/20 border border-emerald-400/40 text-[#4ade80] text-xs font-semibold">
              <CheckCircle className="w-3.5 h-3.5" />
              <span>Thank you! Your 15% discount code is on the way.</span>
            </div>
          ) : (
            <form
              onSubmit={handleSubmit}
              className="flex flex-col sm:flex-row gap-2 max-w-sm mx-auto pt-2"
            >
              <input
                type="email"
                required
                placeholder="Enter your email address..."
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="flex-1 px-4 py-2.5 rounded-full bg-[#0a2f22] border border-emerald-500/30 text-white placeholder:text-emerald-300/40 text-xs focus:outline-none focus:border-[#4ade80] transition-colors"
              />
              <button
                type="submit"
                className="px-6 py-2.5 rounded-full bg-[#4ade80] hover:bg-[#34d399] text-[#062419] font-bold text-xs transition-all shadow-md hover:scale-105"
              >
                Join Now
              </button>
            </form>
          )}
        </div>
      </div>
    </section>
  );
}
