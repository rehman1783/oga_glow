import 'package:flutter/material.dart';
import 'package:oga_glow/core/constants/order_constants.dart';
import 'tracking_step.dart';

/// A beautiful vertical timeline showing the order tracking progress.
///
/// Renders a list of [TrackingStep] widgets connected by vertical lines.
/// Completed steps are highlighted; future steps appear inactive.
class OrderTimeline extends StatelessWidget {
  final List<TrackingStepModel> steps;

  const OrderTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < steps.length; i++)
          TrackingStep(
            step: steps[i],
            isLast: i == steps.length - 1,
          ),
      ],
    );
  }
}

