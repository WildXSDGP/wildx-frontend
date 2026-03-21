import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/wildlife_gallery_screen.dart';

/// APP STARTING POINT
/// This is where the WildX adventure begins!
void main() {
  // 1. Ensure Flutter framework is fully loaded before doing anything else
  WidgetsFlutterBinding.ensureInitialized();

  // 2. DEVICE LOCK:
  // We lock the app to Portrait mode only. 
  // This ensures our UI cards and grids always look perfect and don't get messy on rotate.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 3. STATUS BAR STYLING:
  // Making the top status bar (where the clock is) transparent.
  // This allows the WildX green theme to bleed through smoothly to the very top.
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:            Colors.transparent,
      statusBarIconBrightness:   Brightness.light, // White icons for battery/clock
      statusBarBrightness:       Brightness.dark,
    ),
  );

  runApp(const WildXApp());
}

class WildXApp extends StatelessWidget {
  const WildXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ── IDENTITY ───────────────────────────────────────────────────────────
      title:                      'WildX',
      debugShowCheckedModeBanner: false, // Hides that red "Debug" ribbon on the top corner

      // ── DESIGN SYSTEM (Theme) ──────────────────────────────────────────────
      /**
       * We define a GLOBAL theme here. 
       * This means every button and card in the app will automatically 
       * look consistent without us styling them manually every time.
       */
      theme: ThemeData(
        useMaterial3:       true, // Enables the latest Android 13+ design features
        colorScheme:        ColorScheme.fromSeed(
          seedColor:        const Color(0xFF2ECC71), // Our Signature WildX Green
          brightness:       Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F7F4), // A very light minty background

        // APP BAR: Customizing the top header across all screens
        appBarTheme: const AppBarTheme(
          backgroundColor:  Color(0xFF2ECC71),
          foregroundColor:  Colors.white,
          elevation:        0, // No shadow for a modern, flat look
          centerTitle:      false,
          titleTextStyle:   TextStyle(
            fontSize:       18,
            fontWeight:     FontWeight.w600,
            letterSpacing:  -0.2,
            color:          Colors.white,
          ),
        ),

        // BUTTONS: Designing the green buttons used for SOS and Sharing
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color(0xFF2ECC71),
            foregroundColor:  Colors.white,
            elevation:        0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14), // Rounded corners for a friendly feel
            ),
            textStyle: const TextStyle(
              fontSize:     15,
              fontWeight:   FontWeight.w600,
            ),
          ),
        ),

        // CARDS: Styling the animal grid items
        cardTheme: CardThemeData(
          color:        Colors.white,
          elevation:    0, // Clean, shadowless white cards
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // SEARCH BAR: Removing borders for a cleaner, modern look
        inputDecorationTheme: InputDecorationTheme(
          filled:          true,
          fillColor:       Colors.white,
          border:          InputBorder.none,
          enabledBorder:   InputBorder.none,
          focusedBorder:   InputBorder.none,
          contentPadding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          hintStyle: TextStyle(
            color:         Colors.grey[400],
            fontSize:      14,
          ),
        ),

        // DETAIL SHEET: Styling the bottom popup when an animal is clicked
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor:    Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // ── NAVIGATION ─────────────────────────────────────────────────────────
      
      // Setting the Home Screen as the first thing the user sees
      home: const WildlifeGalleryScreen(),

      // Defining Routes so we can jump between screens easily later on
      routes: {
        '/gallery':  (_) => const WildlifeGalleryScreen(),
        // TIP: Uncomment these as you create the new screen files:
        // '/notifications': (_) => const NotificationScreen(),
      },
    );
  }
}