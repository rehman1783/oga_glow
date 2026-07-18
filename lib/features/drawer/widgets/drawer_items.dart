import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
      required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
       onTap: () {
    Navigator.of(context).pop();
    onTap();
  },
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                child: icon,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: theme.hintColor,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}