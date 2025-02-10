import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jk_cabinet/app/modules/cabinet_parts/controllers/cabinet_parts_controller.dart';
import 'package:jk_cabinet/app/modules/cabinet_parts/controllers/recently_viewed_controller.dart';
import 'package:jk_cabinet/app/modules/cabinet_parts/widgets/recently_viewed.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class CabinetPartsView extends StatefulWidget {
  @override
  _CabinetPartsViewState createState() => _CabinetPartsViewState();
}

class _CabinetPartsViewState extends State<CabinetPartsView> {
 final CabinetPartsController _cabinetPartsController=Get.put(CabinetPartsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarTitle(text: 'Sink & Vanity Bases',),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Main Product Image
              Center(
                child: Obx((){
                  if(_cabinetPartsController.selectedImageIndex.value<0){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return  GestureDetector(
                    onTap: (){
                      showImageDialog(context, _cabinetPartsController.selectedImageIndex.value);
                    },
                    child: Container(
                      width: 180.w,
                      height: 180.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Image.network(
                          _cabinetPartsController.productImages[_cabinetPartsController.selectedImageIndex.value],
                          fit: BoxFit.contain,
                      )
                    ),
                  );
                }
                ),
              ),
              SizedBox(height: 12.h),

              /// Thumbnail Selector
              Obx((){
                if(_cabinetPartsController.productImages.isEmpty){
                  return  Container(
                    margin:  EdgeInsets.symmetric(horizontal: 4.w),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:  Colors.grey,
                      ),
                    ),
                    child: const Center(child: Icon(Icons.image)),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_cabinetPartsController.productImages.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _cabinetPartsController.selectedImageIndex.value = index;
                        });
                      },
                      child: Container(
                        margin:  EdgeInsets.symmetric(horizontal: 4.w),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _cabinetPartsController.selectedImageIndex.value == index ? AppColors.primaryColor : Colors.grey,
                          ),
                        ),
                        child: Image.network(_cabinetPartsController.productImages[index], fit: BoxFit.contain),
                      ),
                    );
                  }),
                );
              }

              ),
               SizedBox(height: 8.h),

              /// Product Category
              Text(
                "Drawers",
                style: AppStyles.h4(color: AppColors.primaryColor),
              ),
               SizedBox(height: 4.h),

              /// Product Title
              const Text(
                "S8/B09",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
               SizedBox(height: 4.h),

              /// Product Description
              const Text(
                "BASE CABINET 1 DRAWER, 1 DOOR, 1 SHELF - 9” WIDE X 24” DEEP X 34.5” HIGH",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
               SizedBox(height: 8.h),

              /// Product Price
               Obx((){
                 return Text(
                   "Price : \$${120.5 * _cabinetPartsController.quantity.value}",
                   style: AppStyles.h2(color: AppColors.primaryColor),
                 );
               }

               ),
               SizedBox(height: 12.h),

              /// Quantity Selector & Add to Cart Button
              Row(
                children: [
                  /// Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        onPressed: _cabinetPartsController.decrement,
                        icon: const Icon(Icons.remove),
                      ),
                      Obx((){
                        return Text(
                          "${_cabinetPartsController.quantity}",
                          style: AppStyles.h3(),
                        );
                      }

                      ),
                      IconButton(
                        onPressed: _cabinetPartsController.increment,
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  /// Add to Cart Button
                   SizedBox(width: 20.w),
                  CustomButton(onTap: (){}, text: 'Add to cart',width: 70.w,),
                ],
              ),
              verticalSpacing(12.h),
              Divider(color: Colors.grey.shade400,),
              RecentlyViewed()
            ],
          ),
        ),
      ),
    );
  }
 void showImageDialog(BuildContext context, int imageIndex) {
   showDialog(
     context: context,
     builder: (context) {
       return AlertDialog(
         //backgroundColor: Colors.transparent,
         title: Image.network( _cabinetPartsController.productImages[imageIndex]),
         actions: [
           TextButton(
             onPressed: () {
               Navigator.pop(context); // Close dialog
             },
             child: const Text("Close"),
           ),
         ],
       );
     }
   );
 }

}




