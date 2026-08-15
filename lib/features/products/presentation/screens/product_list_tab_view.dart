import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../widgets/product_category_tabs.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/product_card_item.dart';

/// Same content as [ProductListMobileView], centered in a
/// fixed-width column with a 3-column grid for wider viewports.
class ProductListTabView extends ConsumerStatefulWidget {
  const ProductListTabView({super.key});

  @override
  ConsumerState<ProductListTabView> createState() => _ProductListTabViewState();
}

class _ProductListTabViewState extends ConsumerState<ProductListTabView> {
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
  Widget build(BuildContext context,) {
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
                      selected: _selectedCategory,
                      onChanged: (category) => setState(() => _selectedCategory = category),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    ProductSearchBar(
                      onChanged: (query) {},
                      onFilterTap: () {},
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
          ),
        ),
      ],
    );
  }
}