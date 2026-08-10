import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_test/core/network/api_client.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(ref.watch(apiClientProvider));
});

class OrderRepository {
  final ApiClient _apiClient;
  OrderRepository(this._apiClient);
}
