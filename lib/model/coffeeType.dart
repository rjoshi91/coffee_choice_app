import 'package:flutter/material.dart';

class CoffeeTypeModel {
  final String coffeeImage;
  final String coffeeTypeName;
  final int coffeePrice;

  CoffeeTypeModel({this.coffeeImage, this.coffeeTypeName, this.coffeePrice});
}

class CoffeeTypeList {
  
   List<CoffeeTypeModel> getCoffeeList = [

      CoffeeTypeModel(
        coffeeImage: 'images/espresso.png',
        coffeeTypeName: 'Espresso',
        coffeePrice: 36,
      ),

      CoffeeTypeModel(
        coffeeImage: 'images/cappuccino.png',
        coffeeTypeName: 'Cappuccino',
        coffeePrice: 40
      ),

      CoffeeTypeModel(
        coffeeImage: 'images/macciato.png',
        coffeeTypeName: 'Macciato',
        coffeePrice: 42
      ),

      CoffeeTypeModel(
        coffeeImage: 'images/mocha.png',
        coffeeTypeName: 'Mocha',
        coffeePrice: 44
      ),

      CoffeeTypeModel(
        coffeeImage: 'images/latte.png',
        coffeeTypeName: 'Latte',
        coffeePrice: 43
      ),

    ];
  }

