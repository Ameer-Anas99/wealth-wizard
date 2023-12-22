import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_provider.dart';
import 'package:wealth_wizard/model/add_data.dart';

class TransactionProvider extends ChangeNotifier {
  TextEditingController searchQueryController = TextEditingController();
  // TransactionProvider() {
  // }
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

  get obj => null;
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

  searchResult(BuildContext context, String query1) {
    final dbprovider = Provider.of<Dbprovider>(context, listen: false);
    if (query1.isEmpty || query1 == '') {
      debugPrint(query1);
      dbprovider.transactionList = dbprovider.chartList;
    } else {
      // overViewListNotifier.value = overViewListNotifier.value
      dbprovider.transactionList = dbprovider.chartList
          .where((element) =>
              element.category
                  .toLowerCase()
                  .contains(query1.trim().toLowerCase()) ||
              element.explain.contains(query1.trim().toLowerCase()))
          .toList();
    }
  }

  List<TransactionModel> taskModelList = <TransactionModel>[];

  List queryResultList = [];
  String query1 = '';
  addToQueryList(String query1) async {
    queryResultList.clear();

    if (query1.isEmpty || query1 == '') {
      queryResultList.clear();
    } else {
      for (var element in taskModelList) {
        if (element.explain
            .trim()
            .toLowerCase()
            .contains(query1.trim().toLowerCase())) {
          queryResultList.add(element.explain);
        }
      }
    }
    notifyListeners();
  }
}
