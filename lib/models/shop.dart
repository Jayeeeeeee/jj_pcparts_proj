import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/models/products.dart';

class Shop extends ChangeNotifier {
  final List<Product> _productMenu = [];
  final List<Product> _cart = [];

  // Getter methods
  List<Product> get productMenu => _productMenu;
  List<Product> get cart => _cart;

  get searchTerm => null;

  // Add to cart
  void addToCart(Product productItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(productItem);
    }
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  // Get quantity of a specific product in the cart
  int getQuantity(Product product) {
    int quantity = 0;
    for (var item in _cart) {
      if (item.id == product.id) {
        quantity++;
      }
    }
    return quantity;
  }

  // Calculate total price
  double calculateTotal() {
    double totalPrice = 0;
    for (var product in _cart) {
      totalPrice += double.parse(product.pprice as String);
    }
    return totalPrice;
  }

  // Clear the cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
