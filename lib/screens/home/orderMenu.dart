import 'package:coffeechoiceapp/model/coffeeType.dart';
import 'package:coffeechoiceapp/screens/home/coffeePreference.dart';
import 'package:coffeechoiceapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffeechoiceapp/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderMenu extends StatelessWidget {

  final AuthService _auth = AuthService();
  final CoffeeTypeList coffeeTypeList;
  final CoffeeTypeModel coffeeTypeModel;

  OrderMenu({Key key, this.coffeeTypeList, this.coffeeTypeModel, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              "Order Menu",
              style: new TextStyle(fontSize: 20, color: Colors.brown),
            ),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/HomeScreen');
            },
            color: Colors.brown,
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: Colors.transparent,
        ),

          body: ListView.builder(
            itemCount: coffeeTypeList.getCoffeeList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CoffeePreference(
                            coffeeTypeNameSelected: coffeeTypeList.getCoffeeList[index].coffeeTypeName,
                            coffeeTypePriceSelected: coffeeTypeList.getCoffeeList[index].coffeePrice,
                            coffeeTypeImageSelected: coffeeTypeList.getCoffeeList[index].coffeeImage,
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
                            height: MediaQuery.of(context).size.height/4,
                            width: MediaQuery.of(context).size.width/6,
                            child: Image.asset(
                                coffeeTypeList.getCoffeeList[index].coffeeImage,
                            ),
                          ),

                          title: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 6, left: 10),
                            child: Text(
                              coffeeTypeList.getCoffeeList[index].coffeeTypeName,
                              style: new TextStyle(
                                  fontSize: 20,
                                  color: Colors.brown
                              ),
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
    );
  }
}
