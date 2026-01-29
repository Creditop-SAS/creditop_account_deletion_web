import 'package:flutter/material.dart';

/// Typography system for Creditop Design System (CDS).
class CdsTypography {
  CdsTypography._();

  static const String fontFamily = 'Satoshi';
  static const HeadingTextStyles heading = HeadingTextStyles();
  static const TextLargeStyles textLarge = TextLargeStyles();
  static const TextMediumStyles textMedium = TextMediumStyles();
  static const TextRegularStyles textRegular = TextRegularStyles();
  static const TextSmallStyles textSmall = TextSmallStyles();
  static const TextTinyStyles textTiny = TextTinyStyles();
  static const TextMiniStyles textMini = TextMiniStyles();
}

class HeadingTextStyles {
  const HeadingTextStyles();

  TextStyle get xxlarge => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 56, fontWeight: FontWeight.w700, height: 1.2,
  );
  TextStyle get xlarge => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 48, fontWeight: FontWeight.w700, height: 1.2,
  );
  TextStyle get large => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 40, fontWeight: FontWeight.w700, height: 1.2,
  );
  TextStyle get medium => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 32, fontWeight: FontWeight.w700, height: 1.3,
  );
  TextStyle get mmall => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 28, fontWeight: FontWeight.w700, height: 1.4,
  );
  TextStyle get small => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 26, fontWeight: FontWeight.w700, height: 1.4,
  );
  TextStyle get xsmall => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 24, fontWeight: FontWeight.w700, height: 1.4,
  );
  TextStyle get xxsmall => const TextStyle(
    fontFamily: CdsTypography.fontFamily, fontSize: 20, fontWeight: FontWeight.w700, height: 1.4,
  );
}

class TextLargeStyles {
  const TextLargeStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 20, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 20, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 20, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 20, fontWeight: FontWeight.w300, height: 1.5);
}

class TextMediumStyles {
  const TextMediumStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 18, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 18, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 18, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 18, fontWeight: FontWeight.w300, height: 1.5);
}

class TextRegularStyles {
  const TextRegularStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 16, fontWeight: FontWeight.w300, height: 1.5);
}

class TextSmallStyles {
  const TextSmallStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 14, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 14, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 14, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 14, fontWeight: FontWeight.w300, height: 1.5);
}

class TextTinyStyles {
  const TextTinyStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 12, fontWeight: FontWeight.w300, height: 1.5);
}

class TextMiniStyles {
  const TextMiniStyles();
  TextStyle get bold => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 10, fontWeight: FontWeight.w700, height: 1.5);
  TextStyle get medium => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 10, fontWeight: FontWeight.w500, height: 1.5);
  TextStyle get normal => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 10, fontWeight: FontWeight.w400, height: 1.5);
  TextStyle get light => const TextStyle(fontFamily: CdsTypography.fontFamily, fontSize: 10, fontWeight: FontWeight.w300, height: 1.5);
}
