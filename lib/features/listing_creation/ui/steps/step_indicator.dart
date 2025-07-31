import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepIndicator({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Step $currentStep of $totalSteps',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2D3363)),
              minHeight: 4,
            ),
          ),
        ),
      ],
    );
  }
} 