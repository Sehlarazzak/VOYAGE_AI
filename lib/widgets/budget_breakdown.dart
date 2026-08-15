import 'package:flutter/material.dart';

class BudgetBreakdown extends StatelessWidget{
  final String transportCost;
  final String foodCost;
  final String activitiesCost;
  final String totalCost;
  final String accommodationCost;
  final String shoppingCost;


  const BudgetBreakdown({
    super.key,
    required this.transportCost,
    required this.foodCost,
    required this.activitiesCost,
    required this.totalCost,
    required this.accommodationCost,
    required this.shoppingCost,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: const Color(0xFF151F32),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF29364D),
      ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ESTIMATED BUDGET',
            style: TextStyle(
              color: Color(0xFF3D9CFF),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          _BudgetRow(title: 'Transport', amount: transportCost),

          _BudgetRow(title: 'Food', amount: foodCost),

          _BudgetRow(title: 'Activities', amount: activitiesCost),

          _BudgetRow(title: 'Accommodation', amount: accommodationCost),

          _BudgetRow(title: 'Shopping', amount: shoppingCost),



          const Divider(
            color: Color(0xFF29364D),
            height: 25,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                 style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                totalCost,
                style: const TextStyle(
                  color: Color(0xFF3D9CFF),
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),


        ],
      ),
    );

  }

}

class _BudgetRow extends StatelessWidget {
  final String title;
  final String amount;

  const _BudgetRow({
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),

          Text(
            amount,
             style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      );
  }
}