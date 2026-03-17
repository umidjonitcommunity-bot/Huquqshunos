// lib/models/lawyer_model.dart

class LawyerModel {
  final String id;
  final String userId;
  final String fullName;
  final String email;
  final String phone;
  final String specialization;
  final int experienceYears;
  final double pricePerConsultation;
  final String aboutMe;
  final String education;
  final String? photoUrl;
  final double rating;
  final int reviewCount;
  final bool isVerified;
  final bool isAvailable;

  LawyerModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.experienceYears,
    required this.pricePerConsultation,
    required this.aboutMe,
    required this.education,
    this.photoUrl,
    required this.rating,
    required this.reviewCount,
    required this.isVerified,
    required this.isAvailable,
  });

  factory LawyerModel.fromMap(Map<String, dynamic> map, String id) {
    return LawyerModel(
      id: id,
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      specialization: map['specialization'] ?? '',
      experienceYears: map['experienceYears'] ?? 0,
      pricePerConsultation: (map['pricePerConsultation'] ?? 0).toDouble(),
      aboutMe: map['aboutMe'] ?? '',
      education: map['education'] ?? '',
      photoUrl: map['photoUrl'],
      rating: (map['rating'] ?? 0.0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
      isVerified: map['isVerified'] ?? false,
      isAvailable: map['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'specialization': specialization,
      'experienceYears': experienceYears,
      'pricePerConsultation': pricePerConsultation,
      'aboutMe': aboutMe,
      'education': education,
      'photoUrl': photoUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'isVerified': isVerified,
      'isAvailable': isAvailable,
    };
  }

  // Sample lawyers for demo
  static List<LawyerModel> get sampleLawyers => [
    LawyerModel(
      id: '1',
      userId: 'u1',
      fullName: 'Alisher Karimov',
      email: 'alisher@example.com',
      phone: '+998901234567',
      specialization: 'civilLaw',
      experienceYears: 8,
      pricePerConsultation: 150000,
      aboutMe: 'Fuqarolik huquqi bo\'yicha tajribali yurist. 200+ muvaffaqiyatli ish.',
      education: 'Toshkent Davlat Yuridik Universiteti',
      photoUrl: null,
      rating: 4.8,
      reviewCount: 124,
      isVerified: true,
      isAvailable: true,
    ),
    LawyerModel(
      id: '2',
      userId: 'u2',
      fullName: 'Malika Yusupova',
      email: 'malika@example.com',
      phone: '+998902345678',
      specialization: 'familyLaw',
      experienceYears: 5,
      pricePerConsultation: 120000,
      aboutMe: 'Oilaviy huquq va ajralish masalalarida mutaxassis.',
      education: 'O\'zbekiston Milliy Universiteti, Huquq fakulteti',
      photoUrl: null,
      rating: 4.9,
      reviewCount: 87,
      isVerified: true,
      isAvailable: true,
    ),
    LawyerModel(
      id: '3',
      userId: 'u3',
      fullName: 'Bobur Toshmatov',
      email: 'bobur@example.com',
      phone: '+998903456789',
      specialization: 'businessLaw',
      experienceYears: 12,
      pricePerConsultation: 250000,
      aboutMe: 'Biznes va korporativ huquq bo\'yicha ekspert. Xalqaro tajriba.',
      education: 'Moskva Davlat Universiteti, Huquq fakulteti',
      photoUrl: null,
      rating: 4.7,
      reviewCount: 203,
      isVerified: true,
      isAvailable: false,
    ),
    LawyerModel(
      id: '4',
      userId: 'u4',
      fullName: 'Nilufar Rashidova',
      email: 'nilufar@example.com',
      phone: '+998904567890',
      specialization: 'laborLaw',
      experienceYears: 6,
      pricePerConsultation: 100000,
      aboutMe: 'Mehnat huquqi, ishga olish va bo\'shatish masalalari.',
      education: 'Toshkent Davlat Yuridik Universiteti',
      photoUrl: null,
      rating: 4.6,
      reviewCount: 56,
      isVerified: true,
      isAvailable: true,
    ),
    LawyerModel(
      id: '5',
      userId: 'u5',
      fullName: 'Jasur Ergashev',
      email: 'jasur@example.com',
      phone: '+998905678901',
      specialization: 'criminalLaw',
      experienceYears: 15,
      pricePerConsultation: 300000,
      aboutMe: 'Jinoyat ishlari bo\'yicha 15 yillik tajriba. Sobiq prokuror.',
      education: 'Toshkent Davlat Yuridik Universiteti, Magistr',
      photoUrl: null,
      rating: 4.9,
      reviewCount: 312,
      isVerified: true,
      isAvailable: true,
    ),
  ];
}
