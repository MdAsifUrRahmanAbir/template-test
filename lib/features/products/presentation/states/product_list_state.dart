class ProductListState {
  final String selectedCategory;
  final String searchQuery;
  final bool isProductsLoading;
  final String? errorMessage;

  const ProductListState({
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.isProductsLoading = false,
    this.errorMessage,
  });

  ProductListState copyWith({
    String? selectedCategory,
    String? searchQuery,
    bool? isProductsLoading,
    String? errorMessage,
  }) {
    return ProductListState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      errorMessage: errorMessage,
    );
  }
}