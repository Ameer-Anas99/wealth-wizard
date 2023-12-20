import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/controller/utility_provider.dart';
import 'package:wealth_wizard/view/transaction/addscreen/widgets/addwidget.dart';
import 'package:wealth_wizard/view/widget/bottom_bar.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';

class AddTransaction extends StatefulWidget {
  File file;
  AddTransaction({super.key, required this.file});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  void initstate() {
    super.initState();
    UtilityProvider().income();
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
              name(),
              const SizedBox(
                height: 20,
              ),
              explain(),
              const SizedBox(
                height: 20,
              ),
              transactionAmount(),
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
                    addTransaction();

                    provider.amountcontroller.clear();
                    provider.explainController.clear();
                    provider.selectedIN = null;
                    provider.selctedItem = null;
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
            ],
          ),
        ),
      ),
    );
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

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BottomBar(username: "", file: widget.file),
    ));
    dbprovider.getAllData();

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
