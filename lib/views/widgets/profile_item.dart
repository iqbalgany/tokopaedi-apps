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
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 54,
            padding: EdgeInsets.all(16),
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
                SizedBox(width: 12),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
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
