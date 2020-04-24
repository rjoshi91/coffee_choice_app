import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeechoiceapp/model/coffeeOrder.dart';
import 'package:coffeechoiceapp/model/coffeeType.dart';
import 'package:coffeechoiceapp/screens/home/editCoffeePreference.dart';
import 'package:coffeechoiceapp/screens/home/orderMenu.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:coffeechoiceapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final AuthService _auth = AuthService();
  final CoffeeTypeList coffeeTypeList = CoffeeTypeList();
  final CoffeeTypeModel coffeeTypeModel = CoffeeTypeModel();
  final CoffeeOrderList coffeeOrderList = CoffeeOrderList();
  final CoffeeOrderModel coffeeOrderModel = CoffeeOrderModel();

  final _rebuildList = GlobalKey<FormState>();

  String coffeeSizeString;
  String coffeeSugarImageString;
  bool coffeeCreamBool;
  bool coffeeSparkleBool;

  @override
  void initState() {
    super.initState();
  }

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
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              "Your Order List",
              style: new TextStyle(fontSize: 20, color: Colors.brown),
            ),
          ),
          leading: IconButton(
            onPressed: () {},
            color: Colors.brown,
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                await _auth.accountSignOut();
                Navigator.of(context).pushReplacementNamed('/LoginScreen');
              },
              color: Colors.brown,
              icon: Icon(Icons.power_settings_new),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: ListView.builder(
                key: _rebuildList,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: coffeeOrderListPro.getCoffeeOrderList.length,
                itemBuilder: (context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCoffeePreference(
                            coffeeTypeNameSelected: coffeeOrderListPro
                                .getCoffeeOrderList[index].coffeeTypeName,
                            coffeeTypePriceSelected: coffeeOrderListPro
                                .getCoffeeOrderList[index].coffeePrice,
                            coffeeTypeImageSelected: coffeeOrderListPro
                                .getCoffeeOrderList[index].coffeeImage,
                          ),
                        ),
                      );
                    },
                    onDoubleTap: () {
                      coffeeOrderListPro.removeItem();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Divider(),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              leading: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                width: MediaQuery.of(context).size.width / 6,
                                child: Image.asset(
                                  coffeeOrderListPro
                                      .getCoffeeOrderList[index].coffeeImage,
                                ),
                              ),
                              title: Container(
                                margin: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 6,
                                  left: 10,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          coffeeOrderListPro
                                              .getCoffeeOrderList[index]
                                              .coffeeTypeName,
                                          style: new TextStyle(
                                              fontSize: 20,
                                              color: Colors.brown),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Image.asset(
                                                coffeeOrderListPro
                                                    .getCoffeeOrderList[index]
                                                    .coffeeImage,
                                                height: 20,
                                                width: 20,
                                              ),
                                              Text(
                                                ": " +
                                                    getCoffeeSize(
                                                        coffeeOrderListPro
                                                            .getCoffeeOrderList[
                                                                index]
                                                            .cupSize),
                                                style: new TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.brown),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Image.asset(
                                                getCoffeeSugarAmount(
                                                    coffeeOrderListPro
                                                        .getCoffeeOrderList[
                                                            index]
                                                        .coffeeSugarQty),
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Visibility(
                                                visible:
                                                    getCoffeeCreamValidation(
                                                        coffeeOrderListPro
                                                            .getCoffeeOrderList[
                                                                index]
                                                            .creamAddition),
                                                child: Image.asset(
                                                  'images/cream.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    getCoffeeCreamValidation(
                                                        coffeeOrderListPro
                                                            .getCoffeeOrderList[
                                                                index]
                                                            .creamAddition),
                                                child: SizedBox(
                                                  width: 10,
                                                ),
                                              ),
                                              Visibility(
                                                visible:
                                                    getCoffeeSparkleValidation(
                                                        coffeeOrderListPro
                                                            .getCoffeeOrderList[
                                                                index]
                                                            .sparkleAddition),
                                                child: Image.asset(
                                                  'images/sparkle.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Qty: " +
                                        coffeeOrderListPro
                                            .getCoffeeOrderList[index]
                                            .noOfCoffeeOrdered
                                            .toString(),
                                    style: new TextStyle(
                                        fontSize: 17, color: Colors.brown),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 15,
                ),
                child: Column(
                  children: <Widget>[
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0),
                          side: BorderSide(color: Colors.brown)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 40, left: 40, bottom: 15),
                        child: Text('Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      color: Colors.brown,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderMenu(
                  coffeeTypeList: coffeeTypeList,
                  coffeeTypeModel: coffeeTypeModel,
                ),
              ),
            );
          },
          label: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 10,
              child: Image.asset('images/macciato.png')),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }

  String getCoffeeSize(int coffeeSize) {
    if (coffeeSize == 0) {
      coffeeSizeString = "S";
    } else if (coffeeSize == 2) {
      coffeeSizeString = "M";
    } else {
      coffeeSizeString = "L";
    }
    return coffeeSizeString;
  }

  String getCoffeeSugarAmount(int coffeeSugarAmount) {
    if (coffeeSugarAmount == 0) {
      coffeeSugarImageString = "images/nosugar.png";
    } else if (coffeeSugarAmount == 1) {
      coffeeSugarImageString = "images/one_sugar.png";
    } else if (coffeeSugarAmount == 2) {
      coffeeSugarImageString = "images/two_sugar.png";
    } else {
      coffeeSugarImageString = "images/three_cubes.png";
    }
    return coffeeSugarImageString;
  }

  bool getCoffeeCreamValidation(int coffeeCream) {
    if (coffeeCream == 1) {
      coffeeCreamBool = true;
    } else {
      coffeeCreamBool = false;
    }
    return coffeeCreamBool;
  }

  bool getCoffeeSparkleValidation(int coffeeSparkle) {
    if (coffeeSparkle == 1) {
      coffeeSparkleBool = true;
    } else {
      coffeeSparkleBool = false;
    }
    return coffeeSparkleBool;
  }
}
