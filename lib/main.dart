import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        /*ChangeNotifierProxyProvider used here to pass data 
        between Auth Provider and ProductsProvider .
        -also Auth() provide must bet top of this provider
        -also we give previosProducts to make sure to lost data when auth re-build
        -this mean when auth state change and re-builld ProductsProvider also will rebuild
        because now ProductsProvider depends on Auth provide
        */
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: (ctx) => ProductsProvider(null, null, []),
          update: (ctx, auth, previosProducts) => ProductsProvider(
            auth.token,
            auth.userId,
            previosProducts == null ? [] : previosProducts.items,

            //old way , now we use setter as below
            //we use .. here to retrun value back into authToken without
            //change returning type that from type ProductsProvider
            //previosProducts..authToken = auth.token,
          ),
        ),
        ChangeNotifierProvider(
          //version before version 3.0.0 use builder insted of create
          create: (ctx) => Cart(),
          //value: ProductsProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(null, []),
            update: (_, auth, previousOrders) => Orders(
                  auth.token,
                  previousOrders == null ? [] : previousOrders.orders,
                )),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            // ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
            ProductDetailScreen.routeNamed: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen()
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
