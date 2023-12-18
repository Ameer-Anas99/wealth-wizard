import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/balance.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/transactionprovider.dart';
import 'package:wealth_wizard/model/add_data.dart';
import 'package:wealth_wizard/view/transaction/editscreen/widgets/editwidget.dart';

class EditData extends StatefulWidget {
  final String? id;
  final TransactionModel obj;

  const EditData({
    super.key,
    required this.obj,
    this.id,
  });

  @override
  State<EditData> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditData> {
  // DateTime date = DateTime.now();
  // String? _selectedtype;
  // String? _selectedCategory;

  // int _value = 0;
  // TextEditingController _amountTextEditingController = TextEditingController();
  // TextEditingController _explainTextEditingController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  // final List<String> _iteminex = ['income', 'expense'];

  // final List<String> _item = [
  //   'Food',
  //   'Transfer',
  //   'Transportation',
  //   'Education',
  //   'Other'
  // ];

  @override
  void initState() {
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    super.initState();
    super.initState();
    provider.amountTextEditingController =
        TextEditingController(text: widget.obj.amount);
    provider.explainTextEditingController =
        TextEditingController(text: widget.obj.explain);
    provider.selectedEdittype = widget.obj.type;
    provider.selectedEditCategory = widget.obj.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          backgroundContainer(context),
          SingleChildScrollView(
            child: Container(
              child: mainContainer(),
            ),
          )
        ],
      )),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    final value = Provider.of<TransactionProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: value.formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            type(),
            const SizedBox(
              height: 20,
            ),
            Category(),
            const SizedBox(
              height: 20,
            ),
            explain(),
            const SizedBox(
              height: 20,
            ),
            amount(),
            const SizedBox(
              height: 20,
            ),
            dateTime(),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                if (value.formKey.currentState!.validate()) {
                  submitEditIncomeData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        backgroundColor: Color.fromARGB(255, 63, 173, 67),
                        content: Center(
                            child: Text('Transaction Edited Successfully'))),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 95, 13, 109),
                ),
                width: 120,
                height: 50,
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'f',
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitEditIncomeData() async {
    final provider = Provider.of<Dbprovider>(context, listen: false);
    final value = Provider.of<TransactionProvider>(context, listen: false);
    final explainText = value.explainTextEditingController.text;
    final amountText = value.amountTextEditingController.text;

    final model = TransactionModel(
        type: value.selectedEdittype!,
        amount: amountText,
        datetime: value.date,
        explain: explainText,
        category: value.selectedEditCategory!,
        id: widget.obj.id);

    await provider.editTransaction(model);
    Navigator.of(context).pop();
  }
}
