import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPicker {
  late CameraDescription _camera;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  CameraPicker() {
    availableCameras().then((value) {
      _camera = value.first;
      _controller = CameraController(_camera, ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
    });
  }

  Future<XFile?> pickCamera(BuildContext context) async {
    await _initializeControllerFuture;
    var pageRoute = MaterialPageRoute<XFile>(
        builder: (context) => PickCameraUI(_controller));
    XFile? image = await Navigator.push<XFile>(context, pageRoute);
    return image;
  }
}

class PickCameraUI extends StatelessWidget {
  final CameraController _controller;

  const PickCameraUI(this._controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_rounded),
        onPressed: () async {
          XFile? image;
          try {
            image = await _controller.takePicture();
          } catch (e) {
            print(e);
          }
          Navigator.pop(context, image);
        },
      ),
    );
  }
}
