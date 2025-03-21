import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/cabinet_parts/controllers/recently_viewed_controller.dart';
import 'package:jk_cabinet/app/routes/app_pages.dart';

class RecentlyViewed extends StatelessWidget {
   RecentlyViewed({super.key});
  final RecentlyViewedController recentlyViewedController = Get.put(RecentlyViewedController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title & Clear Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recently viewed",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: recentlyViewedController.clearAll,
                child: const Text(
                  "Clear recently viewed",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
           SizedBox(height: 8.h),

          /// Recently Viewed List
          Obx(() {
            if (recentlyViewedController.recentlyViewed.isEmpty) {
              return const Center(child: Text("No recently viewed items."));
            }
            return GridView.builder(
              shrinkWrap: true,
              itemCount: recentlyViewedController.recentlyViewed.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.CABINET_PARTS_RECENTVIEWED_DETAILS);
                      },
                      child: Container(
                        padding:  EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Jan 21, 2025",
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                             SizedBox(height: 8.h),
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  recentlyViewedController.recentlyViewed[index],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Remove Item Button
                    Positioned(
                      top: 4.h,
                      right: 4.w,
                      child: GestureDetector(
                        onTap: (){
                          recentlyViewedController.removeItem(index);
                        },
                        child: const Icon(Icons.close, size: 20, color: Colors.black54),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }
}