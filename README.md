# 📦 Smart ERP System (Flutter + GetX)

A cross-platform ERP (Enterprise Resource Planning) solution built using **Flutter** and **GetX**, designed to manage Sales, RFQs, Quotations, Invoices, Delivery Challans, and Client Requirements with integrated PDF handling and communication features (Email/WhatsApp).

---

## 🚀 Features

- 📄 **Sales Module** – Manage customer processes, feedback, approvals, and sales data.
- 📋 **Quotation & RFQ Management** – Add/edit product lines, generate RFQs and quotes with dynamic fields and validations.
- 📦 **Invoice & Delivery Challan** – Generate and send GST-compliant invoices and delivery documents.
- 📧 **Communication** – Share documents via Email and WhatsApp with type-determined message routing.
- 📂 **PDF Handling** – Generate, cache, print, and upload custom PDFs using the `printing` package and server APIs.
- 💳 **Billing** – Track invoice amounts, manage payment vouchers, and monitor outstanding balances efficiently.
- 🔁 **Subscription Management** – Handle recurring packages, automate invoice generation, and track subscription lifecycle.
- 🛠 **Dialogs & Forms** – Modular dialogs for different business flows with reactive forms and warning prompts.

---

## 📚 Components

### ✅ Frontend

- **Flutter**
- **GetX** for state management
- **UI**: AlertDialogs, Form validation, Custom Snackbars, Dynamic Search Lists

### 📡 Backend Communication

- HTTP API integration via `apiController` with token-based authentication
- File upload support using `Multer`-based APIs
- Response parsing using models like `CMDmResponse`, `CMDlResponse`, and `CMResponse`

## 🧩 Folder Structure (Simplified)

```bash
/lib
│
├── controllers/
│   └── rfq_controller.dart
│   └── sales_controller.dart
│   └── invoice_controller.dart
│
├── models/
│   └── rfq_model.dart
│   └── sales_model.dart
│   └── invoice_model.dart
│
├── ui/
│   └── dialogs/
│       └── generate_rfq.dart
│       └── generate_invoice.dart
│       └── generate_quote.dart
│       └── generate_dc.dart
│
├── utils/
│   └── api_controller.dart
│   └── loader.dart
│   └── dialogs.dart
│   └── formatting.dart
```
