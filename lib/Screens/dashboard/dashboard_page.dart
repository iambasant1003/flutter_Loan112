
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardCubit.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Screens/dashboard/dashboard_home.dart';
import 'package:loan112_app/Screens/dashboard/dashboard_status.dart';
import 'package:loan112_app/Utils/Debugprint.dart';
import 'package:loan112_app/Widget/app_bar.dart';
import 'package:loan112_app/Widget/circular_progress.dart';
import 'package:loan112_app/Widget/common_button.dart';
import '../../Constant/FontConstant/FontConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../drawer/drawer_page.dart';

class DashBoardPage extends StatefulWidget{
  const DashBoardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage>{



  int selectedIndex = 0;

  List<Widget> screenList = [
    DashBoardHome(),
    Center(
      child: Text("Status data"),
    )
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
            backgroundColor: ColorConstant.appScreenBackgroundColor,
            body: screenList[selectedIndex],
            bottomNavigationBar: bottomNavigationWidget(context)
        )
    );
  }

  
  
  Widget bottomNavigationWidget(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(bottom: 10,
          left: FontConstants.horizontalPadding,
          right: FontConstants.horizontalPadding
      ),
      child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF2B3C74),
                Color(0xFF5171DA),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(FontConstants.horizontalPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex =0;
                    });
                  },
                  child: Column(
                    children: [
                      Image.asset(
                          ImageConstants.homeIcon,
                          color: selectedIndex ==0? ColorConstant.whiteColor:ColorConstant.greyTextColor,
                          width: 24,height: 24),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: FontConstants.f12,
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontConstants.w500,
                          color: selectedIndex ==0? ColorConstant.whiteColor:ColorConstant.greyTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    // setState(() {
                    //   selectedIndex =1;
                    // });
                    context.push(AppRouterName.dashBoardStatus);
                  },
                  child: Column(
                    children: [
                      Image.asset(ImageConstants.dashboardStatusIcon,
                          color: selectedIndex ==1? ColorConstant.whiteColor:ColorConstant.greyTextColor,
                          width: 24,height: 24),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Status",
                        style: TextStyle(
                            fontSize: FontConstants.f12,
                            fontFamily: FontConstants.fontFamily,
                            fontWeight: FontConstants.w500,
                          color: selectedIndex ==1? ColorConstant.whiteColor:ColorConstant.greyTextColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

}

