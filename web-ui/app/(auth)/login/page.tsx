import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Sign In",
  description: "Sign in to your Vanika account to manage your plants and orders.",
};

export default function LoginPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-muted/30">
      <div className="w-full max-w-md p-8 bg-card rounded-2xl shadow-lg border border-border">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-display font-bold text-primary">🌿 Vanika</h1>
          <p className="text-muted-foreground mt-2">Sign in to your account</p>
        </div>
        {/* LoginForm component will go here */}
      </div>
    </div>
  );
}
