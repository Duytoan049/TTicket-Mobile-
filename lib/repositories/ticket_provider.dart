import 'package:flutter/foundation.dart';
import '../model/ticket.dart';
import '../services/ticket_service.dart';

class TicketProvider extends ChangeNotifier {
  final TicketService _ticketService = TicketService();

  List<TicketDetail> _tickets = [];
  TicketDetail? _selectedTicket;
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _reservedSeats = [];

  /// Getters
  List<TicketDetail> get tickets => List.unmodifiable(_tickets);
  TicketDetail? get selectedTicket => _selectedTicket;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get reservedSeats => List.unmodifiable(_reservedSeats);

  /// Thêm vé mới
  Future<void> addTicket(TicketDetail ticket) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newTicket = await _ticketService.addTicket(ticket);
      if (newTicket != null) {
        _tickets.add(newTicket);
      } else {
        _errorMessage = 'Lỗi khi thêm vé!';
      }
    } catch (error) {
      _errorMessage = 'Lỗi: $error';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Lấy tất cả vé
  Future<void> fetchTickets() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedTickets = await _ticketService.getAllTicketsbyUserId();
      if (fetchedTickets.isNotEmpty) {
        _tickets = fetchedTickets;
      } else {
        _errorMessage = 'Danh sách vé trống!';
      }
    } catch (error) {
      _errorMessage = 'Lỗi khi lấy danh sách vé: $error';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Lấy thông tin chi tiết của một vé theo ID
  Future<void> fetchTicketById(String ticketId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final ticket = await _ticketService.getTicketById(ticketId);
      if (ticket != null) {
        _selectedTicket = ticket;
      } else {
        _errorMessage = 'Không tìm thấy vé!';
      }
    } catch (error) {
      _errorMessage = 'Lỗi khi lấy thông tin vé: $error';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// **Lấy danh sách ghế đã đặt**
  Future<void> fetchReservedSeats(int movieId, String date, String time) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final seats = await _ticketService.getReservedSeats(movieId, date, time);

      _reservedSeats = seats; // Cập nhật danh sách ghế đã đặt
      print("Ghế đã đặt: $_reservedSeats"); // In danh sách ghế đã đặt
    } catch (error, stackTrace) {
      _errorMessage = 'Lỗi khi lấy ghế đã đặt: $error';
      _reservedSeats = [];

      print("Lỗi fetchReservedSeats: $error");
      print(stackTrace); // In stack trace để debug nếu cần
    } finally {
      _isLoading = false;
      notifyListeners(); // Thông báo cập nhật UI
    }
  }
}
