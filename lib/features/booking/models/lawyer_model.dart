class Lawyer {
  final String fullName;
  final String title;
  final String specialty;
  final String firm;
  final String location;
  final String profileImageUrl;
  final int clientsCount;
  final int yearsExperience;
  final double rating;
  final int reviewsCount;
  final String about;
  final String workingDays;
  final String workingHours;
  final List<Review> recentReviews;

  Lawyer({
    required this.fullName,
    required this.title,
    required this.specialty,
    required this.firm,
    required this.location,
    required this.profileImageUrl,
    required this.clientsCount,
    required this.yearsExperience,
    required this.rating,
    required this.reviewsCount,
    required this.about,
    required this.workingDays,
    required this.workingHours,
    this.recentReviews = const [],
  });

  String get fullDisplayName => '$title $fullName';
  String get clientsDisplay =>
      clientsCount >= 1000 ? '${(clientsCount ~/ 1000)}K+' : '$clientsCount';
  String get yearsDisplay => '$yearsExperience+';
  String get reviewsDisplay => reviewsCount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );
  String get locationDisplay => '$firm · $location';
}

class Review {
  final String reviewerName;
  final String comment;
  final int rating;
  final String? reviewerAvatarUrl;

  Review({
    required this.reviewerName,
    required this.comment,
    required this.rating,
    this.reviewerAvatarUrl,
  });
}

class BookingAppointment {
  final Lawyer lawyer;
  final DateTime date;
  final String time;
  final DateTime bookedAt;

  BookingAppointment({
    required this.lawyer,
    required this.date,
    required this.time,
    required this.bookedAt,
  });
}
