import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDb.instance.refresh();
    CategoryDB.instance.refreshUI();

    return ValueListenableBuilder(
        child: null,
        valueListenable: TransactionDb.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final _value = newList[index];
              return Slidable(
                key: Key(_value.id!),
                startActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDb.instance.deleteTransaction(_value.id!);
                      },
                      icon: Icons.delete,
                      foregroundColor: Color.fromARGB(255, 247, 19, 3),
                      label: 'Delete',
                    )
                  ],
                ),
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: _value.type == CategoryType.income
                            ? Colors.green
                            : Colors.red,
                        child: Text(
                          parseDate(_value.date),
                          textAlign: TextAlign.center,
                        )),
                    title: Text('Rs.${_value.amount}'),
                    subtitle: Text(_value.purpose),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return const SizedBox(
                height: 0,
              );
            },
            itemCount: newList.length,
          );
        });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _spliteddate = _date.split(' ');
    return '${_spliteddate.last}\n${_spliteddate.first}';
    //return '${date.day}\n${date.month}';
  }
}
