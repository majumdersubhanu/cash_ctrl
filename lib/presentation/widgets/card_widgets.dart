import 'package:fit_sync_plus/presentation/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final Color backgroundColour;

  final Color? foregroundColour;

  final String label;

  final IconData icon;

  const InsightCard({
    super.key,
    required this.backgroundColour,
    this.foregroundColour, required this.label, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColour.withAlpha(90),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: backgroundColour.withAlpha(60),
            child: Icon(icon),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                    color: foregroundColour ?? Colors.black, fontSize: 16),
              ),
              LargeColouredSemiBoldHeading(
                label: "₹3200",
                colour: foregroundColour ?? Colors.black,
              ),
            ],
          ),
          const SizedBox(width: 20,)
        ],
      ),
    );
  }
}
