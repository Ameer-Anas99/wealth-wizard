import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/model/add_data.dart';

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

  searchResult(BuildContext context, String query) {
    final dbprovider = Provider.of<Dbprovider>(context, listen: false);
    if (query.isEmpty || query == '') {
      debugPrint(query);
      dbprovider.transactionList = dbprovider.chartList;
    } else {
      // overViewListNotifier.value = overViewListNotifier.value
      dbprovider.transactionList = dbprovider.chartList
          .where((element) =>
              element.category
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()) ||
              element.explain.contains(query.trim().toLowerCase()))
          .toList();
    }
  }

  List<TransactionModel> taskModelList = <TransactionModel>[];

  List queryResultList = [];
  String queryval = '';
  addToQueryList(String query) async {
    queryResultList.clear();

    if (query.isEmpty || query == '') {
      queryResultList.clear();
    } else {
      for (var element in taskModelList) {
        if (element.explain
            .trim()
            .toLowerCase()
            .contains(query.trim().toLowerCase())) {
          queryResultList.add(element.explain);
        }
      }
    }
    notifyListeners();
  }
}
