import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/base_step.dart';

class PhotosStep extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PhotosStep({
    Key? key,
    required this.onNext,
    required this.onBack,
  }) : super(key: key);

  @override
  State<PhotosStep> createState() => _PhotosStepState();
}

class _PhotosStepState extends State<PhotosStep> {
  final List<dynamic> _selectedPhotos = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (kIsWeb) {
          _selectedPhotos.add(image);
        } else {
          _selectedPhotos.add(File(image.path));
        }
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _selectedPhotos.removeAt(index);
    });
  }

  Widget _buildImageWidget(dynamic photo) {
    if (kIsWeb) {
      if (photo is XFile) {
        return FutureBuilder<Uint8List>(
          future: photo.readAsBytes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      }
    } else {
      if (photo is File) {
        return Image.file(
          photo,
          fit: BoxFit.cover,
        );
      }
    }
    return const Center(child: Text('Invalid image'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Media',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: _pickImage,
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Add up to 6 photos. First photo will be your main image.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                if (_selectedPhotos.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: _selectedPhotos.asMap().entries.map((entry) {
                      final index = entry.key;
                      final photo = entry.value;
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _buildImageWidget(photo),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _removePhoto(index),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
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
                  onPressed: widget.onBack,
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
                  onPressed: widget.onNext,
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
} 