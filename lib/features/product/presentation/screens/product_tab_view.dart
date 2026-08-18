import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../widgets/product_card_item.dart';
import '../widgets/product_category_tabs.dart';
import '../widgets/product_search_bar.dart';
import '../controllers/product_controller.dart';

class ProductTabView extends ConsumerWidget {
  const ProductTabView({super.key});

  // TODO: replace hardcoded products with productListControllerProvider's
  // fetched data once features/products/data/repositories is implemented.
  static const _products = [
    ProductCardItem(category: 'Electronics', name: 'Quantum Wireless Mouse', price: '\$64.99', stockStatus: ProductStockStatus.inStock),
    ProductCardItem(category: 'Clothing', name: 'Minimalist Leather Backpack', price: '\$120.00', stockStatus: ProductStockStatus.inStock),
    ProductCardItem(category: 'Home', name: 'Smart LED Lamp Pro', price: '\$49.50', stockStatus: ProductStockStatus.lowStock),
    ProductCardItem(category: 'Home', name: 'Ergonomic Office Chair', price: '\$320.00', stockStatus: ProductStockStatus.outOfStock),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(productControllerProvider).selectedCategory;

    return Column(
      children: [
        const AppHeaderBar(title: AppStrings.productsTitle),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductCategoryTabs(
                      selected: selectedCategory,
                      onChanged: (category) =>
                          ref.read(productControllerProvider.notifier).selectCategory(category),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    ProductSearchBar(
                      onChanged: (query) =>
                          ref.read(productControllerProvider.notifier).updateSearchQuery(query),
                      onFilterTap: () {
                        // TODO: open product filter options
                      },
                    ),
                    const SizedBox(height: AppSizes.lg),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: AppSizes.md,
                      mainAxisSpacing: AppSizes.md,
                      childAspectRatio: 0.72,
                      children: _products,
                    ),
                    const SizedBox(height: AppSizes.md),
                    Center(
                      child: Text(
                        'Showing 4 of 124 products',
                        style: TextStyle(fontSize: AppSizes.fontSm, color: context.appColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
