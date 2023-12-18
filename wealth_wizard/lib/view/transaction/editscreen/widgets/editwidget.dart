import 'package:flutter/material.dart';

Container dateTime() {
  return Container(
    alignment: Alignment.bottomLeft,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.grey)),
    width: 300,
    child: TextButton(
      onPressed: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: widget.obj.datetime,
            firstDate: DateTime(2020),
            lastDate: DateTime(2100));
        if (newDate == Null) return;
        setState(() {
          date = newDate!;
        });
      },
      child: Text(
        'Date : ${date.year}/${date.month}/${date.day}',
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    ),
  );
}

Padding type() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
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
                Container(
                  width: 40,
                  child: Image.asset('assets/${widget.obj.type}.jpeg'),
                ),
                Text('${widget.obj.type}',
                    style: const TextStyle(color: Colors.black)),
              ],
            ),
            value: _selectedtype,
            onChanged: ((value) {
              setState(() {
                _selectedtype = value!;
              });
            }),
            items: _iteminex
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
        )),
  );
}

Padding amount() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: SizedBox(
      width: 300,
      child: TextFormField(
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
        controller: _amountTextEditingController,
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
    ),
  );
}

Padding explain() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: SizedBox(
      width: 300,
      child: TextFormField(
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
        controller: _explainTextEditingController,
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
    ),
  );
}

Padding Category() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
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
          setState(() {
            _selectedCategory = value!;
          });
        },
        items: _item
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
        selectedItemBuilder: (BuildContext context) => _item
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
      ),
    ),
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
