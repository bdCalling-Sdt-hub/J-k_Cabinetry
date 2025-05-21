import '../views/cart_view.dart';

class CartItemModel {
  // final int? id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final bool isAssemblyChecked;
  final double assemblyCost;
  final String productImg;

  CartItemModel({
    // this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.isAssemblyChecked = false,
    this.assemblyCost = 0.0,
    required this.productImg,
  });

  // Convert to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'isAssemblyChecked': isAssemblyChecked ? 1 : 0,
      'assemblyCost': assemblyCost,
      'productImg': productImg,
    };
  }

  // Create CartItemModel from Map
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      // id: map['id'],
      productId: map['productId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      isAssemblyChecked: map['isAssemblyChecked'] == 1,
      assemblyCost: map['assemblyCost'],
      productImg: map['productImg'],
    );
  }

  CartItemModel copyWith({
    String? productId,
    String? name,
    double? price,
    int? quantity,
    bool? isAssemblyChecked,
    double? assemblyCost,
    String? productImg,
  }) {
    return CartItemModel(
      // id: id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isAssemblyChecked: isAssemblyChecked ?? this.isAssemblyChecked,
      assemblyCost: assemblyCost ?? this.assemblyCost,
      productImg: productImg ?? this.productImg,
    );
  }

  // Convert CartItemModel to CartItem for UI
  CartItem toCartItem() {
    return CartItem(
      id: productId,
      name: name,
      price: price,
      quantity: quantity,
      assemblyCost: assemblyCost,
      productImg: productImg,
      isAssemblyChecked: isAssemblyChecked,
    );
  }

  Map<String, dynamic> toUpdateMap() {
    final map = toMap();
    map.remove('id');  // Remove 'id' for update operations
    return map;
  }
}

