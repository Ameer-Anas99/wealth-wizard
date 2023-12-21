import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/slidable_transaction.dart';

class TransactionIncome extends StatelessWidget {
  const TransactionIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Dbprovider>(builder: (context, value, child) {
      var incomeList = value.transactionList
          .where(
            (element) => element.type == 'income',
          )
          .toList();
      final reversedIncomeList = incomeList.reversed.toList();
      return (reversedIncomeList.isEmpty)
          ? Column(
              children: [
                const SizedBox(
                  height: 15,
                  width: 14,
                ),
                Center(
                  child: Image.asset(
                    "assets/errorimage.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const Center(
                  child: Text('No transactions added yet'),
                ),
              ],
            )
          : ListView.separated(
              padding: const EdgeInsets.all(5),
              itemBuilder: (ctx, index) {
                final transaction = reversedIncomeList[index];
                return SlidableTransaction(transaction: transaction);
              },
              separatorBuilder: (ctx, index) {
                return const Divider(
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount: incomeList.length);
    });
  }
}
