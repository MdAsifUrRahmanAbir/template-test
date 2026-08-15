import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/common/app_header_bar.dart';
import '../../../../core/widgets/common/custom_tab_bar.dart';
import '../widgets/order_card_item.dart';
import '../widgets/order_status_badge.dart';

class OrderListMobileView extends ConsumerStatefulWidget {
  const OrderListMobileView({super.key});

  @override
  ConsumerState<OrderListMobileView> createState() => _OrderListMobileViewState();
}

class _OrderListMobileViewState extends ConsumerState<OrderListMobileView> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 4, vsync: this);

  // TODO: replace hardcoded orders with orderControllerProvider once
  // features/orders/data/repositories is implemented.
  static const _orders = [
    OrderCardItem(
      orderId: '#ORD-2026-1284',
      date: 'Feb 23, 2026',
      status: OrderStatus.pending,
      itemImageUrls: ['https://placehold.co/64x64', 'https://placehold.co/64x64', 'https://placehold.co/64x64'],
      itemCount: 3,
      total: '\$253.25',
    ),
    OrderCardItem(
      orderId: '#ORD-2026-1102',
      date: 'Feb 18, 2026',
      status: OrderStatus.completed,
      itemImageUrls: ['https://placehold.co/64x64', 'https://placehold.co/64x64', 'https://placehold.co/64x64'],
      itemCount: 1,
      total: '\$49.50',
    ),
    OrderCardItem(
      orderId: '#ORD-2026-1051',
      date: 'Feb 12, 2026',
      status: OrderStatus.cancelled,
      itemImageUrls: ['https://placehold.co/64x64', 'https://placehold.co/64x64', 'https://placehold.co/64x64'],
      itemCount: 2,
      total: '\$184.99',
    ),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppHeaderBar(title: AppStrings.myOrdersTitle),
        CustomTabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: AppStrings.orderTabAll),
            Tab(text: AppStrings.orderTabPending),
            Tab(text: AppStrings.orderTabCompleted),
            Tab(text: AppStrings.orderTabCancelled),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.md),
            child: Column(
              children: [
                for (final order in _orders) ...[
                  order,
                  if (order != _orders.last) const SizedBox(height: AppSizes.sm + AppSizes.xs),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}