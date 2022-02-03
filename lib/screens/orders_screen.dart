import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/error_404_screen.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

/*   // var _isLoading = false;
  // incace use initState method to fetch data or didChangeDependencies we should convert this state to statefullWidget
  // @override
  // void initState() {
  //with listen: false we also can use this method without using Future.delayed
  // Future.delayed(Duration.zero).then((_) async {
  // });
  // _isLoading = true;

  // Provider.of<Orders>(context, listen: false)
  //     .fetchAndSendOrders()
  //     .then((_) => setState(() {
  //           _isLoading = false;
  //         }));

  //   super.initState();
  // } */

/* //also another method to  improve FutureBuilder to stop any re-build intire class
// and also we must use SataefullWidget to use initState
Future ordersFuture;
Future _obtainordersFuture() {
  return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
}
@override
void initState() {
  ordersFuture = _obtainOrdersFuture();
  super.initState();
} */

  @override
  Widget build(BuildContext context) {
    //final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Orders>(context, listen: false)
                .fetchAndSendOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor));
              } else {
                if (dataSnapshot.error != null) {
                  return Error404Screen();
                  // return Center(child: Text('Something went wrong!'));
                } else {
                  return Consumer<Orders>(
                    builder: (ctx, ordersData, child) => ListView.builder(
                      itemCount: ordersData.orders.length,
                      itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
                    ),
                  );
                }
              }
            }));
  }
}
