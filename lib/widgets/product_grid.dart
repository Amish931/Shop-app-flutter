import 'package:flutter/material.dart';
import 'package:flutter6_shop/providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
class ProductGrid extends StatelessWidget {
  final bool showFavs;
  ProductGrid(this.showFavs);
  
  @override
  Widget build(BuildContext context) {
   final productsData= Provider.of<Products>(context);//angular brackets helps so we can know to which type of data we want to listen
   final products=showFavs ? productsData.favouriteItems: productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) =>    //how every grid cell is going to built
        ChangeNotifierProvider.value(   //create: (ctx)=>products[i],
                  value: products[i],
                  child: ProductItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
        ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(   //grid structure has been defined
        crossAxisCount: 2,                                       //no. of columns that i want 
        childAspectRatio: 3 / 3,                                 //ratio between width and hieght 
        mainAxisSpacing: 10,                              /*space between our rows and columns for 23 and 24*/
        crossAxisSpacing: 10,     
      ),
    );
  }
}
