import 'package:flutter/material.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';

class TopBarContactInfo extends StatelessWidget {
  final BranchData? branchData;
  const TopBarContactInfo({
    super.key, this.branchData,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: CustomCard(
        elevation: 0,
        borderSideColor: Colors.grey.shade300,
        cardColor: Colors.grey.shade300,
        isRow: true,
        children: [
           Text(
            "Contact us: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.phone, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
           Text("${branchData?.mobile}",
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.email, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
           Text(
            "${branchData?.email}",
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}