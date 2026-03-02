import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../controllers/onboarding_controller.dart';

class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  State<WalkthroughPage> createState() => _WalkthroughPageState();
}

class _WalkthroughPageState extends State<WalkthroughPage> {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _pages = [
    {'title': 'Find Trusted\nDoctors', 'desc': 'Find and connect with certified doctors in your area with just a few taps.', 'icon': '🔍'},
    {'title': 'Book an\nAppointment', 'desc': 'Schedule your appointment at your preferred time without any hassle.', 'icon': '📅'},
    {'title': 'Get Your\nSolution', 'desc': 'Consult with doctors and get the best treatment for your health problems.', 'icon': '💊'},
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingController(),
      child: Consumer<OnboardingController>(
        builder: (context, controller, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.letsYouIn),
                        child: Text('Skip', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: controller.setPage,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        final page = _pages[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              Container(
                                height: 280,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text(page['icon']!, style: const TextStyle(fontSize: 80))),
                              ),
                              const SizedBox(height: 32),
                              Text(page['title']!, style: AppTextStyles.h1, textAlign: TextAlign.center),
                              const SizedBox(height: 16),
                              Text(page['desc']!, style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary), textAlign: TextAlign.center),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: controller.currentPage == i ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: controller.currentPage == i ? AppColors.primary : AppColors.border,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          )),
                        ),
                        const SizedBox(height: 24),
                        PrimaryButton(
                          text: controller.currentPage == 2 ? 'Get Started' : 'Next',
                          onPressed: () {
                            if (controller.currentPage == 2) {
                              Navigator.pushReplacementNamed(context, AppRoutes.letsYouIn);
                            } else {
                              controller.nextPage(_pageController);
                            }
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
