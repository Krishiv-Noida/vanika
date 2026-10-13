import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Create Account",
  description: "Join Vanika and start your plant journey today.",
};

export default function RegisterPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-muted/30">
      <div className="w-full max-w-md p-8 bg-card rounded-2xl shadow-lg border border-border">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-display font-bold text-primary">🌿 Vanika</h1>
          <p className="text-muted-foreground mt-2">Create your account</p>
        </div>
        {/* RegisterForm component will go here */}
      </div>
    </div>
  );
}
