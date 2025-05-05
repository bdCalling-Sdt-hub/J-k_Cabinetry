import 'package:flutter/material.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class ContactInfo extends StatelessWidget {
  final BranchData branchData;
  const ContactInfo({super.key, required this.branchData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Contact Us",style: AppStyles.h2(),),
          ///address
          Text("${branchData.address}"),
          ///mobile
          Text("${branchData.mobile}"),
          ///Email
          Text("${branchData.email}"),
        ],
      ),
    );
  }
}