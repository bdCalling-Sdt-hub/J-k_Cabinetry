import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/data/api_constants.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/controllers/cabinet_detail_controller.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/model/cabinet_parts_model.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/cabinet_description.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/parts_card.dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_cart_floating_button.dart';
import 'package:jk_cabinet/common/widgets/custom_loading.dart';
import 'package:jk_cabinet/common/widgets/header_title_bar.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

import '../../cart/controllers/cart_controller.dart';



class CabinetDetailView extends StatefulWidget {

  const CabinetDetailView({super.key});

  @override
  State<CabinetDetailView> createState() => _CabinetDetailsViewState();
}

class _CabinetDetailsViewState extends State<CabinetDetailView> {
  final CabinetDetailController _cabinetDetailController = Get.put(CabinetDetailController());
  final HomeController homeController = Get.put(HomeController());
  final CartController _cartController = Get.put(CartController());

  BranchData? branchData;

  /// helper function to strip HTML tags
  String _stripHtmlTags(String htmlString) {
    // Replace common HTML entities
    var withoutEntities = htmlString
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"');

    // Replace block-level elements with newlines
    var withLineBreaks = withoutEntities
      .replaceAll(RegExp(r'<(div|p|br|h[1-6])[^>]*>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</(div|p|h[1-6])>', caseSensitive: false), '\n');

    // Remove all remaining HTML tags
    var withoutTags = withLineBreaks.replaceAll(RegExp(r'<[^>]*>'), '');

    // Clean up excessive whitespace
    return withoutTags
      .replaceAll(RegExp(r'\n\s*\n'), '\n\n')
      .trim();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      branchData = await homeController.saveBranchInfo();
      await _cabinetDetailController.fetchCabinetParts();
      await _cabinetDetailController.fetchCabinetDetails();
      final cabinetItem = _cabinetDetailController.cabinetDetailsModel.value.data;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(
        isShowChat: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarContactInfo(branchData: branchData),
              verticalSpacing(16.h),
              Column(
                children: [
                  if (_cabinetDetailController.cabinetDetailsModel.value.data == null)
                    const CustomLoading()
                  else
                  Text(
                    _cabinetDetailController.cabinetDetailsModel.value.data?.code ?? '...',
                    style: AppStyles.h2(color: AppColors.roseTaupeColor, fontWeight: FontWeight.bold),
                  ),

                  if (_cabinetDetailController.cabinetDetailsModel.value.data == null)
                    const CustomLoading()
                  else
                  Image.network(
                    '${ApiConstants.imageBaseUrl}${_cabinetDetailController.cabinetDetailsModel.value.data?.imageUrl}',
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
              SizedBox(height: 15.h),


              /// Product Description
              Html(
                data: _cabinetDetailController
                    .cabinetDetailsModel.value.data?.description ?? 'Description',
                style: {
                  "body": Style(
                    fontSize: FontSize(14),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                },
              ),
              SizedBox(height: 15.h),
              Obx(() {
                List<PartData>? partsData = _cabinetDetailController.cabinetryPartsModel.value.data;
                if (_cabinetDetailController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (partsData == null || partsData.isEmpty) {
                  return const Text('No parts available');
                }
                int globalIndex = 0; // Track global index for quantities
                return Column(
                  children: [
                    ...List.generate(partsData.length, (index) {
                      final partsDataIndex = partsData[index];
                      return Card(
                        color: Colors.grey.shade300,
                        child: ExpansionTile(
                          maintainState: true,
                          title: Text(
                            partsDataIndex.stockItem?.title ?? '',
                            style: AppStyles.h4(fontWeight: FontWeight.bold),
                          ),
                          children: [
                            ...List.generate(partsDataIndex.categoriesWithParts?.length ?? 0, (indexB) {
                              final categoriesWithPartsIndex = partsDataIndex.categoriesWithParts![indexB];
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                    child: HeaderTitleBar(title: categoriesWithPartsIndex.category?.title ?? ''),
                                  ),
                                  Column(
                                    children: List.generate(categoriesWithPartsIndex.parts?.length ?? 0, (indexC) {
                                      final partsIndex = categoriesWithPartsIndex.parts![indexC];
                                      final currentGlobalIndex = globalIndex;
                                      globalIndex++; // Increment global index for the next part
                                      return PartsCard(
                                        cabinetDetailController: _cabinetDetailController,
                                        index: currentGlobalIndex, // Pass global index
                                        itemLength: categoriesWithPartsIndex.parts?.length ?? 0,
                                        parts: partsIndex,
                                      );
                                    }),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: const CustomCartFloatingButton(),
    );
  }
}
