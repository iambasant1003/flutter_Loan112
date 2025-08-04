

import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../Constant/FontConstant/FontConstant.dart';
import '../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../Cubit/loan_application_cubit/LoanApplicationCubit.dart';
import '../../../../Model/SendPhpOTPModel.dart';
import '../../../../Utils/MysharePrefenceClass.dart';
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

    // 📷 Take picture
    final file = await _controller!.takePicture();
    final filePath = path.join(
      directory.path,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    await file.saveTo(filePath);

    final originalFile = File(filePath);
    final originalSize = await originalFile.length();
    DebugPrint.prt("Original file size: ${originalSize / (1024 * 1024)} MB");

    File finalFile = originalFile;

    // 📏 Check if > 5 MB (5 * 1024 * 1024 bytes)
    if (originalSize > 5 * 1024 * 1024) {
      DebugPrint.prt("File > 5MB, compressing...");

      final compressedPath = path.join(
        directory.path,
        '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
      );

      final compressed = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        compressedPath,
        quality: 80,                 // good balance quality
        autoCorrectionAngle: true,  // fix orientation
      );

      if (compressed != null) {
        finalFile = File(compressed.path);
        final compressedSize = await finalFile.length();
        DebugPrint.prt("Compressed file size: ${compressedSize / (1024 * 1024)} MB");
      } else {
        DebugPrint.prt("Compression failed, using original.");
      }
    } else {
      DebugPrint.prt("File <= 5MB, using original.");
    }

    setState(() {
      imageFile = XFile(finalFile.path);
    });

    context.replace(AppRouterName.selfieUploadedPage, extra: imageFile!.path);
  }


  getCustomerDetailsApiCall() async{
    var otpModel = await MySharedPreferences.getPhpOTPModel();
    SendPhpOTPModel sendPhpOTPModel = SendPhpOTPModel.fromJson(jsonDecode(otpModel));
    context.read<LoanApplicationCubit>().getCustomerDetailsApiCall({
      "cust_profile_id": sendPhpOTPModel.data?.custProfileId
    });
  }

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
                        getCustomerDetailsApiCall();
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
                              child: Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                  border: Border.all(color: Colors.grey.shade300, width: 2), // optional border
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CameraPreview(_controller!),
                                ),
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
                              height: 10.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: FontConstants.horizontalPadding),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Note:-",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: FontConstants.f14,
                                        fontWeight: FontConstants.w500,
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorConstant.dashboardTextColor
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Please remove spectacle & cap before capturing your selfie.",
                                      //textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: FontConstants.f14,
                                          fontWeight: FontConstants.w500,
                                          fontFamily: FontConstants.fontFamily,
                                          color: ColorConstant.dashboardTextColor
                                      ),
                                    ),
                                  )
                                ],
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
