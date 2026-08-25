import 'package:core/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App color constants', () {
    test('richBlack should be defined correctly', () {
      expect(richBlack, const Color(0xFF000814));
    });

    test('mikadoYellow should be defined correctly', () {
      expect(mikadoYellow, const Color(0xFFffc300));
    });
  });

  group('baseImageUrl', () {
    test('should point to TMDB image CDN', () {
      expect(BASE_IMAGE_URL, 'https://image.tmdb.org/t/p/w500');
    });
  });
}