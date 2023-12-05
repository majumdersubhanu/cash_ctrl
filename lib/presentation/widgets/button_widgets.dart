import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegularButton extends StatelessWidget {
  final Function()? onTap;

  final String label;

  final Color? backgroundColour;

  final Color? foregroundColour;

  const RegularButton(
      {super.key,
      this.onTap,
      required this.label,
      this.backgroundColour,
      this.foregroundColour});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => true,
      splashFactory: InkSplash.splashFactory,
      enableFeedback: true,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: kElevationToShadow[2],
          shape: BoxShape.rectangle,
          color:
              backgroundColour ?? Theme.of(context).colorScheme.inverseSurface,
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: foregroundColour ??
                  Theme.of(context).colorScheme.onInverseSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class RegularTextButton extends StatelessWidget {
  final String label;

  final Color? foregroundColour;

  final Function()? onTap;

  const RegularTextButton(
      {super.key, required this.label, this.foregroundColour, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => true,
      splashFactory: InkSplash.splashFactory,
      enableFeedback: true,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: foregroundColour ??
                Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
