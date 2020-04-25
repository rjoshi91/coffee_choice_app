import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeechoiceapp/model/coffeeOrder.dart';
import 'package:coffeechoiceapp/model/coffeeType.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:coffeechoiceapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditCoffeePreference extends StatefulWidget {
  String coffeeTypeNameSelected;
  int coffeeTypePriceSelected;
  String coffeeTypeImageSelected;

  EditCoffeePreference(
      {this.coffeeTypeNameSelected,
      this.coffeeTypePriceSelected,
      this.coffeeTypeImageSelected});

  @override
  _EditCoffeePreferenceState createState() => _EditCoffeePreferenceState();
}

class _EditCoffeePreferenceState extends State<EditCoffeePreference> {
  final AuthService _auth = AuthService();

  final CoffeeTypeList coffeeTypeList = CoffeeTypeList();
  final CoffeeTypeModel coffeeTypeModel = CoffeeTypeModel();
  final CoffeeOrderList coffeeOrderList = CoffeeOrderList();
  final CoffeeOrderModel coffeeOrderModel = CoffeeOrderModel();

  int finalCoffeeOrderPrice;
  int noOfCoffeeOrdered = 1;
  int creamValidate = 0;
  int sparkleValidate = 0;
  final int extraSparklePrice = 3;
  final int extraCreamPrice = 5;
  int cupSizeValue = 0;
  int coffeeSugarQty = 0;

  @override
  Widget build(BuildContext context) {
    CoffeeOrderList coffeeOrderListPro = Provider.of<CoffeeOrderList>(context);

    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().coffees,
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(right: 50),
            child: Text(
              "Edit Preferences",
              style: new TextStyle(
                fontSize: 18,
                color: Colors.brown,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/HomeScreen');
            },
            color: Colors.brown,
            icon: Icon(Icons.arrow_back_ios),
          ),

          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    child: FittedBox(
                      child: Image.asset(
                        "images/preferencebg.png",
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: FittedBox(
                      child: Image.asset(
                        widget.coffeeTypeImageSelected,
                        fit: BoxFit.fill,
                        width: 90,
                        height: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //Number of Cups Selection List
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 5.0, bottom: 5.0),
                child: ListTile(
                  leading: Container(
                    width: 110,
                    margin: const EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.coffeeTypeNameSelected,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.brown),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.coffeeTypePriceSelected.toString() +
                              " " +
                              "INR",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.brown),
                        ),
                      ],
                    ),
                  ),
                  title: Container(
                    width: 90,
                    margin: const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          noOfCoffeeOrdered.toString(),
                          style:
                              new TextStyle(fontSize: 20, color: Colors.brown),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (noOfCoffeeOrdered >= 2) {
                                noOfCoffeeOrdered--;
                              }
                            });
                          },
                          child: Image.asset(
                            "images/minus_round_button.png",
                            fit: BoxFit.fill,
                            width: 60,
                            height: 40,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (noOfCoffeeOrdered >= 1) {
                                noOfCoffeeOrdered = noOfCoffeeOrdered + 1;
                              }
                            });
                          },
                          child: Image.asset(
                            "images/plus_round_button.png",
                            fit: BoxFit.fill,
                            width: 60,
                            height: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Divider(),

            //Cup Size Selection List
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 5.0, bottom: 5.0),
                child: ListTile(
                  leading: Container(
                    width: 90,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 6,
                      left: 8,
                    ),
                    child: Text(
                      'Size',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 0, left: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              cupSizeValue = 0;
                            });
                          },
                          child: Image.asset(
                            widget.coffeeTypeImageSelected,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              cupSizeValue = 2;
                            });
                          },
                          child: Image.asset(
                            widget.coffeeTypeImageSelected,
                            height: 35,
                            width: 35,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              cupSizeValue = 3;
                            });
                          },
                          child: Image.asset(
                            widget.coffeeTypeImageSelected,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Divider(),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 5.0, bottom: 5.0),
                child: ListTile(
                  leading: Container(
                    width: 90,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 6,
                      left: 8,
                    ),
                    child: Text(
                      'Sugar',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 6, left: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (coffeeSugarQty == 0) {
                                coffeeSugarQty = 0;
                              } else {
                                coffeeSugarQty = 0;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/nosugar.png',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (coffeeSugarQty == 1) {
                                coffeeSugarQty = 1;
                              } else {
                                coffeeSugarQty = 1;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/one_sugar.png',
                            height: 20,
                            width: 20,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (coffeeSugarQty == 2) {
                                coffeeSugarQty = 2;
                              } else {
                                coffeeSugarQty = 2;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/two_sugar.png',
                            height: 33,
                            width: 33,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (coffeeSugarQty == 3) {
                                coffeeSugarQty = 3;
                              } else {
                                coffeeSugarQty = 3;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/three_cubes.png',
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Divider(),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 5.0, bottom: 5.0),
                child: ListTile(
                  leading: Container(
                    width: 90,
                    margin: const EdgeInsets.only(top: 10, bottom: 6, left: 8),
                    child: Text(
                      'Additions',
                      style: new TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Colors.brown),
                    ),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 6, left: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (creamValidate == 0) {
                                creamValidate = 1;
                              } else {
                                creamValidate = 0;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/cream.png',
                            height: 27,
                            width: 27,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (sparkleValidate == 0) {
                                sparkleValidate = 1;
                              } else {
                                sparkleValidate = 0;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/sparkle.png',
                            height: 27,
                            width: 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 8.0, left: 8.0, top: 5.0, bottom: 5.0),
                child: ListTile(
                  leading: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 6, left: 8),
                    child: Text(
                      'Total:',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.brown),
                    ),
                  ),
                  trailing: Container(
                    margin:
                        const EdgeInsets.only(top: 10, bottom: 6, right: 10),
                    child: Text(
                      finalCoffeeOrder(
                            widget.coffeeTypePriceSelected,
                            extraCreamPrice,
                            extraSparklePrice,
                            noOfCoffeeOrdered,
                            creamValidate,
                            sparkleValidate,
                            cupSizeValue,
                          ).toString() +
                          " INR",
                      style: new TextStyle(fontSize: 20, color: Colors.brown),
                    ),
                  ),
                ),
              ),
            ),

            // Add to Cart Button
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(35.0),
                      side: BorderSide(color: Colors.brown)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, right: 100, left: 100, bottom: 15),
                    child: Text('Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  color: Colors.brown,
                  onPressed: () {
                    coffeeOrderListPro.updateCoffeeOrderItem(CoffeeOrderModel(
                      id: coffeeOrderListPro.getCoffeeOrderList
                          .indexOf(coffeeOrderModel, 0),
                      coffeeImage: widget.coffeeTypeImageSelected,
                      coffeeTypeName: widget.coffeeTypeNameSelected,
                      finalCoffeeOrderAmount: finalCoffeeOrder(
                        widget.coffeeTypePriceSelected,
                        extraCreamPrice,
                        extraSparklePrice,
                        noOfCoffeeOrdered,
                        creamValidate,
                        sparkleValidate,
                        cupSizeValue,
                      ),
                      noOfCoffeeOrdered: noOfCoffeeOrdered,
                      cupSize: cupSizeValue,
                      coffeeSugarQty: coffeeSugarQty,
                      creamAddition: creamValidate,
                      sparkleAddition: sparkleValidate,
                      coffeePrice: widget.coffeeTypePriceSelected,
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int finalCoffeeOrder(int cofPrice, int creamPrice, int sparklePrice,
      int noOfCups, int creamValidated, int sparkleValidate, int cupSizeValue) {
    finalCoffeeOrderPrice = ((cofPrice + cupSizeValue) +
            (creamPrice * creamValidated) +
            (sparklePrice * sparkleValidate)) *
        noOfCups;

    return finalCoffeeOrderPrice;
  }
}
