// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:movavid/pages/home_laboratorio.dart';
import 'package:movavid/providers/hrayto_provider.dart';
import 'package:movavid/providers/url_provider.dart';
import 'package:movavid/theme/app_theme.dart';
import 'package:movavid/widgets/connection_banner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:desktop_window/desktop_window.dart';

const String titleApp = 'Laboratorio';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final UrlProvider urlProvider = UrlProvider();
  await urlProvider.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: urlProvider),
        ChangeNotifierProvider(create: (context) => HRaytoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isWindows) {
      DesktopWindow.setWindowSize(const Size(1280, 800));
      DesktopWindow.setMinWindowSize(const Size(960, 640));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: titleApp,
      theme: buildLightTheme(),
      themeMode: ThemeMode.light,
      builder: (context, child) => Column(
        children: [
          const ConnectionBanner(),
          Expanded(child: child ?? const SizedBox.shrink()),
        ],
      ),
      home: const Homemovavid(
        title: titleApp,
      ),
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'), // English
      ],
    );
  }
}