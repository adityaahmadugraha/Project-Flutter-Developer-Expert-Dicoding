import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  static const ROUTE_NAME = '/about';

  static const String githubUrl =
      'https://github.com/adityaahmadugraha/Project-Flutter-Developer-Expert-Dicoding';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: mikadoYellow,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: richBlack,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(Icons.movie, size: 32, color: mikadoYellow),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Ditonton',
                    style: heading5.copyWith(color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Movie & TV Series',
                    style: bodyText.copyWith(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dikembangkan sebagai proyek submission '
                        'kelas Menjadi Flutter Developer Expert.',
                    style: bodyText,
                  ),
                  const SizedBox(height: 24),
                  Text('Fitur Utama', style: heading6),
                  const SizedBox(height: 12),
                  _FeatureItem(
                      icon: Icons.movie_outlined,
                      label: 'Movie dan TV series'),
                  _FeatureItem(
                      icon: Icons.bookmark_outline,
                      label: 'Watchlist tersimpan lokal'),
                  _FeatureItem(icon: Icons.search, label: 'Pencarian reaktif'),
                  const SizedBox(height: 24),
                  Text('Teknologi', style: heading6),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _TechChip(label: 'BLoC'),
                      _TechChip(label: 'Firebase'),
                      _TechChip(label: 'SSL Pinning'),
                      _TechChip(label: 'SSL Pinning'),
                      _TechChip(label: 'Continuous Integration'),
                      _TechChip(label: 'Testing'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Versi 1.0.0',
                        style: bodyText.copyWith(color: davysGrey),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: githubUrl));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Link repository disalin')),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.code, size: 16, color: mikadoYellow),
                            const SizedBox(width: 4),
                            Text(
                              'Salin link GitHub',
                              style: bodyText.copyWith(color: mikadoYellow),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: mikadoYellow),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: bodyText)),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: prussianBlue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: bodyText.copyWith(color: Colors.white),
      ),
    );
  }
}
