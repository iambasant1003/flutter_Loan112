
//import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Widget/app_bar.dart';


class SelfieCameraPage extends StatefulWidget {
  const SelfieCameraPage({super.key});

  @override
  State<SelfieCameraPage> createState() => _SelfieCameraPageState();
}

class _SelfieCameraPageState extends State<SelfieCameraPage> with WidgetsBindingObserver{
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraReady = false;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkAndInitializeCamera();
  }


  Future<void> _checkAndInitializeCamera() async {
    final cameraPermission = await Permission.camera.status;

    if (cameraPermission.isGranted) {
      // ✅ already granted
      await _initializeCamera();
    } else if (cameraPermission.isDenied) {
      // 👈 ask for permission
      final result = await Permission.camera.request();
      if (result.isGranted) {
        await _initializeCamera();
      } else {
        openAppSettings();
      }
    } else if (cameraPermission.isPermanentlyDenied) {
      // 🚨 user previously denied permanently
      openAppSettings();
    }
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    final frontCamera = cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {
      isCameraReady = true;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // app came back from settings, check permissions
      _initializeCamera();
    }
  }



  Future<void> _takeSelfie(BuildContext context) async {
    if (!_controller!.value.isInitialized) return;

    final directory = await getTemporaryDirectory();
    final filePath = path.join(
      directory.path,
      '${DateTime.now().millisecondsSinceEpoch}.png',
    );

    final file = await _controller!.takePicture();
    await file.saveTo(filePath);
    var data = await file.length();
    DebugPrint.prt("File size before Cropped $data");

    /*
    // Step 1: Crop the image
    final croppedFile = await _cropImage(File(file.path));

    if (croppedFile == null) {
      // User cancelled crop
      return;
    }
     */
    // Step 2: Compress the image
    final compressedPath = path.join(
      directory.path,
      '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
    );

    final compressedBytes = await FlutterImageCompress.compressAndGetFile(
      file.path,
      compressedPath,
      quality: 80,      // adjust quality 0-100
      minWidth: 600,    // resize width if needed
      minHeight: 600,   // resize height if needed
    );

    if (compressedBytes == null) {
      return;
    }

    setState(() {
      imageFile = XFile(compressedBytes.path);
    });
    var dataAfter = await imageFile?.length();
    DebugPrint.prt("File size after Cropped $dataAfter");
    context.replace(AppRouterName.selfieUploadedPage,extra: imageFile?.path);
  }



  /*
  Future<dynamic> _cropImage(File imageFile) async {
    final cropper = ImageCropper();
    final croppedFile = await cropper.cropImage(
      compressQuality: 50,
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarColor: ColorConstant.whiteColor,
          toolbarWidgetColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    return croppedFile;
  }

   */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstants.logInScreenBackGround,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Loan112AppBar(
                    customLeading: InkWell(
                      child: Icon(Icons.arrow_back_ios,color: ColorConstant.blackTextColor),
                      onTap: (){
                        context.pop();
                      },
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              "Selfie Verification",
                              style: TextStyle(
                                  fontSize: FontConstants.f20,
                                  fontWeight: FontConstants.w800,
                                  fontFamily: FontConstants.fontFamily,
                                  color: ColorConstant.blackTextColor
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              "Please keep your face in center to click your perfect photo.",
                              style: TextStyle(
                                  fontSize: FontConstants.f14,
                                  fontWeight: FontConstants.w500,
                                  fontFamily: FontConstants.fontFamily,
                                  color: ColorConstant.dashboardTextColor
                              ),
                            ),
                            SizedBox(
                              height: 56,
                            ),
                            isCameraReady?
                            Center(
                              child: SizedBox(
                                width: 300,
                                height: 300,
                                child: CameraPreview(_controller!),
                              ),
                            ):
                            GestureDetector(
                              onTap: (){
                                openAppSettings();
                              },
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(ImageConstants.selfieImageIcon)
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                "Click your selfie",
                                style: TextStyle(
                                  fontSize: FontConstants.f14,
                                  fontWeight: FontConstants.w700,
                                  fontFamily: FontConstants.fontFamily,
                                  color: ColorConstant.blackTextColor
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: InkWell(
                                onTap: (){
                                  _takeSelfie(context);
                                },
                                child: Container(
                                  width: 80,  // adjust size as needed
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black54, // or any color you like
                                      width: 2.0,           // thickness of border
                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }



}
