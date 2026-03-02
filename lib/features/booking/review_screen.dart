import 'package:flutter/material.dart';
import 'models/lawyer_model.dart';

class ReviewScreen extends StatefulWidget {
  final double rating;
  final int totalReviews;
  final List<Review> reviews;

  const ReviewScreen({
    super.key,
    required this.rating,
    required this.totalReviews,
    required this.reviews,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int? _selectedRating;

  List<Review> get filteredReviews {
    if (_selectedRating == null) return widget.reviews;
    return widget.reviews.where((r) => r.rating == _selectedRating).toList();
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
        title: Text(
          '${widget.rating.toStringAsFixed(1)} (${widget.totalReviews.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} reviews)',
          style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black54), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              children: [
                _buildFilterChip('All', null, _selectedRating == null),
                const SizedBox(width: 12),
                _buildFilterChip('5', 5, _selectedRating == 5),
                const SizedBox(width: 12),
                _buildFilterChip('4', 4, _selectedRating == 4),
                const SizedBox(width: 12),
                _buildFilterChip('3', 3, _selectedRating == 3),
                const SizedBox(width: 12),
                _buildFilterChip('2', 2, _selectedRating == 2),
              ],
            ),
          ),
          Expanded(
            child: filteredReviews.isEmpty
                ? const Center(child: Text('No reviews match this filter', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildReviewItem(filteredReviews[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, int? rating, bool isSelected) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => setState(() => _selectedRating = rating),
      backgroundColor: isSelected ? const Color(0xFF0066FF) : Colors.grey.shade100,
      selectedColor: const Color(0xFF0066FF),
      shape: StadiumBorder(side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      showCheckmark: false,
    );
  }

  Widget _buildReviewItem(Review review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: review.reviewerAvatarUrl != null ? NetworkImage(review.reviewerAvatarUrl!) : null,
          child: review.reviewerAvatarUrl == null
              ? Text(review.reviewerName[0], style: const TextStyle(color: Colors.white))
              : null,
          backgroundColor: review.reviewerAvatarUrl == null ? Colors.blueGrey : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(review.reviewerName, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 3),
                        Text(
                          review.rating.toString(),
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                review.comment,
                style: TextStyle(fontSize: 14.5, color: Colors.grey[800], height: 1.4),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}