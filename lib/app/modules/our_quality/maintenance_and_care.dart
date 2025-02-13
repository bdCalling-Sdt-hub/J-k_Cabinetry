import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';

class MaintenanceAndCare extends StatelessWidget {
  const MaintenanceAndCare({Key? key}) : super(key: key);

  Widget _buildSectionTitle(String title, {Color color = Colors.red}) {
    return Padding(
      padding:  EdgeInsets.only(top: 15.h, bottom: 5.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding:  EdgeInsets.only(left: 10.w, bottom: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            '• ',
            style: TextStyle(fontSize: 14.sp),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBarTitle(),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Title
             Center(
              child: Text(
                'Maintenance & Care',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // General Information Section
            _buildSectionTitle('General Information:'),
            _buildBulletPoint('As a general rule, keep all cabinet surfaces dry at all times.'),
            _buildBulletPoint('Cabinet surfaces shall be dried immediately with a soft, lint-free cotton cloth.'),
            _buildBulletPoint('Avoid using a dish cloth or sponge. Avoid ammonia-based cleaners and soaps with dye. Harsh detergent residues may harm cabinet finishes.'),
            _buildBulletPoint('As with all wood products, quick temperature changes and excessive moisture can be harmful to the cabinet finish and overall cabinet stability.'),

            // Basic Cleaning Section
            _buildSectionTitle('Basic Cleaning:'),
            _buildBulletPoint('To remove dust after installation and for initial cleaning, use a soft, lint-free cotton cloth to wipe down all exterior and interior surfaces.'),
            _buildBulletPoint('For regular basic cleaning, use a soft, lint-free cotton cloth dampened with a mild detergent or soap and warm water.'),
            _buildBulletPoint('For best results, use a blotting action rather than a wiping motion, when cleaning.'),
            _buildBulletPoint('Wipe up food spills and water spots immediately with a lint-free cotton cloth, so moisture is not absorbed into the cabinet surfaces.'),

            // Cleaning of Glass Door Inserts Section
            _buildSectionTitle('Cleaning of Glass Door Inserts:'),
            _buildBulletPoint('Use a household glass cleaner with a soft, clean cloth.'),
            _buildBulletPoint('Apply the glass cleaner directly to the cleaning cloth rather than on the glass or mirror.'),
            _buildBulletPoint('Avoid excess glass cleaner running into the cabinet joints.'),
            _buildBulletPoint('Ammonia should never be used in full strength.'),

            // Basic Care & Things to Avoid Section
            _buildSectionTitle('Basic Care & Things to Avoid:'),
            _buildBulletPoint('When in doubt of a cleaner’s suitability, DO NOT USE.'),
            _buildBulletPoint('Never use scouring pads, steel wool, wire brushes or powdered cleansers.'),
            _buildBulletPoint('Never leave a cloth moistened with cleaner on any cabinet surface for any length of time.'),
            _buildBulletPoint('Check the areas around the sink and dishwasher to make sure that water and detergents do not dry on the cabinet surfaces.'),
            _buildBulletPoint('Avoid draping wet or damp dish towels over doors of the base cabinets.'),
            _buildBulletPoint('Do not attach towel racks to the interior of cabinet doors.'),
            _buildBulletPoint('Avoid placing small kitchen appliances where the heat or steam is directed onto cabinet surfaces.'),
            _buildBulletPoint('Do not leave printed materials (newspapers, magazines, etc.) on the cabinet surfaces, as the printing can bleed into the cabinet finish.'),
          ],
        ),
      ),
    );
  }
}
