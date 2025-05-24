import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_app/core/constants/assets_app.dart';

import '../data/models/category_model.dart';
import '../widgets/custom_category_list.dart';
import '../widgets/custom_product_card.dart';
import '../widgets/custom_search.dart';
import '../widgets/custom_stylish.dart';
import '../manager/product_cubit/product_cubit.dart';
import '../manager/product_cubit/product_state.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  final List<Category> categories = [
    Category(name: "Men", iconPath: AssetsApp.images.mens.path),
    Category(name: "Women", iconPath: AssetsApp.images.womens.path),
    Category(name: "Kids", iconPath: AssetsApp.images.kids.path),
    Category(name: "Fashion", iconPath: AssetsApp.images.fashion.path),
    Category(name: "Beauty", iconPath: AssetsApp.images.beauty.path),
  ];

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: CustomStylish()),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Search any product',
                hintStyle: TextStyle(
                  color: Color(0xFFBBBBBB),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(Icons.search, color: Color(0xFFBBBBBB)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              onTap: () {
                showSearch(context: context, delegate: CustomSearch());
              },
            ),
            const SizedBox(height: 17),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'All Featured',
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 17),

            // Scrollable Area (Categories + Products)
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategoriesList(categories: categories),
                          const SizedBox(height: 16),
                          const Text(
                            'Products',
                            style: TextStyle(
                              fontFamily: 'montserrat',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return ProductCard(
                                product: product,
                                image: product.image,
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 163 / 305,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  } else if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFF83758),
        child: Icon(Icons.shopping_bag, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFFF83758),
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'Items',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
