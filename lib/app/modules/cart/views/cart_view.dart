import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/bottom_menu/bottom_menu..dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

import '../controllers/cart_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomMenu(2),
      appBar: CustomAppBarTitle(isShowChat: true,chatOnTap: (){},notificationCount: '40',),
      body: const Center(
        child: Text(
          'CartView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
