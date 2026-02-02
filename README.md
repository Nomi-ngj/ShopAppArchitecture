# Zabehaty Shops App – Modular SPM Architecture

## 1. Overview

The Zabehaty Shops App is built using a **modular architecture with Swift Package Manager (SPM)**. This structure ensures:

* **Scalability:** Easily add 50–100 feature modules
* **Testability:** Unit, integration, and mock testing
* **Separation of concerns:** Clear layers for UI, domain, network, and shared utilities
* **Concurrency safety:** `@MainActor` and `Sendable` types
* **Scalable feature modules:** (Products, Orders, Auth, etc.)
* **Modern iOS development:** iOS 15+, Xcode 26, Swift 6, Portrait-only support

The app uses **MVVM architecture** with **dependency injection** and follows clean modular design principles.

---

## 2. Swift Package Modules (SPM)

### 2.1 AppFoundation

**Purpose:** Core utilities and shared helpers.

**Contents:**

* Extensions: String, Array, UIView, Date, etc.
* Helpers: Logger, DateFormatter, Validators
* Shared objects: AppConfig, AppSession, Singletons

**Responsibilities:**

* Provide shared functionality to all modules
* Avoid code duplication in features
* Support app-wide configuration and utilities

## Project Structure

```
ZabehatyShopsApp/
 ├─ AppFoundation/        # SPM: Shared helpers, extensions, utilities
 ├─ Domain/               # SPM: Feature models, enums, requests/responses
 ├─ NetworkCore/          # SPM: Moya ProviderFactory, Logger, Async extensions
 ├─ Modules/              # SPM: Feature modules (Products, Orders, Auth)
 │    └─ ProductsModule/
 │         ├─ Source/
 │         │    ├─ Provider/Service/Target
 │         │    ├─ ViewModel/Protocol
 │         │    └─ View/
 │         └─ Tests/
 │              ├─ Mock ViewModels
 │              ├─ Unit Tests
 │              └─ Service Tests
 ├─ ZabehatyShopsApp/     # Main app target
 │    ├─ Info.plist
 │    ├─ Assets.xcassets
 │    └─ LaunchScreen.storyboard / SwiftUI Launch View
 └─ Tests/                # App-wide tests
```

---

### 2.2 Domain

**Purpose:** Defines domain models, enums, requests, and responses.

**Structure:**

* Domain/Products/

  * Models: ProductDTO, ProductDetailDTO
  * Enums: ProductCategory, Status
  * Requests & Responses

**Responsibilities:**

* Single source of truth for data structures
* Decouples features from network layer
* Shared across multiple modules

---

### 2.3 Modules

**Purpose:** Feature-specific modules containing business logic, UI, and DI.

**Example: Products Module:**

```
Modules/Products/
 ├─ Source/
 │    ├─ Provider/Service/Target
 │    │    - ProductsService
 │    │    - ProductsProvider/Target
 │    ├─ ViewModel/
 │    │    - ProductsViewModel
 │    │    - ProductsViewModel Protocol
 │    └─ View/
 │         - ProductsViewController
 └─ Tests/
      ├─ Mock ViewModels
      │    - MockProductsListVM
      │    - MockProductDetailsVM
      ├─ Unit Tests
      │    - ListViewModelTests
      │    - DetailViewModelTests
      └─ Service Tests
           - Service Integration Tests
           - Service Mock Tests
```

**Responsibilities:**

* Service/Provider/Target: network communication
* ViewModel: exposes data and actions to UI
* Dependency Injection: enables swapping mocks for testing
* View: presents UI and binds to ViewModel

**Data Flow:**

1. UI calls ViewModel
2. ViewModel calls Service
3. Service calls NetworkCore
4. NetworkCore fetches and parses data
5. ViewModel publishes data to UI

---

### 2.4 NetworkCore

**Purpose:** Shared networking utilities.

**Contents:**

* ProviderFactory: generates Moya providers
* NetworkLogger: logs requests/responses
* Moya extensions: async/await helpers
* APIEndpoint management

**Responsibilities:**

* Standardized networking layer
* Logging, error handling, async/await
* Avoids duplicate network code

---

## 3. Dependency Flow

```
AppFoundation   -> Shared helpers
      │
Domain          -> Domain models, enums
      │
NetworkCore     -> Moya providers, logger
      │
Modules         -> Feature modules (Products, Orders, Auth)
      │
UI Layer       -> ViewControllers / SwiftUI Views
```

* Feature modules depend on Domain & NetworkCore
* AppFoundation provides utilities for all modules
* Modules are independent and testable

---

## 4. Testing Strategy

**Mocking:**

* Mock ViewModels simulate data without network calls
* Mock Services simulate network responses

**Unit Tests:**

* ViewModels tested independently with mocks
* Verify data loading, error handling, and state updates

**Integration Tests:**

* Service tested with stubbed or real endpoints
* Verify correct mapping from JSON to Domain Models
* Check API paths, HTTP methods, and parameters

**Benefits:**

* Fast, repeatable tests
* Ensures module contracts are respected
* Supports async/await and MainActor safety

---

## 5. Module Dependency Diagram

**Modules Dependency Flow:**

```
         ┌─────────────────┐
         │  AppFoundation  │
         │  (Helpers, Ext) │
         └────────┬────────┘
                  │
                  ▼
         ┌─────────────────┐
         │     Domain      │
         │  Models/Enums   │
         └────────┬────────┘
                  │
                  ▼
         ┌─────────────────┐
         │   NetworkCore   │
         │  ProviderFactory│
         │ NetworkLogger   │
         └────────┬────────┘
                  │
                  ▼
     ┌─────────────────────────┐
     │      Modules SPM        │
     │ Products / Orders / Auth│
     └───────────┬─────────────┘
                 │
                 ▼
        ┌─────────────────┐
        │       UI        │
        │ViewControllers/ │
        │ SwiftUI Views   │
        └─────────────────┘
```

**Data Flow (Products Example):**

```
User Action (UI)
       │
       ▼
ProductsViewController
       │
       ▼
ProductsViewModelUseCases
       │
       ▼
ProductsService (ProductsTarget + MoyaProvider)
       │
       ▼
NetworkCore (ProviderFactory, Moya, Logger)
       │
       ▼
API / JSON Response
       │
       ▼
Domain Models (ProductDTO, ProductDetailDTO)
       │
       └─> Back to ProductsViewModel → UI
```

**Testing Flow:**

```
   Mock ViewModel / Mock Service
            │
            ▼
   ProductsViewModelUseCases
            │
            ▼
       ViewModel Tests
            │
            ├─ Verify products array
            ├─ Verify selected product
            └─ Verify error handling

   Mock Moya Provider
            │
            ▼
       ProductsService
            │
            ▼
     Service Unit / Integration Tests
```

---

## 6. Advantages of This Architecture

* Highly modular; each module is independent
* Testable via mocks and DI
* Scalable; adding new features requires a new module
* Reusable core networking and domain models
* Safe for concurrency with `@MainActor` and `Sendable`
* Future-proof with SPM and MVVM

---

## 7. Summary

* Modular design with **SPM packages**
* Clear **dependency flow**: AppFoundation → Domain → NetworkCore → Modules → UI
* **MVVM pattern** with **ViewModels** and **dependency injection**
* Comprehensive **testing strategy** (unit, integration, mock)
* Concurrency-safe and highly maintainable

This architecture supports **easy addition of new modules**, **independent testing**, and **clean separation of concerns** for the Zabehaty Shops iOS application.
