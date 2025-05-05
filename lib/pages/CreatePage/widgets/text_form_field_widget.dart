import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String containerName;

  final int? maxLines;
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.containerName,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 18,
      ),
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: containerName,
        labelStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.tertiary,
        border: OutlineInputBorder(),
      ),
    );
  }
}
