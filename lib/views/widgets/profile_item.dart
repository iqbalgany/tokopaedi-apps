import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String text;
  final IconData icon;
  final IconData? trailingIcon;

  const ProfileItem({
    super.key,
    required this.title,
    required this.text,
    required this.icon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 54,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Icon(
                  trailingIcon,
                  color: Colors.green,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
