import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FiliterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoriteOnly = false;
  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    //if we need listen to true because context not work in initState
    //we can use didChangeDependencies()
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    //also this way will work becuase it will excute sync code and build the class
    //then do this to-do fun
    /*  Future.delayed(Duration.zero).then((_) =>
        Provider.of<ProductsProvider>(context, listen: false)
            .fetchAndSetProduct()); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          PopupMenuButton(
            onSelected: (FiliterOptions selectedValue) {
              setState(() {
                if (selectedValue == FiliterOptions.Favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FiliterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FiliterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            ))
          : ProductsGrid(_showFavoriteOnly),
    );
  }
}
