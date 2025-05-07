import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProfileDataContainer extends StatelessWidget {
  void Function()? onPressed;
  final String containerName;
  final String containerData;
  final bool isRequired;
  ProfileDataContainer(
      {super.key,
      required this.containerData,
      required this.containerName,
      this.onPressed,
      required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  containerName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                Text(
                  containerData,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            isRequired
                ? TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "Update",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
