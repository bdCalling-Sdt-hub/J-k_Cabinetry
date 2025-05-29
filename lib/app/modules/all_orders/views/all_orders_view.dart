import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/all_orders/controllers/all_orders_view_controller.dart';

class AllOrdersView extends StatefulWidget {
  const AllOrdersView({super.key});

  @override
  _AllOrdersViewState createState() => _AllOrdersViewState();
}

class _AllOrdersViewState extends State<AllOrdersView> {
  final controller = Get.put(AllOrdersViewController());
  late final List orders;

  @override
  void initState() {
    super.initState();
    orders = controller.orders;
  }

  final TextStyle headerStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.grey[700],
  );

  final TextStyle rowStyle = const TextStyle(
    color: Colors.black87,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length + 1, // +1 for header
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Header row
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text('Order Date', style: headerStyle)),
                          Expanded(flex: 2, child: Text('Order \nNumber', style: headerStyle)),
                          Expanded(flex: 2, child: Text('Total', style: headerStyle)),
                          Expanded(flex: 1, child: Text('Branch', style: headerStyle)),
                        ],
                      ),
                    );
                  }
                  final order = orders[index - 1];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: (index % 2 == 0) ? Colors.white : Colors.grey[50],
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!, width: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text(order.orderDate, style: rowStyle)),
                        Expanded(flex: 2, child: Text(order.orderNumber, style: rowStyle)),
                        Expanded(
                          flex: 2,
                          child: Text('\$${order.total.toStringAsFixed(2)}', style: rowStyle.copyWith(fontWeight: FontWeight.w500)),
                        ),
                        Expanded(flex: 1,child: Text('New York', style: rowStyle)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
