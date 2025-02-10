import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/controllers/cabinet_detail_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_button.dart';
import 'package:jk_cabinet/common/widgets/header_title_bar.dart';

class QtyAddProductCard extends StatefulWidget {
  final CabinetDetailController? cabinetDetailController;
 final int index;
 final int itemLength;
  const QtyAddProductCard({super.key,this.cabinetDetailController, required this.index, required this.itemLength});

  @override
  State<QtyAddProductCard> createState() => _QtyAddProductCardState();
}

class _QtyAddProductCardState extends State<QtyAddProductCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__){
      widget.cabinetDetailController?.buildItemList(widget.itemLength);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image & Details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "S8/B09",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: 80.h,
                height: 80.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Icon(Icons.image, size: 40.sp, color: Colors.grey),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: (){
                  Get.toNamed(Routes.CABINET_PARTS);
                },
                child: Row(
                  children: [
                    const Text(
                      "View Details -",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.open_in_new, size: 16.sp),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 20.h),
          // Price & Quantity Selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Price : \$120.5",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: (){
                      widget.cabinetDetailController?.decrement(widget.index);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Obx((){
                    return Text(
                      "${widget.cabinetDetailController?.quantity[widget.index]}",
                      style:AppStyles.h3(),
                    );
                  }

                  ),
                  IconButton(
                    onPressed: (){
                      widget.cabinetDetailController?.increment(widget.index);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              CustomButton(
                onTap: (){
                  print(widget.cabinetDetailController?.quantity);

              }, text: 'Add to cart',width: 70.w,),
            ],
          ),
        ],
      ),
    );
  }
}