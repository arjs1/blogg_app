import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleHead extends StatelessWidget {
  const TitleHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Write. Share. Inspire.",
          style: GoogleFonts.bebasNeue(
            fontSize: 65,
            color: Theme.of(context).colorScheme.primary,
            height: 0.9,
          ),
        ),
        Text(
          "Where Words Transcend Boundaries, Navigating the Blogging Seas.",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            color: Colors.black,
            fontSize: 15,
          ),
        )
      ],
    );
  }
}
