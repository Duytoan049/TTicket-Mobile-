import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'movie_backicon.dart';
import '../movie_ticketdetail.dart';
import '../../../repositories/ticket_provider.dart';
import 'package:provider/provider.dart';

class MovieBookingseat extends StatefulWidget {
  final int movieId;
  final DateTime selectedDate;
  final String selectedTime;

  const MovieBookingseat({super.key, required this.movieId, required this.selectedDate, required this.selectedTime});

  @override
  State<MovieBookingseat> createState() => _MovieBookingseatState();
}

class _MovieBookingseatState extends State<MovieBookingseat> {
  final List<String> seats = [
    "A1",
    "A2",
    "A3",
    "A4",
    "A5",
    "A6",
    "A7",
    "B1",
    "B2",
    "B3",
    "B4",
    "B5",
    "B6",
    "B7",
    "C1",
    "C2",
    "C3",
    "C4",
    "C5",
    "C6",
    "C7",
    "D1",
    "D2",
    "D3",
    "D4",
    "D5",
    "D6",
    "D7",
  ];

  final List<String> _selectedSeats = []; // Ghế đã chọn
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TicketProvider>(context, listen: false).fetchReservedSeats(
        widget.movieId,
        DateFormat('yyyy-MM-dd').format(widget.selectedDate),
        widget.selectedTime,
      );
    });
  }

  final int ticketPrice = 50000;
  int getTotalPrice() {
    return _selectedSeats.length * ticketPrice;
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff1A1A1D),
                  Color(0xff131010)
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    'Select Seats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  height: 4,
                  width: widthSize * 0.7,
                  decoration: BoxDecoration(
                    color: const Color(0xffFF6969),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffC73659).withOpacity(0.7),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Lắng nghe dữ liệu từ TicketProvider để lấy danh sách ghế đã đặt
                Consumer<TicketProvider>(
                  builder: (context, ticketProvider, child) {
                    List<String> reservedSeats = ticketProvider.reservedSeats;

                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: seats.map((seat) {
                          bool isSelected = _selectedSeats.contains(seat);
                          bool isReserved = reservedSeats.contains(seat); // Lấy từ API

                          return GestureDetector(
                            onTap: isReserved
                                ? null
                                : () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedSeats.remove(seat);
                                      } else {
                                        _selectedSeats.add(seat);
                                      }
                                    });
                                  },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isReserved
                                    ? const Color(0xffFF6969) // Ghế đã đặt (đỏ)
                                    : isSelected
                                        ? const Color(0xff0CDA8B) // Ghế đang chọn (xanh lá)
                                        : const Color(0xffEAEAEA), // Ghế trống (xám nhạt)
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  seat,
                                  style: TextStyle(
                                    color: isReserved
                                        ? Colors.black
                                        : isSelected
                                            ? Colors.black
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Legend (Chú thích màu)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    List<Color> colors = [
                      const Color(0xffEAEAEA), // Ghế trống
                      const Color(0xffFF6969), // Ghế đã đặt
                      const Color(0xff0CDA8B), // Ghế đã chọn
                    ];
                    List<String> labels = [
                      "Available",
                      "Reserved",
                      "Selected"
                    ];

                    return Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(labels[index], style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 20),
                      ],
                    );
                  }),
                ),

                const SizedBox(height: 100),

                Container(
                  height: 2,
                  width: widthSize * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xff00FF9C),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff00FF9C).withOpacity(0.7),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: widthSize,
                  height: 300,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date: ${DateFormat('dd/MM/yyyy').format(widget.selectedDate)} - "
                              "Time: ${widget.selectedTime} \n",
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Seats: ${_selectedSeats.join(", ")} \n",
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Total: ${NumberFormat("#,###", "vi_VN").format(getTotalPrice())} VND",
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _selectedSeats.isEmpty
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                        transitionDuration: const Duration(milliseconds: 500), // Thời gian hiệu ứng
                                        pageBuilder: (context, animation, secondaryAnimation) => MovieTicketDetail(
                                              movieId: widget.movieId,
                                              selectedDate: widget.selectedDate,
                                              selectedTime: widget.selectedTime,
                                              selectedSeats: _selectedSeats.join(", "),
                                              totalPrice: getTotalPrice(),
                                              ticketPrice: ticketPrice,
                                            ),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          const begin = Offset(1.0, 0.0);
                                          const end = Offset.zero;
                                          const curve = Curves.easeInOut;

                                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                          var offsetAnimation = animation.drive(tween);

                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        }),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor: Color(0xffC73659), // Màu nền
                            foregroundColor: Colors.white, // Màu chữ
                            disabledForegroundColor: Colors.white, // Màu chữ khi bị disable
                            disabledBackgroundColor: Color(0xffC73659).withOpacity(0.6), // Màu nền khi bị disable
                          ),
                          child: const Text(
                            "GET IN",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          NavBack(),
        ],
      ),
    );
  }
}
