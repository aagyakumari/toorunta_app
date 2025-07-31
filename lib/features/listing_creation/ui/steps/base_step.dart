import 'package:flutter/material.dart';

abstract class BaseStep extends StatelessWidget {
  final VoidCallback onNext;

  const BaseStep({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  Widget buildStepContent(BuildContext context);
  bool isStepValid() => true;
  String getButtonText() => 'Next';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: buildStepContent(context),
            ),
          ),
          const SizedBox(height: 16),
          buildStepButton(context),
        ],
      ),
    );
  }

  Widget buildStepButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isStepValid() ? onNext : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D3363),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          getButtonText(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
} 