import 'package:flutter/material.dart';
import 'package:jk_cabinet/common/widgets/custom_card.dart';

class TopBarContactInfo extends StatelessWidget {
  const TopBarContactInfo({
    super.key,
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
          const Text(
            "Contact us: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.phone, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          const Text(
            "267 994-6606",
            style: TextStyle(color: Colors.black87),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.email, size: 16, color: Colors.black54),
          const SizedBox(width: 4),
          const Text(
            "sales@jkcabinetryct.com",
            style: TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}