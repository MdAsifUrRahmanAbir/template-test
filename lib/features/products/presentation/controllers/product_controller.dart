import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/product_list_state.dart';

class ProductListController extends Notifier<ProductListState> {
  @override
  ProductListState build() => const ProductListState();

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

}

final productListControllerProvider =
NotifierProvider.autoDispose<ProductListController, ProductListState>(ProductListController.new);