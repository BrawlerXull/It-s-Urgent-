import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageInfoTile extends StatelessWidget {
  final String title;
  final String value;

  const ProfilePageInfoTile({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 2.0),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.acme(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.acme(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
