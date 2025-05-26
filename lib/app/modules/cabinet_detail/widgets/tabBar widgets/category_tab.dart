import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/tabBar%20widgets/grid_layout.dart';
import 'package:jk_cabinet/app/modules/cabinetry/widgets/cabinet_card.dart';
import 'package:jk_cabinet/common/widgets/custom_loading.dart';

import '../../../../routes/app_pages.dart';
import '../../../cabinetry/controllers/cabinetry_controller.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../home/model/branch_model.dart';

class JKCategoryTab extends StatefulWidget {
  final String categoryName;
  const JKCategoryTab({super.key, required this.categoryName});

  @override
  State<JKCategoryTab> createState() => _JKCategoryTabState();
}

class _JKCategoryTabState extends State<JKCategoryTab> {

  final HomeController homeController = Get.find<HomeController>();
  final CabinetryController cabinetryController = Get.find<CabinetryController>();

  BranchData? branchData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__) async {
      branchData = await homeController.saveBranchInfo();
      setState(() {});
      print(branchData);
      if (branchData?.sId != null) {
        await cabinetryController.fetchCabinetry(branchData?.sId ?? '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final categories = cabinetryController.cabinetryModel.value.data?.categories ?? [];
      if (cabinetryController.isLoading.value) {
        return const CustomLoading();
      }

      final category = categories.firstWhere((cat)=> cat.categoryName?.toLowerCase() == widget.categoryName.toLowerCase());

      if (category.cabinet == null || category.cabinet!.isEmpty) {
        return const Center(child: Text('No cabinets available in this category'));
      }
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                children: [
                  JKGridLayout(
                    itemCount: category.cabinet?.length ?? 0,
                    itemBuilder: (context, index) {
                      final cabinetItem = category.cabinet![index];
                      final selectedCabinetId = cabinetItem.id;
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.CABINET_DETAIL, arguments: {'cabinetId' : selectedCabinetId});
                        },
                        child: CabinetCard(
                          image: '${ApiConstants.imageBaseUrl}${cabinetItem.imageUrl}',
                          code: cabinetItem.code ?? '',
                          colorName: cabinetItem.colorName ?? '',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}
