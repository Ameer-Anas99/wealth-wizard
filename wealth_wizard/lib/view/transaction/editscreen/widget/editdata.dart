import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';

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

  Container dateTime() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.grey)),
      width: 300,
      child: Consumer<TransactionProvider>(builder: (context, value, child) {
        return TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: value.obj.datetime,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            // setState(() {
            //   date = newDate!;
            // });
            value.selectedDate;
          },
          child: Text(
            'Date : ${value.date.year}/${value.date.month}/${value.date.day}',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        );
      }),
    );
  }

  Padding type() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(builder: (context, provider, child) {
        return Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
            ),
            child: SingleChildScrollView(
              child: DropdownButtonFormField<String>(
                hint: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Image.asset('assets/${widget.obj.type}.jpeg'),
                    ),
                    Text('${widget.obj.type}',
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
                value: provider.selectedEdittype,
                onChanged: ((value) {
                  // setState(() {
                  //   _selectedtype = value!;
                  // });
                }),
                items: provider.iteminex
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                e,
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ))
                    .toList(),
                dropdownColor: Colors.white,
                isExpanded: true,
              ),
            ));
      }),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child:
            Consumer<TransactionProvider>(builder: (context, provider, child) {
          return TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required value';
              } else if (value.contains(' ')) {
                return 'Please remove spaces';
              } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Please Enter a valid number';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            controller: provider.amountTextEditingController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'Amount',
              labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.green)),
            ),
          );
        }),
      ),
    );
  }

  Padding explain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child:
            Consumer<TransactionProvider>(builder: (context, provider, child) {
          return TextFormField(
            validator: (values) {
              if ((values == null || values.isEmpty)) {
                return "Required Value";
              } else if (values.contains(' ')) {
                return 'Please remove spaces';
              } else if (!RegExp(r'^[a-z]+$').hasMatch(values)) {
                return 'Please Enter a valid number';
              } else {
                return null;
              }
            },
            controller: provider.explainTextEditingController,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'explain',
              labelStyle: const TextStyle(fontSize: 17, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 2, color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 2, color: Colors.green)),
            ),
          );
        }),
      ),
    );
  }

  Padding category() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<TransactionProvider>(builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xffC5C5C5),
            ),
          ),
          child: DropdownButtonFormField<String>(
            hint: Row(
              children: [
                Text('${widget.obj.category} ',
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
            onChanged: (value) {
              // setState(() {
              //   _selectedCategory = value!;
              // });
              provider.selectedItem(value!);
            },
            items: provider.item
                .map(
                  (e) => DropdownMenuItem<String>(
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                            // child: Image.asset('assets/$e.jpeg'),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    value: e,
                  ),
                )
                .toList(),
            selectedItemBuilder: (BuildContext context) => provider.item
                .map(
                  (e) => Row(
                    children: [
                      SizedBox(
                        width: 42,
                        child: Image.asset('assets/$e.jpeg'),
                      ),
                      const SizedBox(width: 5),
                      Text(e),
                    ],
                  ),
                )
                .toList(),
            decoration: const InputDecoration(
              hintText: 'Category',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
          ),
        );
      }),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 95, 13, 109),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Center(
                      child: Text(
                        'Edit Transaction',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    const Icon(
                      Icons.add_task_rounded,
                      color: Color.fromARGB(255, 95, 13, 109),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
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
