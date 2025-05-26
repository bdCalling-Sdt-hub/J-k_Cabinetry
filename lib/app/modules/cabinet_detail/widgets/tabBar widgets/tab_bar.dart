import 'package:flutter/material.dart';

class JKTabBar extends StatelessWidget implements PreferredSizeWidget {
  const JKTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: ,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: Colors.red,
        labelColor: Colors.red,
        unselectedLabelColor: Colors.blueGrey,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
  // Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
