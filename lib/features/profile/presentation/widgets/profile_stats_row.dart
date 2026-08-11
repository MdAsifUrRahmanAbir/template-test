import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import 'mini_stat_card.dart';

/// Row of PROJECTS / TASKS / RATING stat cards under the profile
/// header.
class ProfileStatsRow extends StatelessWidget {
  final String projects;
  final String tasks;
  final String rating;

  const ProfileStatsRow({
    super.key,
    required this.projects,
    required this.tasks,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: MiniStatCard(label: 'PROJECTS', value: projects)),
        const SizedBox(width: AppSizes.sm + AppSizes.xs),
        Expanded(child: MiniStatCard(label: 'TASKS', value: tasks)),
        const SizedBox(width: AppSizes.sm + AppSizes.xs),
        Expanded(child: MiniStatCard(label: 'RATING', value: rating)),
      ],
    );
  }
}