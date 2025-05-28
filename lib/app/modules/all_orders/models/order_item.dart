class OrderItem {
  final String orderDate;
  final String orderNumber;
  final double total;
  final String branch;

  OrderItem({
    required this.orderDate,
    required this.orderNumber,
    required this.total,
    required this.branch,
  });

  // Factory constructor for creating OrderItem from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderDate: json['orderDate'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      total: (json['total'] ?? 0.0).toDouble(),
      branch: json['status'] ?? '',
    );
  }

  // Method for converting OrderItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'orderDate': orderDate,
      'orderNumber': orderNumber,
      'total': total,
      'status': branch,
    };
  }
}