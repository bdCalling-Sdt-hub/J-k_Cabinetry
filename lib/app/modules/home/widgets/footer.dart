import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/common/url_luncher/externer_url_luncher.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class Footer extends StatelessWidget {
  final BranchData branchData;

  const Footer({super.key, required this.branchData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text("Copyright © 2024 J&K Cabinetry CT. All rights reserved."),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    ExternalUrlLauncher.lunchUrl(branchData.fbLink ?? '');
                  },
                  child: const Icon(Icons.facebook)),
              horizontalSpacing(8.w),
              InkWell(
                  onTap: () {
                    ExternalUrlLauncher.lunchUrl(branchData.instaLink ?? '');
                  },
                  child: const FaIcon(FontAwesomeIcons.instagram)),
            ],
          ),
        ],
      ),
    );
  }
}
