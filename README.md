# 🌿 Vanika — Plants E-Commerce

> _"Where nature meets your doorstep"_

Vanika is a modern, full-featured plants e-commerce web application built with **Next.js 14**, **TypeScript**, and **Tailwind CSS**.

---

## 🌱 Features

- 🛒 **Product Catalog** — Browse indoor, outdoor, succulents, and rare plants
- 🔍 **Search & Filter** — Filter by category, price, light requirement, and care level
- 🛍️ **Cart & Checkout** — Seamless add-to-cart and checkout experience
- 👤 **User Auth** — Sign up / Login with NextAuth.js
- ❤️ **Wishlist** — Save your favourite plants
- 📦 **Order Tracking** — Track your plant delivery in real time
- 🌍 **Care Guides** — Detailed plant care information
- ⭐ **Reviews** — Product ratings and customer reviews
- 🔔 **Admin Dashboard** — Manage products, orders, and users

---

## 🏗️ Architecture

```
vanika/
├── app/                    # Next.js 14 App Router
│   ├── (auth)/             # Auth pages (login, register)
│   ├── (shop)/             # Shop pages (catalog, product, cart)
│   ├── account/            # User account & orders
│   ├── admin/              # Admin dashboard
│   └── api/                # API routes
├── components/             # Reusable UI components
│   ├── ui/                 # Base UI (Button, Card, Input...)
│   ├── layout/             # Navbar, Footer, Sidebar
│   ├── shop/               # Product cards, filters, cart
│   └── home/               # Hero, Featured, Testimonials
├── lib/                    # Utility functions & config
├── hooks/                  # Custom React hooks
├── store/                  # Zustand state management
├── types/                  # TypeScript interfaces
├── prisma/                 # Database schema (Prisma ORM)
├── public/                 # Static assets
└── styles/                 # Global styles
```

---

## 🛠️ Tech Stack

| Layer         | Technology               |
| ------------- | ------------------------ |
| Framework     | Next.js 14 (App Router)  |
| Language      | TypeScript               |
| Styling       | Tailwind CSS + Shadcn/ui |
| Database      | PostgreSQL + Prisma ORM  |
| Auth          | NextAuth.js v5           |
| State         | Zustand                  |
| Payments      | Razorpay / Stripe        |
| Image Storage | Cloudinary               |
| Email         | Resend                   |
| Deployment    | Vercel                   |

---

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- PostgreSQL database
- npm / yarn / pnpm

### Installation

```bash
# Clone the repository
git clone https://github.com/nitzzChauhan/vanika.git
cd vanika

# Install dependencies
npm install

# Set up environment variables
cp .env.example .env.local
# Fill in your credentials in .env.local

# Run database migrations
npx prisma migrate dev

# Seed the database with sample plants
npm run db:seed

# Start development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to see the app.

---

## 📁 Environment Variables

See [`.env.example`](.env.example) for all required environment variables.

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

<div align="center">Made with 💚 by the Vanika Team</div>
