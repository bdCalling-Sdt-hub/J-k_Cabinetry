import 'package:get/get.dart';
import 'package:jk_cabinet/app/modules/all_orders/models/order_item.dart';

class AllOrdersViewController extends GetxController {
  List<OrderItem> orders = [
    OrderItem(orderDate: '3/25/2022', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 136, branch: 'New York'),
    OrderItem(orderDate: '3/25/2025', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 100, branch: 'New York'),
    OrderItem(orderDate: '3/25/2024', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 361, branch: 'New York'),
    OrderItem(orderDate: '3/25/2023', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 236, branch: 'New York'),
    OrderItem(orderDate: '3/25/2029', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 936, branch: 'New York'),
    OrderItem(orderDate: '3/25/2029', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 362, branch: 'New York'),
    OrderItem(orderDate: '3/24/2026', orderNumber: 'ORD-DKjkejowejJKkjdkfjakj', total: 736, branch: 'New York'),
  ];
}
