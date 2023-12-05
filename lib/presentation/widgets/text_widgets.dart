import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeHeading extends StatelessWidget {
  final String label;

  const LargeHeading({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MediumSemiBoldHeading extends StatelessWidget {
  final String label;

  const MediumSemiBoldHeading({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      textAlign: TextAlign.start,
    );
  }
}

class LargeColouredBoldHeading extends StatelessWidget {
  final String label;

  final Color? colour;

  const LargeColouredBoldHeading({super.key, required this.label, this.colour});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: colour ?? Colors.grey,
      ),
      textAlign: TextAlign.start,
    );
  }
}
class LargeColouredSemiBoldHeading extends StatelessWidget {
  final String label;

  final Color? colour;

  const LargeColouredSemiBoldHeading({super.key, required this.label, this.colour});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: colour ?? Colors.grey,
      ),
      textAlign: TextAlign.start,
    );
  }
}
