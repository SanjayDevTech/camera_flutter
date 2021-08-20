import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_flutter/pick_camera.dart';
import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  HomeContent({Key? key}) : super(key: key);

  final CameraPicker _cameraPicker = CameraPicker();

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  XFile? image;

  Widget _buildImage(XFile? image) {
    var fit = BoxFit.fill;
    if (image != null) {
      return Image.file(
        File(image.path),
        fit: fit,
      );
    }
    return Image.asset(
      'assets/placeholder.png',
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: _buildImage(image),
          height: 200,
        ),
        ElevatedButton(
          onPressed: () async {
            XFile? file = await widget._cameraPicker.pickCamera(context);
            setState(() {
              image = file;
            });
          },
          child: Text('Take picture'),
        )
      ],
    );
  }
}
