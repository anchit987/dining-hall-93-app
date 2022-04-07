import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String? productId;
  final String? name;
  final String? imgLink;
  final int? quantity;
  final num? price;

  const CartItem({
    this.productId,
    this.name,
    this.imgLink,
    this.quantity,
    this.price,
  });

  @override
  List<Object?> get props => [
        productId,
        name,
        imgLink,
        quantity,
        price,
      ];
}
