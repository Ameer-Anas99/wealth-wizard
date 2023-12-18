import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/transactionprovider.dart';

Container dateTime() {
  return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.grey)),
      width: 300,
      child: Consumer<TransactionProvider>(builder: (context, provider, child) {
        return TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100));
            if (newDate == null) {
              return;
            } else {
              // setState(() {
              //   date = newDate;
              // });
              provider.selectedDate(newDate);
            }
          },
          child: Text(
            'Date : ${provider.date.year}/${provider.date.month}/${provider.date.day}',
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        );
      }));
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
              )),
          child: DropdownButtonFormField<String>(
            value: provider.selectedIN,
            onChanged: ((value) {
              provider.selectedType(value!);
              // setState(() {
              //   selectedIN = value!;
              // });
            }),
            items: provider.iteminex
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          Text(
                            e,
                            style: const TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ))
                .toList(),
            hint: const Text(
              'Select',
              style: TextStyle(color: Colors.grey),
            ),
            dropdownColor: Colors.white,
            isExpanded: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Select value";
              } else {
                return null;
              }
            },
          ));
    }),
  );
}

Padding transactionAmount() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Consumer<TransactionProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: 300,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select Amount';
            } else if (value.contains(',')) {
              return 'Please remove special character';
            } else if (value.contains('.')) {
              return 'Please remove special character';
            } else if (value.contains(' ')) {
              return 'Please remove spaces';
            } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
              return 'Please Enter a valid number';
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.number,
          focusNode: provider.amount,
          controller: provider.amountcontroller,
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
        ),
      );
    }),
  );
}

Padding explain() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Consumer<TransactionProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: 300,
        child: TextFormField(
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return "Select explain";
          //   } else {
          //     return null;
          //   }
          // },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Select explain';
            } else if (value.contains(' ')) {
              return 'Please remove spaces';
            } else if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
              return 'Please Enter a valid number';
            } else {
              return null;
            }
          },
          focusNode: provider.ex,
          controller: provider.explainController,
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
        ),
      );
    }),
  );
}

Padding name() {
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
            color: Color.fromARGB(255, 184, 182, 182),
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: provider.selctedItem,
          onChanged: (value) {
            // setState(() {
            //   selctedItem = value!;
            // });
            provider.selectedItem(value!);
          },
          items: provider.item
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Image.asset('assets/$e.jpeg'),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e,
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
          selectedItemBuilder: (BuildContext context) => provider.item
              .map(
                (e) => Row(
                  children: [
                    Container(
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Select Item";
            } else {
              return null;
            }
          },
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
                      'Add Transaction',
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
