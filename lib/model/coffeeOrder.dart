import 'dart:collection';
import 'package:flutter/material.dart';

class CoffeeOrderModel {
  final String coffeeImage;
  final String coffeeTypeName;
  final int coffeePrice;
  final int finalCoffeeOrderPrice;
  final int noOfCoffeeOrdered;
  final int cupSize;
  final int coffeeSugarQty;
  final int creamAddition;
  final int sparkleAddition;

  CoffeeOrderModel({this.coffeeImage, this.coffeeTypeName, this.finalCoffeeOrderPrice,
    this.noOfCoffeeOrdered, this.cupSize, this.coffeeSugarQty, this.creamAddition, this.sparkleAddition, this.coffeePrice});

}

class CoffeeOrderList extends ChangeNotifier {

  int index;

  List<CoffeeOrderModel> _getCoffeeOrderList = [];

  UnmodifiableListView<CoffeeOrderModel> get getCoffeeOrderList => UnmodifiableListView(_getCoffeeOrderList);

  /// Add new order into the OrderList.
  void add(CoffeeOrderModel coffeeOrderModel) {
    _getCoffeeOrderList.add(coffeeOrderModel);
    notifyListeners();
  }

  /// Removes all orders from the OrderList.
  void removeItem() {
    _getCoffeeOrderList.removeAt(index);
    notifyListeners();
  }

}

