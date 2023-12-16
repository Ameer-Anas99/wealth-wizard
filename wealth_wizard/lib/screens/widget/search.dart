import 'package:flutter/material.dart';

import 'package:wealth_wizard/function/db_function.dart';
import 'package:wealth_wizard/transaction/transactions.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            controller: searchQueryController,
            onChanged: (query) {
              searchResult(query);
            },
            decoration: InputDecoration(
                hintText: 'Search..',
                border: InputBorder.none,
                icon: const Icon(
                  Icons.search,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      overViewListNotifier.value =
                          Dbprovider.instance.transactionListNotifier.value;
                      searchQueryController.clear();
                    },
                    icon: const Icon(
                      Icons.close,
                    ))),
          ),
        ),
      ),
    );
  }

  searchResult(String query) {
    if (query.isEmpty || query == '') {
      overViewListNotifier.value =
          Dbprovider.instance.transactionListNotifier.value;
    } else {
      overViewListNotifier.value = overViewListNotifier.value
          .where((element) =>
              element.category
                  .toLowerCase()
                  .contains(query.trim().toLowerCase()) ||
              element.explain.contains(query.trim().toLowerCase()))
          .toList();
    }
  }
}
