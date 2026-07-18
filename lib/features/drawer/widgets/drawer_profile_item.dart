import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

class DrawerProfileItem extends StatelessWidget {
  final String title;
  final Icon icon;

  const DrawerProfileItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).pop();
          Get.toNamed(AppRoutes.profile);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(color: theme.colorScheme.primary, size: 24),
                child: icon,
              ),

              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    // fontWeight: FontWeight.w600,
                    letterSpacing: .2,
                  ),
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
