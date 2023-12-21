import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealth_wizard/controller/transaction_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

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
                  provider.addToQueryList(query);
                  provider.query1 = query;
                },
                decoration: InputDecoration(
                    hintText: 'Search..',
                    border: InputBorder.none,
                    icon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          // overViewListNotifier.value =
                          //     Dbprovider.instance.transactionListNotifier.value;
                          // Provider.searchQueryController.clear();
                          provider.query1 = '';
                          provider.searchQueryController.clear();
                          provider.addToQueryList('');
                          FocusManager.instance.primaryFocus?.unfocus();
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
