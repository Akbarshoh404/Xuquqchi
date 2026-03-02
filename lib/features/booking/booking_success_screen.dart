import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/routes/app_routes.dart';
import 'models/lawyer_model.dart';

class BookingSuccessScreen extends StatelessWidget {
  final Lawyer lawyer;
  final DateTime date;
  final String time;

  const BookingSuccessScreen({
    super.key,
    required this.lawyer,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    size: 60, color: Colors.green),
              ),
              const SizedBox(height: 32),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your appointment with ${lawyer.fullDisplayName} has been successfully booked.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD0DCFF)),
                ),
                child: Column(
                  children: [
                    _infoRow(
                      icon: Icons.person_outline,
                      label: 'Lawyer',
                      value: lawyer.fullDisplayName,
                    ),
                    const Divider(height: 24),
                    _infoRow(
                      icon: Icons.gavel,
                      label: 'Specialty',
                      value: lawyer.specialty,
                    ),
                    const Divider(height: 24),
                    _infoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Date',
                      value: DateFormat('EEEE, d MMMM yyyy').format(date),
                    ),
                    const Divider(height: 24),
                    _infoRow(
                      icon: Icons.access_time_outlined,
                      label: 'Time',
                      value: time,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0066FF),
                    foregroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    elevation: 0,
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('Go to Home'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                      arguments: {'tab': 1}, // Navigate to Appointment tab
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0066FF),
                    side: const BorderSide(color: Color(0xFF0066FF)),
                    shape: const StadiumBorder(),
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  child: const Text('View My Appointments'),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
      {required IconData icon,
      required String label,
      required String value}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0066FF), size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey[500])),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }
}
