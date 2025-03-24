import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/product_model.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Widget/custom_text_field_.dart';
import 'package:store/Core/Widget/empty_widget.dart';
import 'package:store/Core/Widget/product_widget.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/HelpingWidget.dart';
import 'package:store/constans.dart';
import 'package:store/providers/product_provider.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: StreamBuilder<List<ProductModel>>(
          stream: productProvider.fetchProductsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: AppStyles.styleBold16,
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                  child: Text(
                'No product has been added yet',
              ));
            }

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
              child: productList.isEmpty
                  ? EmptyWidget(
                      size: MediaQuery.of(context).size,
                      image: Assets.admin_imagesShoppingCart,
                      title: 'No product found',
                      subtitle: 'Try searching for something else',
                      texButoon: 'Shop Now',
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: searchTextController,
                          onChanged: (value) {
                            // setState(() {
                            //   productListSearch = productProvider.searchQuery(
                            //     searchText: searchTextController.text,
                            //   );
                            // });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productList,
                              );
                            });
                          },
                          hintText: 'Search',
                          prefixIcon: const Icon(IconlyLight.search),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              searchTextController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        if (searchTextController.text.isNotEmpty &&
                            productListSearch.isEmpty) ...[
                          const Center(
                            child: HelpingWidget(),
                          ),
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            crossAxisSpacing: 10,
                            crossAxisCount: 2,
                            itemCount: searchTextController.text.isNotEmpty
                                ? productListSearch.length
                                : productList.length,
                            builder: (context, index) {
                              return ProductWidget(
                                productId: searchTextController.text.isNotEmpty
                                    ? productListSearch[index].productId
                                    : productList[index].productId,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            );
          }),
    );
  }
}
