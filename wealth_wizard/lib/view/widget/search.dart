import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wealth_wizard/controller/db_function.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';
import 'package:wealth_wizard/view/transactions.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: provider.searchQueryController,
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
                          Provider.searchQueryController.clear();
                        },
                        icon: const Icon(
                          Icons.close,
                        ))),
              ),
            ),
          );
        },
      ),
    );
  }
}
