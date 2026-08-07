class SeatModel {
  final int? id;
  final String seatNumber;
  late String seatStatus;
  late String user_id;

  SeatModel({
    this.id,
    required this.seatNumber,
    required this.seatStatus,
    required this.user_id,
  });
  Map<String, dynamic> toJson() {
    return {
      'seat_number': seatNumber,
      'seat_status': seatStatus,
      'user_id': user_id,
    };
  }

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    return SeatModel(
      id: json['id'],
      seatNumber: json['seat_number'],
      seatStatus: json['seat_status'],
      user_id: json['user_id'],
    );
  }
}
