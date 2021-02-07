import 'package:flutter/material.dart';
import 'package:flutter6_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../providers/products.dart';


enum FilterOptions { Favourites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  var _isInit=true;
  var _isLoading=false;
  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); we cant use this becz in initstate .of(context )doesnot work
    //Future.delayed(Duration.zero).then((_) => Provider.of<Products>(context).fetchAndSetProducts()); its a hack so we dont use for fetch data
    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading=false;
        });
      });
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('products'),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favourites)
                    _showOnlyFavourites = true;
                  else
                    _showOnlyFavourites = false;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: //builder is used for the entries for pop menu
                  (_) => [
                        PopupMenuItem(
                          child: Text("only favourites"),
                          value: FilterOptions.Favourites,
                        ),
                        PopupMenuItem(
                          child: Text("Show all"),
                          value: FilterOptions.All,
                        ), //value is responsible for finding out which item has been chosen
                      ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(child:ch,
             value: cart.itemCount.toString(),
                ),
                child: IconButton(icon:Icon(Icons.shopping_cart,),
                onPressed:()=> Navigator.of(context).pushNamed(CartScreen.routeName),),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body:_isLoading?Center(child:CircularProgressIndicator()): ProductGrid(_showOnlyFavourites),
    );
  }
}
