import 'package:flutter/material.dart';
import 'package:kingcrpt/provider/chart_type_provider.dart';
import 'package:provider/provider.dart';

class IntervalButton extends StatelessWidget {
  const IntervalButton({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final chartProvider = Provider.of<ChartProvider>(context);
    final isSelected = chartProvider.selectedInterval == value;

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Color(0xFFECF4FF) : Color(0xFFF8F9FA),
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Color(0xFFDFE2E4),
        ),
      ),
      onPressed: () {
        chartProvider.setInterval(value);
      },
      child: Text(label),
    );
  }
}
