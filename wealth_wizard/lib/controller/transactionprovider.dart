import 'package:flutter/material.dart';

class TransactionProvider extends ChangeNotifier {
  TextEditingController searchQueryController = TextEditingController();

  final List<String> day = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
  DateTime date = DateTime.now();

  String? selectedIN;

  final formKey = GlobalKey<FormState>();

  final TextEditingController explainController = TextEditingController();

  String? selctedItem;

  FocusNode ex = FocusNode();

  final TextEditingController amountcontroller = TextEditingController();

  FocusNode amount = FocusNode();

  DateTime? selectedEditDateTime;

  String? selectedEdittype;

  String? selectedEditCategory;
  TextEditingController amountTextEditingController = TextEditingController();
  TextEditingController explainTextEditingController = TextEditingController();

  final List<String> iteminex = ['income', 'expense'];

  final List<String> item = [
    'Food',
    'Transfer',
    'Transportation',
    'Education',
    'Other'
  ];
  void selectedDate(DateTime? newDate) {
    if (newDate != null) {
      date = newDate;
      notifyListeners();
    }
  }

  void selectedType(String value) {
    selectedIN = value;
    notifyListeners();
  }

  void selectedItem(String value) {
    selctedItem = value;
    notifyListeners();
  }
}
