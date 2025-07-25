
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loan112_app/Constant/ColorConst/ColorConstant.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardCubit.dart';
import 'package:loan112_app/Cubit/dashboard_cubit/DashboardState.dart';
import 'package:loan112_app/Routes/app_router_name.dart';
import 'package:loan112_app/Utils/snackbarMassage.dart';
import '../../Constant/FontConstant/FontConstant.dart';
import '../../Constant/ImageConstant/ImageConstants.dart';
import '../../Utils/Debugprint.dart';
import '../../Widget/app_bar.dart';
import '../drawer/drawer_page.dart';
import 'dashboard_home.dart';

class DashBoardPage extends StatefulWidget{
  const DashBoardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage>{



  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          return false;
        },
        child: Scaffold(
            backgroundColor: ColorConstant.appScreenBackgroundColor,
            drawer: Loan112Drawer(
              dashBoarddataModel: context.read<DashboardCubit>().state is DashBoardSuccess
                  ? (context.read<DashboardCubit>().state as DashBoardSuccess).dashBoardModel
                  : null,
            ),
            appBar: Loan112AppBar(
              leadingSpacing: 25,
              title: Image.asset(
                ImageConstants.loan112AppNameIcon,
                height: 76,
                width: 76,
              ),
              customLeading: Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: ColorConstant.greyTextColor,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      DebugPrint.prt("Headphone is tapped");
                    },
                    child: Image.asset(
                      ImageConstants.dashBoardHeadphone,
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
              ],
            ),
            body: DashBoardHome(),
            bottomNavigationBar: bottomNavigationWidget(context)
        )
    );
  }



  Widget bottomNavigationWidget(BuildContext context){
    return BlocBuilder<DashboardCubit,DashboardState>(
      builder: (context,state){
        if(state is DashBoardSuccess){
          return SafeArea(
            bottom: true,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 10.0,
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
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (!context.mounted) return; // this is more precise in newer Flutter
                              if(state.dashBoardModel.data?.applicationSubmitted ==1){
                                context.push(AppRouterName.dashBoardStatus);
                              }else{
                                openSnackBar(context, "Loan application is not completed");
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Image.asset(ImageConstants.dashboardStatusIcon,
                                  color: state.dashBoardModel.data?.applicationSubmitted ==1? ColorConstant.whiteColor:ColorConstant.greyTextColor,
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
                                  color: state.dashBoardModel.data?.applicationSubmitted ==1? ColorConstant.whiteColor:ColorConstant.greyTextColor,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

}

