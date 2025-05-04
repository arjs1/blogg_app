import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataContainer extends StatelessWidget {
  final String countNumber;
  final String countName;
  const DataContainer({
    super.key,
    required this.countNumber,
    required this.countName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              countNumber,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              countName,
              style: GoogleFonts.poppins(color: Colors.black),
            )
          ],
        )
      ],
    );
  }
}
