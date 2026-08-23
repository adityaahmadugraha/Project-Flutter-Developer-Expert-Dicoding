import os
import sys

LCOV_PATH = os.path.join("coverage", "lcov.info")


def parse_lcov(path):
    if not os.path.exists(path):
        print(f"File tidak ditemukan: {path}")
        print("Pastikan sudah menjalankan 'flutter test --coverage' dan")
        print("menjalankan script ini dari root folder project.")
        sys.exit(1)

    files = []
    current_file = None
    lines_found = 0
    lines_hit = 0

    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line.startswith("SF:"):
                current_file = line[3:]
            elif line.startswith("LF:"):
                lines_found = int(line[3:])
            elif line.startswith("LH:"):
                lines_hit = int(line[3:])
            elif line == "end_of_record":
                if current_file:
                    files.append((current_file, lines_hit, lines_found))
                current_file = None
                lines_found = 0
                lines_hit = 0

    return files


def main():
    files = parse_lcov(LCOV_PATH)

    if not files:
        print("Tidak ada data coverage ditemukan di lcov.info")
        sys.exit(1)

    total_hit = sum(h for _, h, _ in files)
    total_found = sum(f for _, _, f in files)

    print("=" * 80)
    print(f"{'FILE':<60} {'COVERAGE':>10} {'LINES':>8}")
    print("=" * 80)

    files_sorted = sorted(
        files, key=lambda x: (x[1] / x[2] if x[2] > 0 else 1)
    )

    for filename, hit, found in files_sorted:
        pct = (hit / found * 100) if found > 0 else 0
        short_name = filename.replace("lib/", "").replace("lib\\", "")
        marker = "  " if pct >= 70 else "!!"
        print(f"{marker} {short_name:<57} {pct:>8.1f}% {f'{hit}/{found}':>8}")

    print("=" * 80)
    total_pct = (total_hit / total_found * 100) if total_found > 0 else 0
    print(f"{'TOTAL COVERAGE':<60} {total_pct:>8.1f}% {f'{total_hit}/{total_found}':>8}")
    print("=" * 80)

    if total_pct >= 70:
        print(f"\n✅ Target 70% tercapai! ({total_pct:.1f}%)")
    else:
        gap = 70 - total_pct
        print(f"\n⚠️  Masih kurang {gap:.1f}% dari target 70%.")
        print("Lihat file dengan tanda '!!' di atas — itu yang paling butuh test tambahan.")


if __name__ == "__main__":
    main()