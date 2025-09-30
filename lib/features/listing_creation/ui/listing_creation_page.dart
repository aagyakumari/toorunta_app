import 'package:flutter/material.dart';
import 'package:toorunta_mobile/component/main_scaffold.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/step_indicator.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/basic_info_step.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/details_step.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/location_step.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/photos_step.dart';
import 'package:toorunta_mobile/features/listing_creation/ui/steps/review_step.dart';

enum ListingCreationStep {
  basicInfo,
  details,
  location,
  photos,
  review
}

class ListingCreationPage extends StatefulWidget {
  static const String routeName = '/listing-creation';
  
  const ListingCreationPage({Key? key}) : super(key: key);

  @override
  State<ListingCreationPage> createState() => _ListingCreationPageState();
}

class _ListingCreationPageState extends State<ListingCreationPage> {
  ListingCreationStep _currentStep = ListingCreationStep.basicInfo;

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case ListingCreationStep.basicInfo:
        return BasicInfoStep(
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        );
      case ListingCreationStep.details:
        return DetailsStep(
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        );
      case ListingCreationStep.location:
        return LocationStep(
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        );
      case ListingCreationStep.photos:
        return PhotosStep(
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        );
      case ListingCreationStep.review:
        return ReviewStep(
          onNext: _goToNextStep,
          onBack: _goToPreviousStep,
        );
    }
  }

  void _goToNextStep() {
    setState(() {
      switch (_currentStep) {
        case ListingCreationStep.basicInfo:
          _currentStep = ListingCreationStep.details;
          break;
        case ListingCreationStep.details:
          _currentStep = ListingCreationStep.location;
          break;
        case ListingCreationStep.location:
          _currentStep = ListingCreationStep.photos;
          break;
        case ListingCreationStep.photos:
          _currentStep = ListingCreationStep.review;
          break;
        case ListingCreationStep.review:
          // Handle submission
          Navigator.pop(context);
          break;
      }
    });
  }

  void _goToPreviousStep() {
    setState(() {
      switch (_currentStep) {
        case ListingCreationStep.basicInfo:
          Navigator.pop(context);
          break;
        case ListingCreationStep.details:
          _currentStep = ListingCreationStep.basicInfo;
          break;
        case ListingCreationStep.location:
          _currentStep = ListingCreationStep.details;
          break;
        case ListingCreationStep.photos:
          _currentStep = ListingCreationStep.location;
          break;
        case ListingCreationStep.review:
          _currentStep = ListingCreationStep.photos;
          break;
      }
    });
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case ListingCreationStep.basicInfo:
        return 'Basic Info';
      case ListingCreationStep.details:
        return 'Details';
      case ListingCreationStep.location:
        return 'Location';
      case ListingCreationStep.photos:
        return 'Photos';
      case ListingCreationStep.review:
        return 'Review';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final indicatorSize = screenWidth * 0.06; // 6% of screen width
    final fontSize = screenWidth * 0.03; // 3% of screen width, capped
    
    return MainScaffold(
      currentIndex: 1, // Listings tab
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, // 4% of screen width
                  vertical: 12
                ),
                child: Row(
                  children: List.generate(5, (index) {
                    bool isActive = index == _currentStep.index;
                    bool isPast = index < _currentStep.index;
                    return Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: indicatorSize,
                            height: indicatorSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? const Color(0xFFFFA500)
                                  : isPast
                                      ? Colors.grey[400]
                                      : Colors.grey[300],
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: isActive || isPast ? Colors.white : Colors.grey[600],
                                  fontSize: fontSize.clamp(10, 14), // Clamp between 10 and 14
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (index < 4)
                            Expanded(
                              child: Container(
                                height: 1,
                                color: isPast ? Colors.grey[400] : Colors.grey[300],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: _buildCurrentStep(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 