import '../models/lawyer_model.dart';

final List<Lawyer> sampleLawyers = [
  Lawyer(
    title: 'Ms.',
    fullName: 'Jenny Watson',
    specialty: 'Family Law Specialist',
    firm: 'Watson & Partners',
    location: 'London, UK',
    profileImageUrl:
        'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=988&q=80',
    clientsCount: 5000,
    yearsExperience: 10,
    rating: 4.8,
    reviewsCount: 4942,
    about:
        'Ms. Jenny Watson is a leading Family Law specialist at Watson & Partners in London. She has successfully handled numerous high-profile cases and received several recognitions for her dedication to client rights and fair outcomes. Available for private consultations.',
    workingDays: 'Monday - Friday',
    workingHours: '09:00 AM - 19:00 PM',
    recentReviews: [
      Review(
        reviewerName: 'Charolette Hanlin',
        comment:
            'Ms. Watson handled my divorce and child custody case with exceptional professionalism and clarity. She fought hard for my rights and we reached a very fair settlement. Highly recommend!',
        rating: 5,
        reviewerAvatarUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80',
      ),
      Review(
        reviewerName: 'Darron Kulikowski',
        comment:
            'Extremely knowledgeable and responsive. She explained every step of my prenuptial agreement clearly. Saved me from many potential issues.',
        rating: 5,
      ),
      Review(
        reviewerName: 'Lauralee Quintero',
        comment:
            'Jenny was amazing during my complex property division case after separation. Very strategic and calm under pressure.',
        rating: 5,
      ),
      Review(
        reviewerName: 'Aileen Fullbright',
        comment:
            'Professional, empathetic and very thorough. Helped me with adoption paperwork and court process — everything went smoothly.',
        rating: 4,
      ),
      Review(
        reviewerName: 'Rodolfo Goode',
        comment:
            'Solid advice and strong representation in my family dispute. Communication was excellent and results were fair.',
        rating: 4,
      ),
    ],
  ),
  Lawyer(
    title: 'Mr.',
    fullName: 'James Harrington',
    specialty: 'Corporate Law Expert',
    firm: 'Harrington Legal',
    location: 'New York, USA',
    profileImageUrl:
        'https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80',
    clientsCount: 3200,
    yearsExperience: 15,
    rating: 4.9,
    reviewsCount: 3100,
    about:
        'Mr. James Harrington is a senior corporate law expert at Harrington Legal in New York. With over 15 years of experience, he specializes in mergers, acquisitions, and complex commercial contracts for Fortune 500 companies.',
    workingDays: 'Monday - Saturday',
    workingHours: '08:00 AM - 18:00 PM',
    recentReviews: [
      Review(
        reviewerName: 'Angela Torres',
        comment:
            'James guided our startup through a complex acquisition deal. His knowledge of corporate law is outstanding.',
        rating: 5,
      ),
      Review(
        reviewerName: 'Michael Chen',
        comment:
            'Very thorough with contract reviews. Found several clauses that would have cost us significantly. Great lawyer!',
        rating: 5,
      ),
      Review(
        reviewerName: 'Sara Okafor',
        comment:
            'Professional and prompt. Always answered my questions clearly. Highly recommend for any corporate matter.',
        rating: 4,
      ),
    ],
  ),
  Lawyer(
    title: 'Dr.',
    fullName: 'Elena Marchetti',
    specialty: 'Criminal Defense Attorney',
    firm: 'Marchetti Law Group',
    location: 'Milan, Italy',
    profileImageUrl:
        'https://images.unsplash.com/photo-1551836022-deb4988cc6c0?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80',
    clientsCount: 2800,
    yearsExperience: 12,
    rating: 4.7,
    reviewsCount: 2600,
    about:
        'Dr. Elena Marchetti is a renowned criminal defense attorney known for her sharp analytical skills and courtroom presence. She has successfully defended clients in over 300 criminal cases across Italy and Europe.',
    workingDays: 'Monday - Friday',
    workingHours: '10:00 AM - 20:00 PM',
    recentReviews: [
      Review(
        reviewerName: 'Lucas Bianchi',
        comment:
            'Dr. Marchetti took my case when no one else would. She built an airtight defense and got the charges dropped.',
        rating: 5,
      ),
      Review(
        reviewerName: 'Fatima Al-Hassan',
        comment:
            'Incredible lawyer. Very strategic and fought hard for me. I would not have won without her expertise.',
        rating: 5,
      ),
    ],
  ),
  Lawyer(
    title: 'Mr.',
    fullName: 'David Okonkwo',
    specialty: 'Immigration Law Specialist',
    firm: 'Okonkwo Law Firm',
    location: 'Lagos, Nigeria',
    profileImageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=987&q=80',
    clientsCount: 1800,
    yearsExperience: 8,
    rating: 4.6,
    reviewsCount: 1700,
    about:
        'Mr. David Okonkwo is an experienced immigration law specialist helping individuals and businesses navigate complex visa applications, residency permits, and citizenship processes across multiple jurisdictions.',
    workingDays: 'Monday - Saturday',
    workingHours: '09:00 AM - 17:00 PM',
    recentReviews: [
      Review(
        reviewerName: 'Amina Saleh',
        comment:
            'David made my visa process painless. He is knowledgeable, responsive, and genuinely cares about his clients.',
        rating: 5,
      ),
      Review(
        reviewerName: 'Kevin Park',
        comment:
            'Got my work permit sorted quickly thanks to David. Very professional and easy to work with.',
        rating: 4,
      ),
    ],
  ),
];
