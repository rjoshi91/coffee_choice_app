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

  @override
  void initState() {
    // TODO: implement initState
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
                itemBuilder: (context, index) {
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
                                    top: 0, bottom: 6, left: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      coffeeOrderListPro
                                          .getCoffeeOrderList[index]
                                          .coffeeTypeName,
                                      style: new TextStyle(
                                          fontSize: 20, color: Colors.brown),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Container(
                                margin: const EdgeInsets.only(top: 6),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.brown,
                                ),
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
                  top: 10,
                  bottom: 15,
                ),
                child: RaisedButton(
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
}
