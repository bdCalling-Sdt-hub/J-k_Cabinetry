import 'package:flutter/material.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text("Contact Us",style: AppStyles.h2(),),
          Text("325 Sub way Milford, CT 06461 United States"),
          Text("267 994-6066"),
          Text("sales@jkcabinetryct.com"),
        ],
      ),
    );
  }
}