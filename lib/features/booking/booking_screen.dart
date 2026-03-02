import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/booking_controller.dart';
import 'models/lawyer_model.dart';
import 'booking_success_screen.dart';

class BookingScreen extends StatefulWidget {
  final Lawyer lawyer;

  const BookingScreen({super.key, required this.lawyer});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime? _selectedDate;
  String? _selectedTime;
  bool _isLoading = false;

  final List<String> _availableTimes = [
    '09:00 AM', '09:30 AM', '10:00 AM', '10:30 AM',
    '11:00 AM', '11:30 AM',
    '03:00 PM', '03:30 PM', '04:00 PM', '04:30 PM',
    '05:00 PM', '05:30 PM',
  ];

  Future<void> _confirmBooking() async {
    if (_selectedDate == null || _selectedTime == null) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    // Save appointment to controller
    context.read<BookingController>().addBooking(
          lawyer: widget.lawyer,
          date: _selectedDate!,
          time: _selectedTime!,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingSuccessScreen(
            lawyer: widget.lawyer,
            date: _selectedDate!,
            time: _selectedTime!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Book Appointment',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 19,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  'Select Date for ${widget.lawyer.fullDisplayName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () => setState(() {
                        _focusedDate = DateTime(
                            _focusedDate.year, _focusedDate.month - 1);
                      }),
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(_focusedDate),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () => setState(() {
                        _focusedDate = DateTime(
                            _focusedDate.year, _focusedDate.month + 1);
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildCalendar(),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Select Hour',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _availableTimes.map((time) {
                      final selected = _selectedTime == time;
                      return ChoiceChip(
                        label: Text(time,
                            style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFF0066FF))),
                        selected: selected,
                        onSelected: (_) =>
                            setState(() => _selectedTime = time),
                        selectedColor: const Color(0xFF0066FF),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                              color: selected
                                  ? Colors.transparent
                                  : const Color(0xFF0066FF),
                              width: 1.5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_selectedDate != null &&
                            _selectedTime != null &&
                            !_isLoading)
                        ? _confirmBooking
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0066FF),
                      shape: const StadiumBorder(),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2.5),
                          )
                        : const Text('Confirm Booking',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
                color: Colors.black26,
                child: const Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final daysInMonth =
        DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstWeekday =
        DateTime(_focusedDate.year, _focusedDate.month, 1).weekday;
    final today = DateTime.now();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
              .map((d) => SizedBox(
                  width: 40,
                  child: Center(
                      child: Text(d,
                          style: const TextStyle(color: Colors.grey)))))
              .toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7),
          itemCount: daysInMonth + (firstWeekday - 1),
          itemBuilder: (context, index) {
            if (index < firstWeekday - 1) return const SizedBox.shrink();
            final day = index - (firstWeekday - 1) + 1;
            final date =
                DateTime(_focusedDate.year, _focusedDate.month, day);
            final isPast = date
                .isBefore(today.subtract(const Duration(days: 1)));
            final isSelected = _selectedDate?.day == day &&
                _selectedDate?.month == _focusedDate.month &&
                _selectedDate?.year == _focusedDate.year;

            return GestureDetector(
              onTap: isPast
                  ? null
                  : () => setState(() => _selectedDate = date),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFF0066FF) : null),
                child: Center(
                  child: Text(
                    '$day',
                    style: TextStyle(
                      color: isPast
                          ? Colors.grey.shade400
                          : (isSelected ? Colors.white : Colors.black87),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
