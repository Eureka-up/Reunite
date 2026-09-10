import 'dart:io';

import 'package:flutter/material.dart';

/// Utilities for generating placeholder child avatars and handling images.
class ImageUtil {
  const ImageUtil._();

  static const List<Color> _palette = [
    Color(0xFF164A86),
    Color(0xFF1BB8A3),
    Color(0xFFE8A13C),
    Color(0xFF2F7BFF),
    Color(0xFF8A63D2),
  ];

  /// Deterministic branded avatar color for a given seed string.
  static Color colorFor(String seed) {
    var hash = 0;
    for (final code in seed.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return _palette[hash % _palette.length];
  }
}

/// Resolves a case photo path. In the mock, photos are represented by a seed
/// so we render an illustrated placeholder avatar (no real child photos).
class PhotoPathResolver {
  const PhotoPathResolver._();

  static bool isImage(String? path) {
    if (path == null) return false;
    final lower = path.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp');
  }

  /// True if the value is a demo seed (not a real file).
  static bool isDemoSeed(String? value) =>
      value != null && !isImage(value) && !_isFile(value);

  static bool _isFile(String value) {
    try {
      return File(value).existsSync();
    } catch (_) {
      return false;
    }
  }
}