import 'package:flutter/material.dart';

class ReviewStep extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const ReviewStep({
    Key? key,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Review content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review Your Listing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'Basic Information',
                  {
                    'Title': 'Not set',
                    'Category': 'Not set',
                    'Condition': 'Not set',
                    'Price': 'Not set',
                  },
                  onEdit: () {
                    // Navigate back to Basic Info step
                  },
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'Details',
                  {
                    'Overview': 'Not provided',
                  },
                  onEdit: () {
                    // Navigate back to Details step
                  },
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'Photos',
                  {
                    'Images': '0 photo(s) added',
                  },
                  onEdit: () {
                    // Navigate back to Photos step
                  },
                ),
                const SizedBox(height: 16),
                _buildSection(
                  'Location',
                  {
                    'Auto-detect': 'Disabled',
                  },
                  onEdit: () {
                    // Navigate back to Location step
                  },
                ),
              ],
            ),
          ),
        ),
        // Bottom buttons
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onBack,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE74C3C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D3363),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, Map<String, String> details, {VoidCallback? onEdit}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: onEdit,
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: details.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${entry.key}: ',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
} 