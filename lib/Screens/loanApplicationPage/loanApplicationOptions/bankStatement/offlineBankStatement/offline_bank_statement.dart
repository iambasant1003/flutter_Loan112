


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/FontConstant/FontConstant.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import 'package:loan112_app/Widget/common_textField.dart';
import 'package:widgets_easier/widgets_easier.dart';
import '../../../../../Constant/ColorConst/ColorConstant.dart';
import '../../../../../Constant/ImageConstant/ImageConstants.dart';
import '../../../../../Widget/app_bar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:typed_data';



class FetchOfflineBankStatement extends StatefulWidget{
  const FetchOfflineBankStatement({super.key});

  @override
  State<StatefulWidget> createState() => _FetchOfflineBankStatement();
}

class _FetchOfflineBankStatement extends State<FetchOfflineBankStatement>{


  List<String> bankStatementInstruction = [
    "Maximum 2 MB file size allowed.",
    "Only pdf files allowed.",
    "Provide the latest 3 months' bank statements.",
    "Upload only salaried account bank statement pdf file."
  ];

  bool passWordVisible = false;
  Uint8List? pdfBytes;
  bool needsPassword = false;
  String? passwordError;
  String? fileNamePath;
  String? fileSize;

  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickPdf() async {
    setState(() {
      needsPassword = false;
      passwordError = null;
      pdfBytes = null;
    });

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    DebugPrint.prt("Pdf bytes file choosen ${result?.files.single.bytes}");

    if (result != null && result.files.single.bytes != null) {
      pdfBytes = result.files.single.bytes!;
      fileNamePath = result.files.single.name;
      fileSize = (result.files.single.size / 1024).toStringAsFixed(1);
      _checkPdf();
    }
  }

  void _checkPdf({String? password}) {
    try {
      // Try to load PDF
      final doc = PdfDocument(
        inputBytes: pdfBytes!,
        password: password,
      );
      DebugPrint.prt("Pdf Loaded Successfully");

      // Success — correct password or no password
      openSnackBar(context, 'PDF opened successfully!',backGroundColor: ColorConstant.appThemeColor);
      //doc.dispose();

      setState(() {
        needsPassword = false;
        passwordError = null;
      });
    } catch (e) {
      // Inspect the exception message
      DebugPrint.prt("Exception occurred $e");
      if (e.toString().contains('password')) {
        // Password is required or incorrect
        setState(() {
          needsPassword = true;
          if (password != null && password.isNotEmpty) {
            passwordError = 'Incorrect password';
          } else {
            passwordError = null; // just ask for password
          }
        });
        DebugPrint.prt("Need Password $needsPassword,$passwordError");
      } else {
        // Some other PDF error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open PDF: ${e.toString()}')),
        );
      }
    }
  }






  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            ImageConstants.logInScreenBackGround,
            fit: BoxFit.cover,
          ),
        ),

        /// Form + Button
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Loan112AppBar(
                customLeading: InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: ColorConstant.blackTextColor,
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: FontConstants.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bank Statement",
                        style: TextStyle(
                          fontSize: FontConstants.f20,
                          fontWeight: FontConstants.w800,
                          fontFamily: FontConstants.fontFamily,
                          color: ColorConstant.blackTextColor,
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        "Please provide your latest bank statement.",
                        style: TextStyle(
                          fontSize: FontConstants.f14,
                          fontFamily: FontConstants.fontFamily,
                          fontWeight: FontConstants.w500,
                          color: Color(0xff344054),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: ShapeDecoration(
                          shape: DashedBorder(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstant.appThemeColor
                          ),
                          image: DecorationImage(
                            image: AssetImage(ImageConstants.selectBankStatementCardBackground),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: (fileNamePath != null && fileNamePath != "")?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(ImageConstants.pdfIcon,height: 25,width: 25),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                fileNamePath ?? "",
                                                style: TextStyle(
                                                    fontSize: FontConstants.f14,
                                                    fontFamily: FontConstants.fontFamily,
                                                    fontWeight: FontConstants.w700,
                                                    color: ColorConstant.blackTextColor
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Text(
                                                "$fileSize KB" ?? "",
                                                style: TextStyle(
                                                    fontSize: FontConstants.f12,
                                                    fontFamily: FontConstants.fontFamily,
                                                    fontWeight: FontConstants.w400,
                                                    color: ColorConstant.greyTextColor
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ):
                                Image.asset(ImageConstants.bankStatementUploadIcon,height: 50,width: 50),
                              ),
                              SizedBox(
                                height: 26,
                              ),
                              if (needsPassword) ...[
                                //const SizedBox(height: 8),
                                CommonTextField(
                                    obscureText: passWordVisible,
                                    controller: _passwordController,
                                    hintText: "Enter your Code here",
                                    trailingWidget: Icon(
                                      passWordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    trailingClick: (){
                                      setState(() {
                                        passWordVisible = !passWordVisible;
                                      });
                                    },
                                ),
                                if(needsPassword && passwordError != null)...[
                                  const SizedBox(height: 8),
                                  Text(
                                    passwordError ?? "",
                                    style: TextStyle(
                                      fontSize: FontConstants.f14,
                                      fontFamily: FontConstants.fontFamily,
                                      fontWeight: FontConstants.w500,
                                      color: ColorConstant.errorRedColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ]else...[
                                  const SizedBox(height: 16),
                                ]
                              ],
                              Center(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFF0074CC)),
                                    foregroundColor: const Color(0xFF0074CC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  ),
                                  onPressed: () async {
                                    if(pdfBytes != null){
                                      _checkPdf(password: _passwordController.text.trim());
                                    }else{
                                      _pickPdf();
                                    }
                                  },
                                  child: const Text(
                                    'Select files',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      ListView.builder(
                        itemCount: bankStatementInstruction.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          DebugPrint.prt("with Index List Data ${bankStatementInstruction[index]}");
                          //return Text(bankStatementInstruction[index]);
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 2,
                                    backgroundColor: ColorConstant.errorRedColor,
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded( // ensure text wraps properly
                                    child: Text(
                                      bankStatementInstruction[index],
                                      style: TextStyle(
                                        fontSize: FontConstants.f14,
                                        fontWeight: FontConstants.w500,
                                        fontFamily: FontConstants.fontFamily,
                                        color: ColorConstant.errorRedColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


}

