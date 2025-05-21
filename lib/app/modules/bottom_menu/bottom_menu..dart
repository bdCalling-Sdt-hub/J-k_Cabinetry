import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_icons/app_icons.dart';
import 'package:jk_cabinet/common/prefs_helper/prefs_helpers.dart';

class BottomMenu extends StatefulWidget {
  final int menuIndex;
  final String? chooseMentorOrMentee;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BottomMenu(this.menuIndex,
      {super.key, this.chooseMentorOrMentee, this.scaffoldKey});

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.menuIndex; // Set initial index
  }

  Future<void> _onItemTapped(int index) async {
    if (_selectedIndex == index) {
      // Prevent unnecessary re-navigation to the same screen
      return;
    }
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to corresponding pages
    switch (index) {
      case 0:
        Get.offAndToNamed(Routes.HOME);
        break;
      case 1:
        // Get.offAndToNamed(Routes.CABINET_DETAIL_TAB_VIEW);
        Get.offAndToNamed(Routes.CABINETRY);
        break;
      case 2:
        Get.offAndToNamed(Routes.CART);
        break;
      case 3:
        final token = await PrefsHelper.getString('sign-in-token');
        if (token.isNotEmpty) {
          Get.toNamed(Routes.PROFILE);
        } else {
          Get.offAndToNamed(Routes.SIGN_IN);
        }
        //Get.offAndToNamed(Routes.SIGN_IN);
        // widget.scaffoldKey?.currentState!.openDrawer();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 87.h,
      child: ClipRRect(
        //borderRadius:BorderRadius.only(topLeft: Radius.circular(40.r),topRight: Radius.circular(40.r) ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          // Set the selected index
          onTap: _onItemTapped,
          // Handle taps on items
          type: BottomNavigationBarType.fixed,
          // Prevents shifting behavior
          backgroundColor: AppColors.primaryColor,
          selectedItemColor: AppColors.white,
          showSelectedLabels: true,
          unselectedItemColor: Colors.white,
          // Inactive item color
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          items: [
            _buildBottomNavItem(AppIcons.home2Icon, 'Home'),
            _buildBottomNavItem(AppIcons.cabinetryIcon, 'Cabinetry'),
            _buildBottomNavItem(AppIcons.shoppingCartIcon, 'Cart'),
            _buildBottomNavItem(AppIcons.profileBoxIcon, 'Profile'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(String iconPath, String label) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconPath,
        height: 28.0.h,
        width: 28.0.w,
        color: Colors.white, // Inactive icon color
      ),
      activeIcon: Container(
        width: 60.w,
        decoration: BoxDecoration(
          color: Colors.teal[50],
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: SvgPicture.asset(
          iconPath,
          height: 30.0.h,
          width: 30.0.w,
          colorFilter:
          const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
          // Active icon color
        ),
      ),
      label: label,
    );
  }
}
