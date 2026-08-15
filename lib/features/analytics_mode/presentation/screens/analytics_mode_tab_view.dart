import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../widgets/analytics_header.dart';
import '../widgets/analytics_stat_grid.dart';
import '../widgets/revenue_expense_chart_card.dart';
import '../widgets/category_breakdown_card.dart';

/// Same content as [AnalyticsMobileView], centered in a fixed-width
/// column for wider (tablet/web) viewports.
class AnalyticsTabView extends ConsumerStatefulWidget {
  const AnalyticsTabView({super.key});

  @override
  ConsumerState<AnalyticsTabView> createState() => _AnalyticsTabViewState();
}

class _AnalyticsTabViewState extends ConsumerState<AnalyticsTabView> {
  String _range = 'W';

  @override
  Widget build(BuildContext context,) {
    return Column(
      children: [
        AnalyticsHeader(
          dateRangeLabel: 'Jan 1, 2026 - Jan 31, 2026',
          onExportTap: () {},
          onDateRangeTap: () {},
        ),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.xl),
                child: Column(
                  children: [
                    const AnalyticsStatGrid(),
                    const SizedBox(height: AppSizes.xl),
                    RevenueExpenseChartCard(
                      selectedRange: _range,
                      onRangeChanged: (r) => setState(() => _range = r),
                      revenueValues: const [45, 62, 40, 95, 55, 105, 88, 130],
                      expenseValues: const [40, 55, 35, 78, 50, 90, 80, 130],
                      yAxisLabels: const ['120k', '80k', '40k', '0k'],
                      xAxisLabels: const ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                    ),
                    const SizedBox(height: AppSizes.xl),
                    CategoryBreakdownCard(
                      centerLabel: 'SaaS',
                      shares: const [
                        CategoryShare(label: 'SaaS Suite', percent: 65, color: AppColors.primary),
                        CategoryShare(label: 'Infrastructure', percent: 20, color: AppColors.success),
                        CategoryShare(label: 'Hardware', percent: 10, color: AppColors.warning),
                        CategoryShare(label: 'Other', percent: 5, color: AppColors.error),
                      ],
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