import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widget/editdata.dart';
import 'package:wealth_wizard/view/uppercase.dart';

class SlidableTransaction extends StatelessWidget {
  SlidableTransaction({super.key, required this.transaction});

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: ((context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) {
                  return EditData(obj: transaction);
                }),
              ),
            );
          }),
          icon: Icons.edit,
          foregroundColor: const Color.fromARGB(255, 50, 107, 135),
        ),
        SlidableAction(
          onPressed: ((context) async {
            await Dbprovider().deleteTransaction(transaction);
          }),
          icon: Icons.delete,
          foregroundColor: Colors.red,
        ),
      ]),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child:
                Image.asset('assets/${transaction.category}.jpeg', height: 40),
          ),
          title: Text(
            transaction.explain.capitalize(),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${transaction.datetime.year}-${transaction.datetime.day}-${transaction.datetime.month}  ${days[transaction.datetime.weekday - 1]}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
          trailing: Text(
            transaction.amount,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 19,
              color: transaction.type == 'income' ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
