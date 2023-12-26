import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_provider.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/controller/utility_provider.dart';
import 'package:wealth_wizard/view/transaction/addscreen/widgets/addwidget.dart';
import 'package:wealth_wizard/view/widget/bottom_bar.dart';
import 'package:wealth_wizard/model/add_data.dart';

class AddTransaction extends StatefulWidget {
  final File file;
  final String? id;
  final TransactionModel? obj;

  const AddTransaction({super.key, required this.file, this.id, this.obj});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  void initstate() {
    super.initState();
    UtilityProvider().income();
    // Provider.of<Dbprovider>(context).isEdit = true;
    final obj = widget.obj;
    final dbProvider = Provider.of<Dbprovider>(context, listen: false);
    final transactionProvider =
        Provider.of<TransactionModel>(context, listen: false);

    if (dbProvider.isEdit == false) {
      transactionProvider.type = obj!.type;
      transactionProvider.amount = obj.amount;
      transactionProvider.category = obj.category;
      transactionProvider.datetime = obj.datetime;
      transactionProvider.explain = obj.explain;
    } else {
      transactionProvider.type = " ";
      transactionProvider.amount = "";
      transactionProvider.category = "";
      // transactionProvider.datetime = null;
      transactionProvider.explain = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: Stack(
        alignment: AlignmentDirectional.center,
        children: [backgroundContainer(context), mainContainer()],
      )),
    );
  }

  Container mainContainer() {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<TransactionProvider>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      height: size.height * 0.7,
      width: size.width * 0.9,
      child: Form(
        key: provider.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              type(),
              const SizedBox(
                height: 20,
              ),
              category(),
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
                height: 27,
              ),
              GestureDetector(
                onTap: () {
                  if (provider.formKey.currentState!.validate()) {
                    Provider.of<Dbprovider>(context).isEditValueChange(true);
                    Provider.of<Dbprovider>(context, listen: false).isEdit
                        ? addTransaction()
                        : submitEditIncomeData();

                    // provider.amountcontroller.clear();
                    // provider.explainController.clear();
                    // provider.selectedIN = null;
                    // provider.selctedItem = null;
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
                  child: Text(
                    Provider.of<Dbprovider>(context).isEdit ? 'Save' : 'Update',
                    style: TextStyle(
                      fontFamily: 'f',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
        id: widget.obj!.id);

    await provider.editTransaction(model);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future addTransaction() async {
    final transactionprovider =
        Provider.of<TransactionProvider>(context, listen: false);
    final dbprovider = Provider.of<Dbprovider>(context, listen: false);
    final model = TransactionModel(
        type: transactionprovider.selectedIN!,
        amount: transactionprovider.amountcontroller.text,
        datetime: transactionprovider.date,
        explain: transactionprovider.explainController.text,
        category: transactionprovider.selctedItem!,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await dbprovider.insertTransaction(model);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomBar(username: "", file: widget.file),
    ));
    dbprovider.getAllData();

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Transaction Added Successfully',
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 3),
        backgroundColor: Color.fromARGB(255, 95, 13, 109),
      ),
    );
  }
}
