import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/tabBar%20widgets/category_tab.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/tabBar%20widgets/tab_bar.dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/common/widgets/custom_loading.dart';
import '../../../../common/app_drawer/app_drawer.dart';
import '../../bottom_menu/bottom_menu..dart';
import '../../cabinetry/controllers/cabinetry_controller.dart';

import '../../home/model/branch_model.dart';

class CabinetDetailTabBarView extends StatefulWidget {
  const CabinetDetailTabBarView({super.key});

  @override
  State<CabinetDetailTabBarView> createState() => _CabinetDetailTabBarViewState();
}

class _CabinetDetailTabBarViewState extends State<CabinetDetailTabBarView> {
  final HomeController homeController = Get.put(HomeController());
  final CabinetryController cabinetryController = Get.put(CabinetryController());

  BranchData? branchData;

  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
        branchData = await homeController.saveBranchInfo();
        // print("========print ---- ${branchData}");

        setState(() {});

        if (branchData?.sId != null) {
          await cabinetryController.fetchCabinetry(branchData?.sId ?? '');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Obx((){
      if (cabinetryController.isLoading.value) {
        return const CustomLoading();
      }
      final categories = cabinetryController.cabinetryModel.value.data?.categories ?? [];
      return DefaultTabController(
        
        length: categories.length,
        child: Scaffold(
          bottomNavigationBar: const BottomMenu(1),
          appBar: AppBar(
            title: Text('JK Cabinetry'),
             centerTitle: true,
             bottom: JKTabBar(
               tabs: categories.map((category) {
            return Tab(child: Container(
              height: 40,
                color: Colors.blue,
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.h,horizontal: 4.w),
                  child: Text(category.categoryName ?? 'Unknown',style: TextStyle(color: Colors.white),),
                )),);
          }).toList(),
             ),
          ),
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              TabBarView(
                  children: categories.map((category){
                    return JKCategoryTab(categoryName: category.categoryName ?? '');
                  }).toList()

              ),
              Text('hhhhhh')
            ],
          ),
        ),
      );

    });
  }
}
