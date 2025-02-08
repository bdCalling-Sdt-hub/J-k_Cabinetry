import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/app/modules/cabinet_detail/widgets/cabinet_description.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_drawer/app_drawer.dart';
import 'package:jk_cabinet/common/app_images/network_image%20.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/search_field.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class CabinetDetailView extends StatefulWidget {

  const CabinetDetailView({super.key});

  @override
  State<CabinetDetailView> createState() => _CabinetDetailsViewState();
}

class _CabinetDetailsViewState extends State<CabinetDetailView> {
  final List<Map<String, String>> cabinetDetails = [
    {
      'title': 'Door Panel',
      'description': '3/4"-thick solid wood; full overlay door.',
    },
    {
      'title': 'Door Hinge',
      'description': '6-way adjustable; soft-close metal; hidden Euro-style.',
    },
    {
      'title': 'Adjustable Shelf',
      'description':
      '5/8"-thick cabinet-grade plywood; clear coat finish on all sides and edges; with metal shelf rests.',
    },
    {
      'title': 'Drawer',
      'description':
      '5/8" thick solid wood on all sides; full extension pull-out; dovetail construction.',
    },
    {
      'title': 'Drawer Glide',
      'description': 'Full extension pull-out; soft-close metal; concealed under-mount.',
    },
    {
      'title': 'Plywood Box',
      'description':
      '5/8"-thick cabinet-grade plywood; clear coat finish on interior sides; matching color finish on exterior sides.',
    },
    {
      'title': 'Metal Bracket',
      'description': 'Corner bracket reinforcements in base cabinets for maximum stability.',
    },
    {
      'title': 'Door Bumper',
      'description':
      'Promote quiet-closing and reduce slamming for maximum durability.',
    },
    {
      'title': 'Butt Doors',
      'description': 'No center stile on any cabinets to allow full access.',
    },
    {
      'title': 'Certifications',
      'description': 'KCMA Certified and CARB2 Compliant.',
    },
    {
      'title': 'Build Quality',
      'description': 'All Solid Wood Construction and Environment Friendly.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarTitle(
        isShowChat: true, chatOnTap: () {}, notificationCount: '40',),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Column(
              children: [
                SearchField(),
                verticalSpacing(12.h),
                Text(
                  'S8 White',
                  style: AppStyles.h2(color: AppColors.roseTaupeColor,fontWeight: FontWeight.bold),
                ),
                Image.network(AppNetworkImage.cabinet2Img, height: 200.h), // Add a local image
                SizedBox(height: 10.h),
              ],
            ),
            SizedBox(height: 15.h),
            const CabinetDescription(title: 'Door Panel', description: '3/4"-thick solid wood; full overlay door.'),
            const CabinetDescription(title: 'Door Hinge', description: '6-way adjustable; soft-close metal; hidden Euro-style.'),
            const CabinetDescription(title: 'Adjustable Shelf', description: '5/8"-thick cabinet-grade plywood; clear coat finish on all sides and edges; with metal shelf rests.'),
            const CabinetDescription(title: 'Drawer', description: '5/8" thick solid wood on all sides; full extension pull-out; dovetail construction.'),
            const CabinetDescription(title: 'Drawer Glide', description: 'Full extension pull-out; soft-close metal; concealed under-mount.'),
            const CabinetDescription(title: 'Plywood Box', description: '5/8"-thick cabinet-grade plywood; clear coat finish on interior sides; matching color finish on exterior sides.'),
            const CabinetDescription(title: 'Metal Bracket', description: 'Corner bracket reinforcements in base cabinets for maximum stability.'),
            const CabinetDescription(title: 'Door Bumper', description: 'Promote quiet-closing and reduce slamming for maximum durability.'),
            const CabinetDescription(title: 'Butt Doors', description: 'No center stile on any cabinets to allow full access.'),
            const CabinetDescription(title: 'Certifications', description: 'KCMA Certified and CARB2 Compliant.'),
            const CabinetDescription(title: 'Build Quality', description: 'All Solid Wood Construction and Environment Friendly.'),
            SizedBox(height: 15.h),
            ...cabinetDetails.map((detail) {
              return Card(
                color: Colors.grey.shade300,
                child: ExpansionTile(
                  title: Text(
                    detail['title']!,
                    style: AppStyles.h4(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(detail['description']!),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

