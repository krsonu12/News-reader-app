import 'dart:ui';
import 'package:flutter/material.dart';

@immutable
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    required this.primaryBrand,
    required this.secondaryBrand,
    required this.cardRadius,
    required this.cardElevation,
  });

  final Color primaryBrand;
  final Color secondaryBrand;
  final double cardRadius;
  final double cardElevation;

  @override
  BrandTheme copyWith({
    Color? primaryBrand,
    Color? secondaryBrand,
    double? cardRadius,
    double? cardElevation,
  }) {
    return BrandTheme(
      primaryBrand: primaryBrand ?? this.primaryBrand,
      secondaryBrand: secondaryBrand ?? this.secondaryBrand,
      cardRadius: cardRadius ?? this.cardRadius,
      cardElevation: cardElevation ?? this.cardElevation,
    );
  }

  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }

    return BrandTheme(
      primaryBrand: Color.lerp(primaryBrand, other.primaryBrand, t) ?? primaryBrand,
      secondaryBrand: Color.lerp(secondaryBrand, other.secondaryBrand, t) ?? secondaryBrand,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t) ?? cardRadius,
      cardElevation: lerpDouble(cardElevation, other.cardElevation, t) ?? cardElevation,
    );
  }
}
