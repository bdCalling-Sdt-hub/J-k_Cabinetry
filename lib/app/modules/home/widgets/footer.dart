
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Copyright © 2024 J&K Cabinetry CT. All rights reserved."),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.facebook),
              horizontalSpacing(8.w),
              FaIcon(FontAwesomeIcons.instagram),
            ],
          ),
        ],
      ),
    );
  }
}