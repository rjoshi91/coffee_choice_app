import 'dart:collection';

import 'package:flutter/material.dart';

class CoffeeOrderModel {
  final int id;
  final String coffeeImage;
  final String coffeeTypeName;
  final int coffeePrice;
  final int finalCoffeeOrderAmount;
  int noOfCoffeeOrdered;
  final int cupSize;
  final int coffeeSugarQty;
  final int creamAddition;
  final int sparkleAddition;

  CoffeeOrderModel(
      {this.id,
      this.coffeeImage,
      this.coffeeTypeName,
      this.finalCoffeeOrderAmount,
      this.noOfCoffeeOrdered,
      this.cupSize,
      this.coffeeSugarQty,
      this.creamAddition,
      this.sparkleAddition,
      this.coffeePrice});
}

class CoffeeOrderList extends ChangeNotifier {
  var sum = 0;

  List<CoffeeOrderModel> _getCoffeeOrderList = [];

  UnmodifiableListView<CoffeeOrderModel> get getCoffeeOrderList =>
      UnmodifiableListView(_getCoffeeOrderList);

  /// Add new order into the OrderList.
  void add(CoffeeOrderModel coffeeOrderModel) {
    _getCoffeeOrderList.add(coffeeOrderModel);
    notifyListeners();
  }

  void removeCoffeeOrderItem(CoffeeOrderModel coffeeOrderModel) {
    int index =
        _getCoffeeOrderList.indexWhere((i) => i.id == coffeeOrderModel.id);
    _getCoffeeOrderList[index].noOfCoffeeOrdered = coffeeOrderModel.id;
    _getCoffeeOrderList.removeWhere((item) => item.id == coffeeOrderModel.id);
    finalCoffeeBill();
    notifyListeners();
  }

  void updateCoffeeOrderItem(CoffeeOrderModel coffeeOrderModel) {
    int index =
        _getCoffeeOrderList.indexWhere((i) => i.id == coffeeOrderModel.id);
    _getCoffeeOrderList[index].noOfCoffeeOrdered = coffeeOrderModel.id;
    finalCoffeeBill();
    notifyListeners();
  }

  int finalCoffeeBill() {
    sum = 0;
    _getCoffeeOrderList.forEach((f) {
      sum += f.finalCoffeeOrderAmount;
    });
    return sum;
  }
}
