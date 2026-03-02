import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryLight,
                ),
                child: const Center(
                  child: Icon(Icons.health_and_safety, size: 100, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 32),
              Text('Best Doctor\nAppointment App', style: AppTextStyles.h1.copyWith(fontSize: 32), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(
                'Experience the convenience of booking doctor appointments with ease.',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              PrimaryButton(
                text: "Get Started",
                onPressed: () => Navigator.pushNamed(context, AppRoutes.walkthrough),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
