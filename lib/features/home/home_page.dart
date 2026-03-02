import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/chat_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _currentIndex == 0
            ? _buildHomeContent(user)
            : _currentIndex == 2
                ? _buildHistoryContent()
                : _buildComingSoon(_tabLabel(_currentIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyles.caption,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), activeIcon: Icon(Icons.calendar_today), label: 'Appointment'),
          BottomNavigationBarItem(icon: Icon(Icons.history_outlined), activeIcon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.article_outlined), activeIcon: Icon(Icons.article), label: 'Articles'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  String _tabLabel(int i) {
    const labels = ['Home', 'Appointment', 'History', 'Articles', 'Profile'];
    return labels[i];
  }

  Widget _buildHomeContent(user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(radius: 22, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Morning 👋', style: AppTextStyles.bodySmall),
                    Text(user?.name ?? 'Andrew Ainsley', style: AppTextStyles.h3),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF1D4ED8)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Early protection\nfor your family", style: AppTextStyles.h3.copyWith(color: AppColors.white)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        child: const Text('Learn More'),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.health_and_safety, size: 80, color: Colors.white24),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Doctor Speciality', style: AppTextStyles.h3),
              TextButton(onPressed: () {}, child: Text('See All', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary))),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _specialityItem(Icons.favorite, 'Cardio'),
                _specialityItem(Icons.psychology, 'Neuro'),
                _specialityItem(Icons.visibility, 'Eye'),
                _specialityItem(Icons.child_care, 'Pediatric'),
                _specialityItem(Icons.healing, 'General'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Doctors', style: AppTextStyles.h3),
              TextButton(onPressed: () {}, child: Text('See All', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary))),
            ],
          ),
          const SizedBox(height: 12),
          ..._topDoctors().map((d) => _doctorCard(d)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _specialityItem(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _topDoctors() => [
    {'name': 'Dr. Drake Boeson', 'specialty': 'General Doctor', 'rating': '4.9'},
    {'name': 'Dr. Aidan Allende', 'specialty': 'Cardiologist', 'rating': '4.8'},
    {'name': 'Dr. Salvatore Heredia', 'specialty': 'Neurologist', 'rating': '4.7'},
  ];

  Widget _doctorCard(Map<String, dynamic> d) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, color: AppColors.primary, size: 32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d['name'], style: AppTextStyles.labelMedium),
                Text(d['specialty'], style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            children: [
              Row(children: [const Icon(Icons.star, color: Colors.amber, size: 14), const SizedBox(width: 2), Text(d['rating'], style: AppTextStyles.caption)]),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail, arguments: {'name': d['name'], 'image': ''}),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                  child: Text('Chat', style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryContent() {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: Builder(builder: (ctx) {
        final chat = ctx.watch<ChatController>();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Text('History', style: AppTextStyles.h2),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.search, color: AppColors.textPrimary), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary), onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: ['Message', 'Voice Call', 'Video Call'].map((tab) => Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(tab, style: tab == 'Message'
                      ? AppTextStyles.labelMedium.copyWith(color: AppColors.primary)
                      : AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                )).toList(),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: chat.sessions.length,
                separatorBuilder: (_, __) => const Divider(height: 1, indent: 80),
                itemBuilder: (context, i) {
                  final s = chat.sessions[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    leading: CircleAvatar(radius: 28, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, color: AppColors.primary)),
                    title: Text(s.doctorName, style: AppTextStyles.labelMedium),
                    subtitle: Text(s.lastMessage, style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: Text(_formatTime(s.lastTime), style: AppTextStyles.caption),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail, arguments: {'name': s.doctorName, 'image': ''}),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today,\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} AM';
    if (diff.inDays == 1) return 'Yesterday,\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} PM';
    return '${dt.day}/${dt.month}/${dt.year},\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} AM';
  }

  Widget _buildComingSoon(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text('$title Coming Soon', style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
