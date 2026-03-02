import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class FillProfilePage extends StatefulWidget {
  const FillProfilePage({super.key});

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  final _fields = {
    'Full Name': TextEditingController(),
    'Nickname': TextEditingController(),
    'Date of Birth': TextEditingController(),
    'Email': TextEditingController(),
    'Phone Number': TextEditingController(),
  };
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Fill Your Profile', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Stack(
              children: [
                CircleAvatar(radius: 50, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, size: 60, color: AppColors.primary)),
                Positioned(
                  bottom: 0, right: 0,
                  child: CircleAvatar(
                    radius: 16, backgroundColor: AppColors.primary,
                    child: const Icon(Icons.edit, size: 16, color: AppColors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ..._fields.entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.key, style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  TextField(
                    controller: e.value,
                    decoration: InputDecoration(
                      hintText: e.key,
                      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ],
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gender', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                Row(
                  children: ['Male', 'Female'].map((g) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: g == 'Male' ? 8 : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedGender = g),
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            border: Border.all(color: _selectedGender == g ? AppColors.primary : AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                            color: _selectedGender == g ? AppColors.primaryLight : AppColors.white,
                          ),
                          child: Center(child: Text(g, style: AppTextStyles.bodyMedium.copyWith(color: _selectedGender == g ? AppColors.primary : AppColors.textPrimary))),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            PrimaryButton(text: 'Continue', onPressed: () => Navigator.pushNamed(context, AppRoutes.createPin)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
