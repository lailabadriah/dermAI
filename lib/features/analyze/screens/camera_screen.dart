import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'image_quality_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = const [];
  bool _isFlashOn = false;
  bool _isInitializing = true;
  double _exposure = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _controller!.initialize();
      await _controller!.setExposureOffset(_exposure);
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (_controller == null) {
      return;
    }

    try {
      _isFlashOn = !_isFlashOn;
      await _controller!.setFlashMode(
        _isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Flash is not available on this device.')),
        );
      }
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    final image = await _controller!.takePicture();
    if (!mounted) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ImageQualityScreen(imagePath: image.path),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera check'),
        actions: [
          IconButton(
            onPressed: _toggleFlash,
            icon: Icon(_isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded),
          ),
        ],
      ),
      body: _isInitializing
          ? const Center(child: CircularProgressIndicator())
          : _controller == null || !_controller!.value.isInitialized
              ? const Center(
                  child: Text('Camera could not be initialized. Please try again.'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          CameraPreview(_controller!),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black87, Colors.transparent],
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Keep your face centered and well lit.',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 12),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Colors.white,
                                      thumbColor: Colors.white,
                                    ),
                                    child: Slider(
                                      min: -2,
                                      max: 2,
                                      value: _exposure,
                                      onChanged: (value) async {
                                        setState(() => _exposure = value);
                                        if (_controller != null) {
                                          await _controller!.setExposureOffset(value);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _takePicture,
                          icon: const Icon(Icons.camera_alt_rounded),
                          label: const Text('Take photo'),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
