class TicketDetail {
  final String id;
  final int movieId; // 🔄 Đổi thành int
  final String movieTitle;
  final String date;
  final String time;
  final int seatCount;
  final List<String> seats;
  final int ticketPrice;
  final int serviceCharge;
  final int totalPrice;

  TicketDetail({
    required this.id,
    required this.movieId, // 🔄 Cập nhật kiểu dữ liệu
    required this.movieTitle,
    required this.date,
    required this.time,
    required this.seatCount,
    required this.seats,
    required this.ticketPrice,
    required this.serviceCharge,
    required this.totalPrice,
  });

  /// Chuyển từ JSON sang `TicketDetail`
  factory TicketDetail.fromJson(Map<String, dynamic> json) {
    return TicketDetail(
      id: json['id'],
      movieId: json['movieId'] is int ? json['movieId'] : int.parse(json['movieId']), // 🔄 Ép kiểu
      movieTitle: json['movietitle'],
      date: json['date'],
      time: json['time'],
      seatCount: json['seat_count'],
      seats: List<String>.from(json['seats']),
      ticketPrice: json['ticket_price'],
      serviceCharge: json['service_charge'],
      totalPrice: json['total_price'],
    );
  }

  /// Chuyển từ `TicketDetail` sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'movieId': movieId, // 🔄 Giữ kiểu int
      'movietitle': movieTitle,
      'date': date,
      'time': time,
      'seat_count': seatCount,
      'seats': seats,
      'ticket_price': ticketPrice,
      'service_charge': serviceCharge,
      'total_price': totalPrice,
    };
  }

  /// Tạo bản sao với dữ liệu mới
  TicketDetail copyWith({
    String? id,
    int? movieId, // 🔄 Cập nhật kiểu dữ liệu
    String? movieTitle,
    String? date,
    String? time,
    int? seatCount,
    List<String>? seats,
    int? ticketPrice,
    int? serviceCharge,
    int? totalPrice,
  }) {
    return TicketDetail(
      id: id ?? this.id,
      movieId: movieId ?? this.movieId, // 🔄 Cập nhật kiểu dữ liệu
      movieTitle: movieTitle ?? this.movieTitle,
      date: date ?? this.date,
      time: time ?? this.time,
      seatCount: seatCount ?? this.seatCount,
      seats: seats ?? this.seats,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
