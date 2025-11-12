import 'package:flutter/material.dart';

class DetailedRow extends StatelessWidget {
  const DetailedRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {

    //supposed to be detailed row for naming
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 14,
            color: Theme.of(context).colorScheme.secondary
          )),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 18
            ),
          ),
        ],
      ),
    );
  }
}
