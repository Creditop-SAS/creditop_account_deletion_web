import 'package:flutter/material.dart';

/// Sistema de sombras del Creditop Design System (CDS).
class CdsShadow {
  CdsShadow._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x29000000),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color(0x24000000),
    ),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      offset: Offset(0, -3),
      blurRadius: 4,
      spreadRadius: 0,
      color: Color(0x1F000000),
    ),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(
      offset: Offset(0, 16),
      blurRadius: 24,
      spreadRadius: 0,
      color: Color(0x24000000),
    ),
    BoxShadow(
      offset: Offset(0, 6),
      blurRadius: 30,
      spreadRadius: 0,
      color: Color(0x1F000000),
    ),
    BoxShadow(
      offset: Offset(0, 8),
      blurRadius: 10,
      spreadRadius: 0,
      color: Color(0x33000000),
    ),
  ];
}
