import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'controllers/auth_controller.dart';
import 'controllers/booking_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => BookingController()),
      ],
      child: MaterialApp(
        title: 'Xuquqchi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0066FF)),
          useMaterial3: true,
          fontFamily: 'Urbanist',
        ),
        initialRoute: AppRoutes.initial,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
