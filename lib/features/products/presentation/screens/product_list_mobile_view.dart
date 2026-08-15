import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../widgets/product_category_tabs.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/product_card_item.dart';

class ProductListMobileView extends ConsumerStatefulWidget {
  const ProductListMobileView({super.key});

  @override
  ConsumerState<ProductListMobileView> createState() => _ProductListMobileViewState();
}

class _ProductListMobileViewState extends ConsumerState<ProductListMobileView> {
  String _selectedCategory = 'All';

  // TODO: replace hardcoded products with productControllerProvider
  // once features/products/data/repositories is implemented.
  static const _products = [
    ProductCardItem(category: 'Electronics', name: 'Quantum Wireless Mouse', price: '\$64.99', stockStatus: ProductStockStatus.inStock),
    ProductCardItem(category: 'Clothing', name: 'Minimalist Leather Backpack', price: '\$120.00', stockStatus: ProductStockStatus.inStock),
    ProductCardItem(category: 'Home', name: 'Smart LED Lamp Pro', price: '\$49.50', stockStatus: ProductStockStatus.lowStock),
    ProductCardItem(category: 'Home', name: 'Ergonomic Office Chair', price: '\$320.00', stockStatus: ProductStockStatus.outOfStock),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeaderBar(title: AppStrings.productsTitle),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductCategoryTabs(
                  selected: _selectedCategory,
                  onChanged: (category) => setState(() => _selectedCategory = category),
                ),
                const SizedBox(height: AppSizes.md),
                ProductSearchBar(
                  onChanged: (query) {
                    // TODO: filter products once productControllerProvider exists
                  },
                  onFilterTap: () {
                    // TODO: open sort/filter options
                  },
                ),
                const SizedBox(height: AppSizes.md),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSizes.sm + AppSizes.xs,
                  mainAxisSpacing: AppSizes.sm + AppSizes.xs,
                  childAspectRatio: 0.68,
                  children: _products,
                ),
                const SizedBox(height: AppSizes.md),
                const Center(
                  child: Text(
                    'Showing 4 of 124 products',
                    style: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}