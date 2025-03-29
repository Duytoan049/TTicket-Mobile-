import 'package:ct312h_project/pages/movies/widgets/movie_bookingseat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingDate extends StatefulWidget {
  final int movieId;

  const BookingDate({super.key, required this.movieId});

  @override
  State<BookingDate> createState() => _BookingDate();
}

class _BookingDate extends State<BookingDate> {
  int _selectedDateIndex = 0; // Ngày được chọn
  int? _selectedTimeIndex; // Giờ được chọn (có thể null)

  final List<DateTime> _dates = List.generate(7, (index) {
    return DateTime.now().add(Duration(days: index));
  });

  final List<String> _timeSlots = [
    "10:00",
    "01:00",
    "14:00",
    "15:30",
    "17:30",
    "19:30"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              'Select  Date',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Danh sách ngày
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              itemBuilder: (context, index) {
                DateTime date = _dates[index];
                bool isSelected = index == _selectedDateIndex;
      
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateIndex = index;
                      _selectedTimeIndex = null; // Reset giờ khi chọn ngày mới
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                  Color(0xffFF6969),
                                  Color(0xffC73659),
                                ])
                          : null,
                      border: Border.all(color: Color(0xffFF6969), width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E()
                              .format(date), // Hiển thị "Mon", "Tue",...
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat.MMMd()
                              .format(date), // Hiển thị "Oct 01", "Nov 02"...
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      
          const SizedBox(height: 20),
      
          Center(
            child: Text(
              'Time',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 20),
      
          // Danh sách khung giờ
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_timeSlots.length, (index) {
              bool isSelected = index == _selectedTimeIndex;
      
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTimeIndex = index;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(colors: [
                            Color(0xffFF6969),
                            Color(0xffC73659),
                          ])
                        : null,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xffFF6969), width: 1),
                  ),
                  child: Text(
                    _timeSlots[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ),
      
          const SizedBox(height: 20),
      
          // Nút đặt lịch
          ElevatedButton(
            onPressed: _selectedTimeIndex == null
                ? null
                : () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500), // Thời gian hiệu ứng
                        pageBuilder: (context, animation, secondaryAnimation) => MovieBookingseat(
                          selectedDate: _dates[_selectedDateIndex],
                          selectedTime: _timeSlots[_selectedTimeIndex!],
                          movieId: widget.movieId,
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
                          }
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Color(0xffFF6969),
              foregroundColor: Colors.white,
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: Color(0xffFF6969).withOpacity(0.6),
            ),
            child: const Text(
              "RESERVATION",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
      
        ],
      ),
    );
  }
}
