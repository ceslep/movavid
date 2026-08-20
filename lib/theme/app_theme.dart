import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color brandSeed = Color(0xFF0E8C79);
const Color brandSecondary = Color(0xFF0E7490);

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  final LinearGradient brand;
  final LinearGradient brandSoft;
  final LinearGradient brandFaint;

  const AppGradients({
    required this.brand,
    required this.brandSoft,
    required this.brandFaint,
  });

  @override
  AppGradients copyWith({
    LinearGradient? brand,
    LinearGradient? brandSoft,
    LinearGradient? brandFaint,
  }) {
    return AppGradients(
      brand: brand ?? this.brand,
      brandSoft: brandSoft ?? this.brandSoft,
      brandFaint: brandFaint ?? this.brandFaint,
    );
  }

  @override
  AppGradients lerp(AppGradients? other, double t) {
    if (other == null) return this;
    return AppGradients(
      brand: LinearGradient.lerp(brand, other.brand, t)!,
      brandSoft: LinearGradient.lerp(brandSoft, other.brandSoft, t)!,
      brandFaint: LinearGradient.lerp(brandFaint, other.brandFaint, t)!,
    );
  }
}

extension AppGradientsX on BuildContext {
  AppGradients get gradients => Theme.of(this).extension<AppGradients>()!;
}

extension ThemeGradientsX on ThemeData {
  AppGradients get gradients => extension<AppGradients>()!;
}

ThemeData buildAppTheme(Brightness brightness) {
  final bool dark = brightness == Brightness.dark;
  final ColorScheme scheme = ColorScheme.fromSeed(
    seedColor: brandSeed,
    brightness: brightness,
    secondary: brandSecondary,
  );

  final Color surface = scheme.surface;
  final Color onSurface = scheme.onSurface;

  final ThemeData base = ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
  );

  final TextTheme textTheme = base.textTheme.copyWith(
    displaySmall: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.6,
    ),
    headlineMedium: const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.4,
    ),
    headlineSmall: const TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.3,
    ),
    titleLarge: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.2,
    ),
    titleMedium: const TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w700,
    ),
    titleSmall: const TextStyle(
      fontSize: 13.5,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: const TextStyle(fontSize: 15, height: 1.4),
    bodyMedium: const TextStyle(fontSize: 13.5, height: 1.4),
    bodySmall: const TextStyle(fontSize: 12, height: 1.35),
    labelLarge: const TextStyle(
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),
    labelMedium: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  );

  final InputDecorationTheme inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: dark ? scheme.surfaceContainerLow : Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: scheme.outlineVariant),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: scheme.outlineVariant),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: scheme.primary, width: 1.6),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: scheme.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: scheme.error, width: 1.6),
    ),
    labelStyle: TextStyle(color: scheme.onSurfaceVariant),
    hintStyle: TextStyle(
      color: scheme.onSurfaceVariant.withValues(alpha: 0.65),
      fontWeight: FontWeight.w400,
    ),
    prefixIconColor: scheme.onSurfaceVariant,
    suffixIconColor: scheme.onSurfaceVariant,
    floatingLabelStyle: TextStyle(color: scheme.primary),
  );

  return base.copyWith(
    scaffoldBackgroundColor: dark ? surface : const Color(0xFFF3F6F5),
    splashFactory: InkSparkle.splashFactory,
    textTheme: textTheme,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(),
      },
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      titleSpacing: 4,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.3,
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 21),
      actionsIconTheme:
          IconThemeData(color: scheme.onSurfaceVariant, size: 21),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: dark ? scheme.surfaceContainerLow : Colors.white,
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: scheme.outlineVariant.withValues(alpha: dark ? 0.35 : 0.6),
        ),
      ),
    ),
    inputDecorationTheme: inputTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        side: BorderSide(color: scheme.outlineVariant, width: 1.2),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      elevation: 1.5,
      hoverElevation: 4,
      focusElevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surface,
      indicatorColor: scheme.primaryContainer,
      indicatorShape: const StadiumBorder(),
      selectedIconTheme: IconThemeData(color: scheme.primary, size: 22),
      selectedLabelTextStyle: TextStyle(
        color: onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.primaryContainer,
      elevation: 0,
      height: 72,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          fontSize: 12,
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w600,
          color: states.contains(WidgetState.selected)
              ? onSurface
              : scheme.onSurfaceVariant,
        ),
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: const WidgetStatePropertyAll(8),
      radius: const Radius.circular(4),
      thumbColor: WidgetStatePropertyAll(
        scheme.onSurfaceVariant.withValues(alpha: dark ? 0.4 : 0.35),
      ),
      trackVisibility: const WidgetStatePropertyAll(false),
      mainAxisMargin: 4,
    ),
    tooltipTheme: TooltipThemeData(
      waitDuration: const Duration(milliseconds: 350),
      showDuration: const Duration(milliseconds: 3000),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: dark ? scheme.inverseSurface : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      titleTextStyle: TextStyle(
        color: onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
      contentTextStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 14,
        height: 1.4,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: dark ? scheme.inverseSurface : Colors.grey.shade900,
      contentTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    chipTheme: base.chipTheme.copyWith(
      shape: const StadiumBorder(),
      side: BorderSide(color: scheme.outlineVariant),
      labelStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
      selectedColor: scheme.primaryContainer,
      showCheckmark: false,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant.withValues(alpha: 0.45),
      thickness: 1,
      space: 1,
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      iconColor: scheme.onSurfaceVariant,
      titleTextStyle: TextStyle(
        color: onSurface,
        fontSize: 14.5,
        fontWeight: FontWeight.w600,
      ),
      subtitleTextStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontSize: 12.5,
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(6)),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: surface,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: inputTheme,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(3),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: scheme.outlineVariant),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: scheme.primary,
      linearTrackColor: scheme.primaryContainer.withValues(alpha: 0.4),
      circularTrackColor: scheme.primaryContainer.withValues(alpha: 0.3),
    ),
    extensions: [
      AppGradients(
        brand: const LinearGradient(
          colors: [Color(0xFF0E8C79), Color(0xFF14A18B), Color(0xFF0E7490)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.55, 1],
        ),
        brandSoft: const LinearGradient(
          colors: [Color(0xFFE2F3EE), Color(0xFFDCEEF5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        brandFaint: LinearGradient(
          colors: [
            brandSeed.withValues(alpha: 0.1),
            brandSecondary.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ],
  );
}

ThemeData buildLightTheme() => buildAppTheme(Brightness.light);