import 'package:flutter/material.dart';
import './navigation/routes.dart';
import './navigation/route_generator.dart';

// Define the navigator key globally
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Growth App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue, // Material 3 uses seeds for better color palettes
      ),
      initialRoute: Routes.welcome,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: navigatorKey,
    );
  }
}