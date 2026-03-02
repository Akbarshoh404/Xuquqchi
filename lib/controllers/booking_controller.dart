import 'package:flutter/material.dart';
import '../features/booking/models/lawyer_model.dart';

class BookingController extends ChangeNotifier {
  final List<BookingAppointment> _appointments = [];

  List<BookingAppointment> get appointments =>
      List.unmodifiable(_appointments);

  /// Upcoming appointments (today or future)
  List<BookingAppointment> get upcoming => _appointments
      .where((a) =>
          a.date.isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  /// Past appointments
  List<BookingAppointment> get past => _appointments
      .where((a) =>
          a.date.isBefore(DateTime.now().subtract(const Duration(days: 1))))
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));

  void addBooking({
    required Lawyer lawyer,
    required DateTime date,
    required String time,
  }) {
    _appointments.add(
      BookingAppointment(
        lawyer: lawyer,
        date: date,
        time: time,
        bookedAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void cancelBooking(BookingAppointment appointment) {
    _appointments.remove(appointment);
    notifyListeners();
  }
}
