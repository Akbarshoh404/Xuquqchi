import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/chat_controller.dart';
import '../../controllers/booking_controller.dart';
import '../booking/data/lawyers_data.dart';
import '../booking/models/lawyer_model.dart';

class HomePage extends StatefulWidget {
  final int initialTab;

  const HomePage({super.key, this.initialTab = 0});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _buildBody(user),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: AppTextStyles.caption
            .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTextStyles.caption,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'Appointment'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              activeIcon: Icon(Icons.article),
              label: 'Articles'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBody(user) {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent(user);
      case 1:
        return _buildAppointmentsContent();
      case 2:
        return _buildHistoryContent();
      default:
        return _buildComingSoon(_tabLabel(_currentIndex));
    }
  }

  String _tabLabel(int i) {
    const labels = ['Home', 'Appointment', 'History', 'Articles', 'Profile'];
    return labels[i];
  }

  // ─── HOME TAB ─────────────────────────────────────────────────────────────

  Widget _buildHomeContent(user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Header
          Row(
            children: [
              CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primaryLight,
                  child: const Icon(Icons.person, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Morning 👋', style: AppTextStyles.bodySmall),
                    Text(user?.name ?? 'Andrew Ainsley',
                        style: AppTextStyles.h3),
                  ],
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {}),
            ],
          ),
          const SizedBox(height: 24),
          // Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF0066FF), Color(0xFF1D4ED8)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Professional Legal\nServices for You",
                          style: AppTextStyles.h3
                              .copyWith(color: AppColors.white)),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text('Learn More'),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.gavel, size: 80, color: Colors.white24),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Law categories
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Law Specialities', style: AppTextStyles.h3),
              TextButton(
                  onPressed: () {},
                  child: Text('See All',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.primary))),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _specialityItem(Icons.family_restroom, 'Family'),
                _specialityItem(Icons.business, 'Corporate'),
                _specialityItem(Icons.gavel, 'Criminal'),
                _specialityItem(Icons.flight, 'Immigration'),
                _specialityItem(Icons.home_work, 'Property'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Top lawyers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Top Lawyers', style: AppTextStyles.h3),
              TextButton(
                  onPressed: () {},
                  child: Text('See All',
                      style: AppTextStyles.bodyMedium
                          .copyWith(color: AppColors.primary))),
            ],
          ),
          const SizedBox(height: 12),
          ...sampleLawyers.map((lawyer) => _lawyerCard(lawyer)),
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

  Widget _lawyerCard(Lawyer lawyer) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.lawyerDetail,
        arguments: lawyer,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                lawyer.profileImageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 60,
                  height: 60,
                  color: AppColors.primaryLight,
                  child: const Icon(Icons.person,
                      color: AppColors.primary, size: 32),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lawyer.fullDisplayName,
                      style: AppTextStyles.labelMedium),
                  Text(lawyer.specialty, style: AppTextStyles.bodySmall),
                  const SizedBox(height: 2),
                  Text(lawyer.firm,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textHint)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 2),
                  Text('${lawyer.rating}', style: AppTextStyles.caption)
                ]),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('Book',
                      style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── APPOINTMENT TAB ──────────────────────────────────────────────────────

  Widget _buildAppointmentsContent() {
    final bookingController = context.watch<BookingController>();
    final upcoming = bookingController.upcoming;
    final past = bookingController.past;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: Text('My Appointments', style: AppTextStyles.h2),
        ),
        Expanded(
          child: upcoming.isEmpty && past.isEmpty
              ? _buildEmptyAppointments()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    if (upcoming.isNotEmpty) ...[
                      Text('Upcoming', style: AppTextStyles.h3),
                      const SizedBox(height: 12),
                      ...upcoming.map((a) => _appointmentCard(a, false)),
                      const SizedBox(height: 24),
                    ],
                    if (past.isNotEmpty) ...[
                      Text('Past', style: AppTextStyles.h3),
                      const SizedBox(height: 12),
                      ...past.map((a) => _appointmentCard(a, true)),
                    ],
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyAppointments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
                color: AppColors.primaryLight, shape: BoxShape.circle),
            child: const Icon(Icons.calendar_today_outlined,
                size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: 20),
          Text('No Appointments Yet', style: AppTextStyles.h3),
          const SizedBox(height: 8),
          Text(
            'Book a consultation with one of our\nlawyers from the Home tab.',
            style: AppTextStyles.bodyMedium
                .copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => setState(() => _currentIndex = 0),
            icon: const Icon(Icons.search),
            label: const Text('Find a Lawyer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentCard(BookingAppointment appointment, bool isPast) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isPast ? AppColors.border : const Color(0xFFD0DCFF)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  appointment.lawyer.profileImageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 50,
                    height: 50,
                    color: AppColors.primaryLight,
                    child: const Icon(Icons.person,
                        color: AppColors.primary, size: 28),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(appointment.lawyer.fullDisplayName,
                        style: AppTextStyles.labelMedium),
                    Text(appointment.lawyer.specialty,
                        style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPast
                      ? Colors.grey.shade100
                      : const Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isPast ? 'Completed' : 'Upcoming',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPast ? Colors.grey : const Color(0xFF0066FF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                DateFormat('EEE, d MMM yyyy').format(appointment.date),
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.access_time_outlined,
                  size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                appointment.time,
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
          if (!isPast) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<BookingController>()
                          .cancelBooking(appointment);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                        context, AppRoutes.lawyerDetail,
                        arguments: appointment.lawyer),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('View Lawyer'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ─── HISTORY TAB ─────────────────────────────────────────────────────────

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
                  IconButton(
                      icon: const Icon(Icons.search,
                          color: AppColors.textPrimary),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.more_horiz,
                          color: AppColors.textPrimary),
                      onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: ['Message', 'Voice Call', 'Video Call']
                    .map((tab) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Text(tab,
                              style: tab == 'Message'
                                  ? AppTextStyles.labelMedium
                                      .copyWith(color: AppColors.primary)
                                  : AppTextStyles.bodyMedium.copyWith(
                                      color: AppColors.textSecondary)),
                        ))
                    .toList(),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: chat.sessions.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, indent: 80),
                itemBuilder: (context, i) {
                  final s = chat.sessions[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 8),
                    leading: CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primaryLight,
                        child:
                            const Icon(Icons.person, color: AppColors.primary)),
                    title:
                        Text(s.doctorName, style: AppTextStyles.labelMedium),
                    subtitle: Text(s.lastMessage,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    trailing:
                        Text(_formatTime(s.lastTime), style: AppTextStyles.caption),
                    onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail,
                        arguments: {'name': s.doctorName, 'image': ''}),
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
    if (diff.inDays == 0) {
      return 'Today,\n${dt.hour.toString().padLeft(2, '0')}.${dt.minute.toString().padLeft(2, '0')} AM';
    }
    if (diff.inDays == 1) {
      return 'Yesterday,\n${dt.hour.toString().padLeft(2, '0')}.${dt.minute.toString().padLeft(2, '0')} PM';
    }
    return '${dt.day}/${dt.month}/${dt.year},\n${dt.hour.toString().padLeft(2, '0')}.${dt.minute.toString().padLeft(2, '0')} AM';
  }

  Widget _buildComingSoon(String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text('$title Coming Soon',
              style: AppTextStyles.h3
                  .copyWith(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
