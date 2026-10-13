import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/colors.dart';
import 'core/theme.dart';
import 'providers/cart_provider.dart';
import 'providers/filter_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system navigation & status bar transparent for immersive botanical feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: VanikaColors.bgDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const VanikaMobileApp());
}

class VanikaMobileApp extends StatelessWidget {
  const VanikaMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        title: 'Vanika — Where Nature Meets Your Doorstep',
        debugShowCheckedModeBanner: false,
        theme: VanikaTheme.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}
