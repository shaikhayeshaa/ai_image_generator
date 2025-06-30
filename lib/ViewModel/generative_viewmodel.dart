import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class GenerativeViewmodel with ChangeNotifier {
  final String apikey = 'sk-RbX8tgNS6mOiT0RZfA3vsFnj5RxB1ID1Yt1jyAS6dN5PcKWq';

  bool isLoading = false;
  Uint8List? generatedImage;

  final StabilityAI _ai = StabilityAI();

  Future<void> generateImage(String prompt, ImageAIStyle ImageAIStyle) async {
    try {
      isLoading = true;
      notifyListeners();

      generatedImage = await _ai.generateImage(
        prompt: prompt,
        imageAIStyle: ImageAIStyle,
        apiKey: apikey,
      );
    } catch (e) {
      print('❌ Error generating image: $e');
      generatedImage = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
