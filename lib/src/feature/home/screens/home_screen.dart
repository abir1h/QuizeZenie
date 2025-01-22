import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _recognizedText = '';
  final picker = ImagePicker();

  // Function to pick an image and perform text recognition
  Future<void> _pickImageAndRecognizeText() async {
    // Pick an image from the gallery
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    // Load the image file
    final InputImage inputImage = InputImage.fromFilePath(pickedFile.path);

    // Initialize Text Recognizer
    final TextRecognizer textRecognizer = GoogleMlKit.vision.textRecognizer();

    // Process the image and get the recognized text
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    setState(() {
      _recognizedText = recognizedText.text;
    });

    // Close the recognizer after use
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google ML Kit - Text Recognition'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickImageAndRecognizeText,
              child: Text('Pick Image and Recognize Text'),
            ),
            SizedBox(height: 20),
            _recognizedText.isEmpty
                ? Text('No text recognized yet.')
                : Text('Recognized Text: $_recognizedText'),
          ],
        ),
      ),
    );
  }
}
