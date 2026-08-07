import 'package:flutter/material.dart';
import 'package:desk_flow/models/seat_model.dart';

class Seat extends StatelessWidget {
  final SeatModel seat;

  const Seat({super.key, required this.seat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 65,
        width: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0xFFE9E9E9), width: 0.5),
        ),
        child: Center(
          child: Container(
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: seat.seatStatus == "available"
                  ? const Color(0xFFF2FCF4)
                  : const Color(0xFFFFEEF2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.perm_identity_rounded,
                  color: seat.seatStatus == "available"
                      ? const Color(0xFF6FBB7E)
                      : const Color(0xFFFA476D),
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  seat.seatNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
