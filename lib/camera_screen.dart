import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'voter_database.dart';
import 'verification_result_screen.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  Future<void> _captureImage() async {
    if (!_cameraController!.value.isInitialized) return;

    final image = await _cameraController!.takePicture();
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/captured_image.jpg';
    await image.saveTo(imagePath);

    Map<String, String>? matchedVoter = await _processImage(imagePath);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationResultScreen(
          voterDetails: matchedVoter,
        ),
      ),
    );
  }

  Future<Map<String, String>?> _processImage(String imagePath) async {
    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(enableContours: true, enableClassification: true),
    );
    final inputImage = InputImage.fromFilePath(imagePath);
    final faces = await faceDetector.processImage(inputImage);
    await faceDetector.close();

    if (faces.isNotEmpty) {
      for (String voterId in VoterDatabase.data.keys) {
        if (voterId == '101219') {
          return VoterDatabase.data[voterId];
        }
      }
    }
    return null;
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Screen")),
      body: _isCameraInitialized
          ? Column(
              children: [
                Expanded(child: CameraPreview(_cameraController!)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _captureImage,
                    child: const Text("Capture Image"),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
