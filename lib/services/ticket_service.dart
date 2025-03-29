import 'package:ct312h_project/model/ticket.dart';
import 'package:ct312h_project/services/pocketbase_client.dart';
import 'dart:convert';

class TicketService {
  Future<TicketDetail?> addTicket(TicketDetail ticket) async {
    try {
      final pb = await getPocketbaseInstance();
      final userId = pb.authStore.record!.id;

      final createdTicket = await pb.collection('detail_tickets').create(
        body: {
          ...ticket.toJson(),
          'userId': userId,
        },
      );

      return ticket.copyWith(id: createdTicket.id);
    } catch (error) {
      return null;
    }
  }

  // Future<List<TicketDetail>> getAllTicketsbyUserId() async {
  //   try {
  //     final pb = await getPocketbaseInstance();
  //     final userId = pb.authStore.record!.id;

  //     final records = await pb.collection('detail_tickets').getFullList(
  //           filter: "userId = '$userId'", // Lọc theo userId
  //           sort: "-created", // Sắp xếp theo thời gian tạo (mới nhất trước)
  //         );

  //     return records.map((record) => TicketDetail.fromJson(record.toJson())).toList();
  //   } catch (error) {
  //     print(error);
  //     return [];
  //   }
  // }
Future<List<TicketDetail>> getAllTicketsbyUserId() async {
    try {
      final pb = await getPocketbaseInstance();
      final userId = pb.authStore.record!.id;

      final query = "userId = '$userId'";
      // print("Gọi API: GET /api/collections/detail_tickets/records?filter=$query&sort=-created");

      final records = await pb.collection('detail_tickets').getFullList(
            filter: query,
            sort: "-created",
          );

      return records.map((record) => TicketDetail.fromJson(record.toJson())).toList();
    } catch (error) {
      print("Lỗi API: $error");
      return [];
    }
  }

  /// Lấy thông tin chi tiết của một vé theo ID
  Future<TicketDetail?> getTicketById(String ticketId) async {
    try {
      final pb = await getPocketbaseInstance();
      final record = await pb.collection('detail_tickets').getOne(ticketId);

      return TicketDetail.fromJson(record.toJson());
    } catch (error) {
      return null;
    }
  }

  Future<List<TicketDetail>> getAllTickets() async {
    try {
      final pb = await getPocketbaseInstance();

      final records = await pb.collection('detail_tickets').getFullList(
            sort: "-created", // Sắp xếp theo thời gian tạo (mới nhất trước)
          );

      return records.map((record) => TicketDetail.fromJson(record.toJson())).toList();
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<List<String>> getReservedSeats(int movieId, String date, String time) async {
    try {
      final pb = await getPocketbaseInstance();
      final records = await pb.collection('detail_tickets').getFullList(
            filter: "movieId = $movieId",
          );

      List<String> reservedSeats = [];

      for (var record in records) {
        if (record.data['date'] == date && record.data['time'] == time) {
          if (record.data['seats'] != null) {
            try {
              var seatsData = record.data['seats'];

              if (seatsData is String) {
                List<dynamic> decodedSeats = jsonDecode(seatsData);
                reservedSeats.addAll(decodedSeats.map((seat) => seat.toString().trim()));
              } else if (seatsData is List) {
                reservedSeats.addAll(seatsData.map((seat) => seat.toString().trim()));
              }
            } catch (e) {
              print("Lỗi khi parse seats: $e");
            }
          }
        }
      }

      return reservedSeats.toSet().toList(); // Xóa trùng lặp
    } catch (error) {
      print("Lỗi lấy ghế đã đặt: $error");
      return [];
    }
  }
}
