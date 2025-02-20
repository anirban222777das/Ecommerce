import 'package:blinders/components/my_current_location.dart';
import 'package:blinders/components/my_description_box.dart';
import 'package:blinders/components/my_product_tile.dart';
import 'package:blinders/components/my_silver_app_bar.dart';
import 'package:blinders/components/my_tab_bar.dart';
import 'package:blinders/models/buisness.dart';
import 'package:blinders/models/product.dart';
import 'package:blinders/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:blinders/components/my_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
// tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ProductCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // sort out and return a list of product items that belong to a specific category
  List<Product> _filterMenuByCategory(
      ProductCategory category, List<Product> fullMenu) {
    return fullMenu.where((Product) => Product.category == category).toList();
  }

  // return list of product in given category
  List<Widget> getProductInThisCategory(List<Product> fullMenu) {
    return ProductCategory.values.map((category) {
      // get category menu
      List<Product> categoryMenu = _filterMenuByCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          // get individual product
          final Product = categoryMenu[index];
          // return product tile UI
          return MyProductTile(
            product: Product,
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(product:Product),
             ))
             );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  indent: 25,
                  endIndent: 25,
                  color: Theme.of(context).colorScheme.secondary,
                ),

                // my current location
                const MyCurrentLocation(),

                // description box
                const MyDescriptionBox(),
              ],
            ),
          ),
        ],
        body: Consumer<Buisness>(
          builder: (context, Buisness, child) => TabBarView(
            controller: _tabController,
            children: getProductInThisCategory(Buisness.menu),
          ),
        ),
      ),
    );
  }
}
