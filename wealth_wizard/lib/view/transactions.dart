import 'package:flutter/material.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/widget/slidable_transaction.dart';
import 'package:wealth_wizard/view/transaction/transaction_list.dart';

ValueNotifier<List<TransactionModel>> overViewListNotifier =
    ValueNotifier(Dbprovider.instance.transactionListNotifier.value);

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    Dbprovider().getAllTransactions();
    return ValueListenableBuilder(
        valueListenable: overViewListNotifier,
        builder: (BuildContext context, newList, Widget? _) {
          return ValueListenableBuilder(
              valueListenable: showCategory,
              builder: (context, showcategorylist, child) {
                var displayList = [];

                if (showCategory.value == 'income') {
                  List<TransactionModel> incomeTransactionList = [];
                  incomeTransactionList = newList
                      .where((element) => element.type == 'income')
                      .toList();
                  displayList = incomeTransactionList;
                } else if (showCategory.value == "Expense") {
                  List<TransactionModel> expenseTransactionList = [];
                  expenseTransactionList = newList
                      .where((element) => element.type == 'expense')
                      .toList();
                  displayList = expenseTransactionList;
                } else {
                  displayList = newList;
                }

                return (displayList.isEmpty)
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          SizedBox(height: screenHeight / 10),
                          const Center(
                            child: Text('No transactions added yet'),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        padding: const EdgeInsets.all(5),
                        itemBuilder: (ctx, index) {
                          final transaction = displayList[index];
                          return SlidableTransaction(transaction: transaction);
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider(
                            height: 5,
                            thickness: 5,
                          );
                        },
                        itemCount: displayList.length);
              });
        });
  }
}
