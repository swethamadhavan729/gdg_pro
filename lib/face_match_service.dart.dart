import 'dart:io';
import 'package:image/image.dart' as img;

class FaceMatchService {
  Future<bool> compareImages(String capturedImagePath, String storedImagePath) async {
    final capturedImage = img.decodeImage(File(capturedImagePath).readAsBytesSync());
    final storedImage = img.decodeImage(File(storedImagePath).readAsBytesSync());

    if (capturedImage == null || storedImage == null) return false;

    return capturedImage.width == storedImage.width &&
        capturedImage.height == storedImage.height;
  }
}
