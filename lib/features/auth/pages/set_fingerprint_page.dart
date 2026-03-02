import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class SetFingerprintPage extends StatelessWidget {
  const SetFingerprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Set Fingerprint', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 120, height: 120,
              decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
              child: const Icon(Icons.fingerprint, size: 70, color: AppColors.primary),
            ),
            const SizedBox(height: 32),
            Text('Add Fingerprint', style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            Text(
              'Place your fingerprint on the scanner to enable biometric authentication.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            PrimaryButton(text: 'Continue', onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
              child: Text('Skip', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
