import 'package:budget/helper/date_helper.dart';
import 'package:budget/widget/circle_icon.dart';
import 'package:flutter/material.dart';

import '../provider/currency_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.currencyProvider, {super.key});

  final CurrencyProvider currencyProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: PopupMenuButton(
            onSelected: (selectedValue) {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.output_rounded,
                      color: Colors.deepOrange,
                    ),
                    Text(' New Expense Category')
                  ],
                ),
              ),
            ],
          ),
          title: Text(DateHelper.formattedDate()),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 5,
                color: Colors.green[50],
                child: ListTile(
                  leading: const CircleIcon(Icons.input_rounded, Colors.green),
                  title: Text('Income', style: Theme.of(context).textTheme.titleLarge),
                  subtitle:
                      Text('Tap to set', style: Theme.of(context).textTheme.bodyMedium),
                  trailing: Text('£ 0', style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const CircleIcon(Icons.output_rounded, Colors.orange),
                        title: Text('Expenses',
                            style: Theme.of(context).textTheme.titleLarge),
                        trailing: Text('30 days ▼',
                            style: Theme.of(context).textTheme.titleMedium),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Text('Available today: '),
                            Text(' £112.12',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text('◀ Friday, 16 February  →  Thursday, 22 February ▶'),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('No expense categories yet'),
                          )),
                      const SizedBox(height: 20),
                    ],
                  ))
            ],
          ),
        ));
  }
}
