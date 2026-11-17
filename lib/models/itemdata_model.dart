import 'package:flutter/material.dart';

class ItemData {
  final String iconAsset;
  final String title;
  final String description;
  final Color backgroundColor;

  /// Optional text for text-to-speech when it differs from [title]
  /// (e.g. the Arabic letter name "باء" for the letter "ب").
  final String? speakAs;

  ItemData({
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.backgroundColor,
    this.speakAs,
  });
}
