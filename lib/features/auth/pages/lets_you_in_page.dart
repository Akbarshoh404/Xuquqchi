import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class LetsYouInPage extends StatelessWidget {
  const LetsYouInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Icon(Icons.favorite, color: AppColors.primary, size: 64),
              const SizedBox(height: 24),
              Text("Let's you in", style: AppTextStyles.h1.copyWith(fontSize: 40)),
              const Spacer(),
              _socialButton(Icons.g_mobiledata, 'Continue with Google', () {}),
              const SizedBox(height: 16),
              _socialButton(Icons.facebook, 'Continue with Facebook', () {}, color: const Color(0xFF1877F2)),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('or', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Sign in with password', onPressed: () => Navigator.pushNamed(context, AppRoutes.signIn)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: AppTextStyles.bodyMedium),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.signUp),
                    child: Text('Sign up', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: color ?? AppColors.textPrimary, size: 28),
        label: Text(label, style: AppTextStyles.labelMedium),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
