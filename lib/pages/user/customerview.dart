import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jj_pcparts_proj/models/products.dart';
import 'package:jj_pcparts_proj/utils/constants/colors.dart';
import 'package:jj_pcparts_proj/pages/user/product_details.dart';
import 'package:jj_pcparts_proj/utils/constants/image_strings.dart';

class CustomerView extends StatefulWidget {
  const CustomerView({super.key});

  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class CustomIcon extends StatelessWidget {
  final String imagePath;
  final double size;

  const CustomIcon({super.key, required this.imagePath, required this.size});

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(imagePath),
      size: size,
    );
  }
}

class _CustomerViewState extends State<CustomerView> {
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController _searchController = TextEditingController();

  Widget buildList(Product product) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: product),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: JJColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.imageUrl,
                  height: 100,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.pname,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: JJColors.black),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating,
                                style: const TextStyle(
                                  color: JJColors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₱ ${product.pprice}',
                        style: const TextStyle(color: JJColors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildCategory(
      String categoryName, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 67,
        height: 67,
        margin: const EdgeInsets.all(18),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: JJColors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: JJColors.black),
          ],
        ),
      ),
    );
  }

  void navigateToCategoryPage(List<Product> categoryProducts) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(categoryProducts: categoryProducts),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JJColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: JJColors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                JJImages.appLogo,
                height: 50,
              ),
              const SizedBox(width: 5),
              const Text(
                'JJ PC Parts',
                style: TextStyle(
                    color: JJColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(Icons.shopping_cart, color: JJColors.white),
          ),
        ],
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Product',
                    hintStyle: const TextStyle(color: JJColors.darkerGrey),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: const Icon(Icons.search),
                      color: Colors.grey[800],
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: JJColors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: JJColors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person_4_outlined,
                    color: JJColors.black,
                    size: 30,
                  ),
                  Text(
                    user.email!,
                    style: const TextStyle(
                      color: JJColors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 19, color: Colors.red),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  // Navigate to the login or home page as needed
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final products = snapshot.data;

            final filteredProducts = products
                ?.where((p) =>
                    p.pname.toLowerCase().contains(_searchController.text))
                .toList();

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildCategory("Peripherals", Icons.keyboard, () {
                      final peripherals = filteredProducts
                          ?.where(
                              (product) => product.pcategory == 'Peripherals')
                          .toList();
                      navigateToCategoryPage(peripherals!);
                    }),
                    buildCategory("Monitor", Icons.monitor_rounded, () {
                      final monitor = filteredProducts
                          ?.where((product) => product.pcategory == 'Monitor')
                          .toList();
                      navigateToCategoryPage(monitor!);
                    }),
                    buildCategory("PC Case", Icons.devices_other, () {
                      final pcCase = filteredProducts
                          ?.where((product) => product.pcategory == 'PC Case')
                          .toList();
                      navigateToCategoryPage(pcCase!);
                    }),
                    buildCategory("Graphics Card", Icons.graphic_eq, () {
                      final gpu = filteredProducts
                          ?.where(
                              (product) => product.pcategory == 'Graphics Card')
                          .toList();
                      navigateToCategoryPage(gpu!);
                    }),
                    buildCategory("Power Supply Unit", Icons.power, () {
                      final psu = filteredProducts
                          ?.where((product) =>
                              product.pcategory == 'Power Supply Unit')
                          .toList();
                      navigateToCategoryPage(psu!);
                    }),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: JJColors.grey,
                    ),
                    padding: const EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      itemCount: (filteredProducts!.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final startIndex = index * 2;
                        final endIndex = (index + 1) * 2;

                        final rowProducts = filteredProducts.sublist(
                          startIndex,
                          endIndex.clamp(0, filteredProducts.length),
                        );

                        return Row(
                          children: rowProducts
                              .map((product) => Expanded(
                                    child: buildList(product),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await FirebaseFirestore.instance.collection('Product').get();
  return response.docs.map((doc) => Product.fromJson(doc.data())).toList();
}

class CategoryPage extends StatelessWidget {
  final List<Product> categoryProducts;

  const CategoryPage({super.key, required this.categoryProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: JJColors.white,
      ),
      body: ListView.builder(
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: JJColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: JJColors.primary),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.imageUrl,
                      height: 100,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.pname,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: JJColors.black),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    product.rating,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₱ ${product.pprice}',
                            style: const TextStyle(color: JJColors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
