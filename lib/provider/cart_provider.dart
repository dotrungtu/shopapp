import 'package:flutter/material.dart';
import 'package:shopapp/model/product_item.dart';

class CardProviderData extends StatefulWidget {
  final Widget child;
  const CardProviderData({
    Key? key,
    required this.child,
  }) : super(key: key);

  static CardProviderDataState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_CardInheritedWidget>())!
        .data;
  }

  @override
  State<CardProviderData> createState() => CardProviderDataState();
}

class CardProviderDataState extends State<CardProviderData> {
  final List<ProductItem> _items = [];
  final List<ProductItem> _selectedItems = [];
  bool isDeleteMode = false;

  List<ProductItem> get cartItems => _items;
  List<ProductItem> get selectedItems => _selectedItems;

  double get totalPrice {
    double total = 0;

    for (var element in _items) {
      total += element.price * element.quantity;
    }
    return total;
  }

  void addToCart(ProductItem orderProduct) {
    setState(() {
      final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
      debugPrint(orderProduct.name);
      if (productIndex < 0) {
        _items.add(orderProduct);
      } else {
        _items[productIndex] =
            orderProduct.copyWith(quantity: _items[productIndex].quantity + 1);
      }
    });
  }

  void degreeProd(ProductItem orderProduct) {
    setState(() {
      final productIndex = _items.indexWhere((e) => e.id == orderProduct.id);
      if (_items[productIndex].quantity > 1) {
        _items[productIndex] =
            orderProduct.copyWith(quantity: _items[productIndex].quantity - 1);
      } else {
        _items.removeAt(productIndex);
      }
    });
  }

  void toggleSelected(ProductItem orderProduct) {
    setState(() {
      final productIndex =
      _selectedItems.indexWhere((e) => e.id == orderProduct.id);
      if (productIndex < 0) {
        _selectedItems.add(orderProduct);
      } else {
        _selectedItems.removeWhere((e) => e.id == orderProduct.id);
      }
    });
  }

  void deleteSelected() {
    setState(() {
      for (var element in _selectedItems) {
        _items.removeWhere((e) => e.id == element.id);
      }
      _selectedItems.clear();
    });
  }

  void undoDelete(List<ProductItem> _oldSelectedItems) {
    setState(() {
      _items.addAll(_oldSelectedItems);
      _selectedItems.addAll(_oldSelectedItems);
    });
  }

  void toggleDeleteMode() {
    setState(() {
      isDeleteMode = !isDeleteMode;
    });
  }

  bool isSelected(ProductItem orderProduct) {
    return _selectedItems.indexWhere((e) => e.id == orderProduct.id) >= 0;
  }

  int get quantity {
    return cartItems.isEmpty
        ? 0
        : cartItems.fold(0, (total, cardItem) => total + cardItem.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return _CardInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _CardInheritedWidget extends InheritedWidget {
  final CardProviderDataState data;

  const _CardInheritedWidget(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
