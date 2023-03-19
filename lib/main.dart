import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo', theme: ThemeData(), home: TextDetection());
  }
}

class TextDetection extends StatefulWidget {
  const TextDetection({super.key});

  @override
  State<TextDetection> createState() => _TextDetectionState();
}

class _TextDetectionState extends State<TextDetection> {
  late final String _imagePath;
  late final TextDetection _textDetector;
  @override
  void initState() {
    // Initializing the text detector

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("hello"),
              ElevatedButton(
                  onPressed: () {
                    var img = pickImageFromGallery();
                    setState(() {});
                  },
                  child: Text("image")),
            
              recognizedList.isEmpty?Container():Expanded(child: ListView.builder(
                itemCount: recognizedList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(recognizedList[index].text.toString()) ;
                },
              ),)
            ],
          ),
        ),
      ),
    );
  }

  final ImagePicker _imagePicker = ImagePicker();
  File? image;
  List<RecognizedText> recognizedList = [];
  pickImageFromGallery() async {
    try {
      final _image = await _imagePicker.pickImage(source: ImageSource.camera);
      final image = _image!.path;

      final inputImage = InputImage.fromFilePath(_image.path);
      final textDetector = GoogleMlKit.vision
          .textRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognisedText =
          await textDetector.processImage(inputImage);

      for (TextBlock block in recognisedText.blocks) {
        print("object");
        print(block.text.toString());
        recognizedList.add(
            RecognizedText(text: block.text, blocks: recognisedText.blocks));
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
    // }
  }
//   dynamic getText(String path) async {
//     final inputImage = InputImage.fromFilePath(path);
//     final textDetector = GoogleMlKit.vision.textRecognizer();
//     final RecognizedText recognisedText =
//         await textDetector.processImage(inputImage);

//     List<RecognizedText> recognizedList = [];

//     for (TextBlock block in recognisedText.blocks) {
//       print(block.text.toString());
//       recognizedList.add(
//           RecognizedText(text: block.text,blocks:recognisedText.blocks));
//     }
// // lines: block.lines, block: block.text.toLowerCase()
//     //return recognizedList;
//   }
}
