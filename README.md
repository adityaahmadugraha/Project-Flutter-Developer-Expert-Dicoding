# Ditonton — Flutter Expert Submission

![Flutter CI](https://github.com/adityaahmadugraha/Project-Flutter-Developer-Expert-Dicoding/actions/workflows/flutter_ci.yml/badge.svg)

Ditonton adalah aplikasi **Movie & TV Series** menggunakan data dari API [The Movie Database (TMDB)](https://www.themoviedb.org/), dikembangkan sebagai submission pada kelas Multi-Platform App Developer **Menjadi Flutter Developer Expert — Dicoding Indonesia**.

Repository ini merupakan pengembangan lanjutan dari starter project di kelas ini, dengan penambahan fitur TV Series, migrasi state management ke BLoC,Menerapkan SSL Pinning, Firebase Analytics & Crashlytics , serta Continuous Integration dengan Github Action.

---

## ✨ Fitur

- **Halaman Movie & TV Series** — Now Playing/On The Air, Popular, dan Top Rated, masing-masing punya halaman tersendiri
- **Detail Movie & TV Series** — poster, rating, sinopsis, genre, serta rekomendasi tontonan serupa
- **Pencarian reaktif** — hasil pencarian muncul otomatis saat mengetik (dengan debounce, tanpa perlu menekan tombol submit)
- **Watchlist lokal** — simpan Movie/TV series yang ingin ditonton, tersimpan permanen menggunakan SQLite meski aplikasi ditutup
- **Navigasi modern** — Bottom Navigation Bar (Home, Watchlist, About) dengan Tab Movies/TV Series yang dapat di-swipe

---

## 🏗️ Arsitektur & Tech Stack

| Layer/Aspek | Teknologi |
|---|---|
| Arsitektur | Clean Architecture (Domain – Data – Presentation) |
| State Management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) (BLoC pattern, migrasi dari Provider) |
| Dependency Injection | [get_it](https://pub.dev/packages/get_it) |
| Networking | [http](https://pub.dev/packages/http) dengan **SSL Pinning** |
| Local Storage | [sqflite](https://pub.dev/packages/sqflite) |
| Functional Error Handling | [dartz](https://pub.dev/packages/dartz) (`Either`) |
| Monitoring | Firebase Analytics & Crashlytics |
| Testing | flutter_test, mockito, bloc_test |
| CI/CD | GitHub Actions |

---

## 🔒 SSL Pinning

Aplikasi ini menerapkan **SSL Pinning** ke API TMDB (`api.themoviedb.org`). Ini menjadi lapisan keamanan tambahan terhadap potensi serangan Man-in-the-Middle (MITM).

---

## 📊 Firebase Analytics & Crashlytics

Aplikasi terintegrasi dengan **Firebase Analytics**

**Screenshot Analytics:**

![Firebase Analytics](assets/analytics.jpeg)

**Screenshot Crashlytics:**

![Firebase Crashlytics](assets/crahlytics.jpeg)

---

## ⚙️ Continuous Integration

Setiap kali ada push atau pull request ke branch `main`, GitHub Actions otomatis menjalankan:
1. **Analisis kode** (`flutter analyze`) dan pengecekan format (`dart format`)
2. **Seluruh automated test** (`flutter test --coverage`)

Konfigurasi workflow dapat dilihat di [`.github/workflows/flutter_ci.yml`](.github/workflows/flutter_ci.yml). Status build terkini ditampilkan pada badge di bagian atas README ini.

---

## 🧪 Testing & Coverage

Project ini memiliki automated test di seluruh layer (Domain, Data, dan Presentation/BLoC) dengan **coverage di atas 70%** (dijalankan otomatis lewat CI).

Untuk menjalankan test secara lokal beserta laporan coverage:

```bash
flutter test --coverage
```

Laporan awal akan tersimpan di `coverage/lcov.info`. Untuk melihat laporan dalam bentuk persentase.

```bash
python check_coverage.py
```

---

## 📁 Struktur Proyek

```
lib/
├── common/          # Konstanta, utilitas, penanganan exception & failure
├── data/            # Models, data sources (remote & local), repository implementation
├── domain/          # Entities, repository interfaces, use cases
├── presentation/
│   ├── bloc/        # BLoC (Event, State, Bloc) per fitur
│   ├── pages/       # Halaman UI
│   └── widgets/     # Widget yang dapat digunakan ulang
├── injection.dart   # Dependency Injection (GetIt)
└── main.dart
```


---

## 🚀 Menjalankan Proyek

```bash
flutter pub get
flutter run
```

Pastikan environment sudah sesuai dengan `pubspec.yaml` , serta konfigurasi Firebase (`google-services.json` dan `firebase_options.dart`) sudah tersedia.
