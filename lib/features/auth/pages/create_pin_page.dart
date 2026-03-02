import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final List<String> _pin = [];

  void _onKey(String value) {
    if (_pin.length < 4) setState(() => _pin.add(value));
  }

  void _onDelete() {
    if (_pin.isNotEmpty) setState(() => _pin.removeLast());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () => Navigator.pop(context)),
        title: Text('Create PIN', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text('Create Your PIN', style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Add a PIN number to make your account more secure.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 20, height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < _pin.length ? AppColors.primary : AppColors.border,
                ),
              )),
            ),
            const SizedBox(height: 48),
            _buildKeypad(),
            const Spacer(),
            PrimaryButton(
              text: 'Continue',
              onPressed: _pin.length == 4 ? () => Navigator.pushNamed(context, AppRoutes.setFingerprint) : () {},
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    const keys = [['1','2','3'],['4','5','6'],['7','8','9'],['','0','⌫']];
    return Column(
      children: keys.map((row) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: row.map((k) => SizedBox(
          width: 80, height: 80,
          child: k.isEmpty ? const SizedBox() : InkWell(
            onTap: () => k == '⌫' ? _onDelete() : _onKey(k),
            borderRadius: BorderRadius.circular(40),
            child: Center(child: Text(k, style: AppTextStyles.h2.copyWith(fontSize: 28))),
          ),
        )).toList(),
      )).toList(),
    );
  }
}
