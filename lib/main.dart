import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'core/ui/ui_provider.dart';
import 'home/language/data/models/language.dart';
import 'home/language/data/repository/language_repository.dart';
import 'injection.dart';
import 'navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await configureDependencies();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }
  runApp(
    ChangeNotifierProvider(create: (_) => UiProvider(), child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LanguageRepositoryI _languageRepository;
  late Locale _locale;
  StreamSubscription<Language>? _languageSubscription;

  @override
  void initState() {
    super.initState();
    _languageRepository = getIt<LanguageRepositoryI>();
    _locale = _languageRepository.currentLanguage.locale;
    _languageSubscription = _languageRepository.languageStream.listen((
      language,
    ) {
      setState(() => _locale = language.locale);
    });
  }

  @override
  void dispose() {
    _languageSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Assistant',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (context, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            context.read<UiProvider>().updateLayout(context);
          }
        });
        return child!;
      },
      home: const MainNavigationScreen(),
    );
  }
}
