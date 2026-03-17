// lib/models/booking_model.dart

enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final String clientId;
  final String lawyerId;
  final String clientName;
  final String lawyerName;
  final DateTime bookingDate;
  final double amount;
  final BookingStatus status;
  final String? notes;
  final bool isPaid;

  BookingModel({
    required this.id,
    required this.clientId,
    required this.lawyerId,
    required this.clientName,
    required this.lawyerName,
    required this.bookingDate,
    required this.amount,
    required this.status,
    this.notes,
    required this.isPaid,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      id: id,
      clientId: map['clientId'] ?? '',
      lawyerId: map['lawyerId'] ?? '',
      clientName: map['clientName'] ?? '',
      lawyerName: map['lawyerName'] ?? '',
      bookingDate: (map['bookingDate'] as dynamic)?.toDate() ?? DateTime.now(),
      amount: (map['amount'] ?? 0).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => BookingStatus.pending,
      ),
      notes: map['notes'],
      isPaid: map['isPaid'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'lawyerId': lawyerId,
      'clientName': clientName,
      'lawyerName': lawyerName,
      'bookingDate': bookingDate,
      'amount': amount,
      'status': status.name,
      'notes': notes,
      'isPaid': isPaid,
    };
  }
}
