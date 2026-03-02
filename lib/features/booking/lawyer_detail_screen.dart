import 'package:flutter/material.dart';
import 'models/lawyer_model.dart';
import 'review_screen.dart';
import 'booking_screen.dart';

class LawyerDetailScreen extends StatelessWidget {
  final Lawyer lawyer;

  const LawyerDetailScreen({super.key, required this.lawyer});

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
        title: Text(
          lawyer.fullDisplayName,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            lawyer.profileImageUrl,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              width: 90,
                              height: 90,
                              color: Colors.grey[300],
                              child: const Icon(Icons.person,
                                  size: 50, color: Colors.white70),
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lawyer.fullDisplayName,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                lawyer.specialty,
                                style: TextStyle(
                                  fontSize: 15.5,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                lawyer.locationDisplay,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatCircle(
                            icon: Icons.people_alt_outlined,
                            value: lawyer.clientsDisplay,
                            label: 'clients'),
                        _buildStatCircle(
                            icon: Icons.gavel,
                            value: lawyer.yearsDisplay,
                            label: 'yrs exp.'),
                        _buildStatCircle(
                            icon: Icons.star_border_rounded,
                            value: lawyer.rating.toString(),
                            label: 'rating'),
                        _buildStatCircle(
                            icon: Icons.chat_bubble_outline_rounded,
                            value: lawyer.reviewsDisplay,
                            label: 'reviews'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('About me',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        const SizedBox(height: 10),
                        Text(lawyer.about,
                            style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.grey[800],
                                height: 1.45)),
                        const SizedBox(height: 32),
                        const Text('Working Time',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        const SizedBox(height: 10),
                        Text(
                            '${lawyer.workingDays}, ${lawyer.workingHours}',
                            style: TextStyle(
                                fontSize: 14.5, color: Colors.grey[800])),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Reviews',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewScreen(
                                      rating: lawyer.rating,
                                      totalReviews: lawyer.reviewsCount,
                                      reviews: lawyer.recentReviews,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'See All',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF0066FF),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (lawyer.recentReviews.isNotEmpty) ...[
                          _buildReviewCard(lawyer.recentReviews[0]),
                          const SizedBox(height: 16),
                          if (lawyer.recentReviews.length > 1) ...[
                            _buildReviewCard(lawyer.recentReviews[1]),
                            const SizedBox(height: 16),
                          ],
                          if (lawyer.recentReviews.length > 2) ...[
                            _buildReviewCard(lawyer.recentReviews[2]),
                          ],
                        ],
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(lawyer: lawyer),
                  ),
                );
                if (result == true && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment booked successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
                elevation: 0,
                textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4),
              ),
              child: const Text('Book Consultation'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCircle(
      {required IconData icon,
      required String value,
      required String label}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
              color: Color(0xFFE8F0FE), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF4285F4), size: 28),
        ),
        const SizedBox(height: 10),
        Text(value,
            style: const TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w600,
                color: Colors.black87)),
        Text(label, style: TextStyle(fontSize: 11.5, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildReviewCard(Review review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: review.reviewerAvatarUrl != null
                ? NetworkImage(review.reviewerAvatarUrl!)
                : null,
            child: review.reviewerAvatarUrl == null
                ? Text(review.reviewerName[0],
                    style: const TextStyle(color: Colors.white))
                : null,
            backgroundColor:
                review.reviewerAvatarUrl == null ? Colors.blueGrey : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(review.reviewerName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  review.comment,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[800], height: 1.4),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text('${review.rating}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }
}