import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryID;
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

/* 
purpose
amount
date
income/expense
category type
*/

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //purpose
              TextFormField(
                controller: _purposeTextEditingController,
                decoration: const InputDecoration(hintText: 'Purpose'),
                keyboardType: TextInputType.text,
              ),

              //amount
              TextFormField(
                controller: _amountTextEditingController,
                decoration: const InputDecoration(hintText: 'Amount'),
                keyboardType: TextInputType.number,
              ),

              //date

              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 30)),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select date'
                    : _selectedDate.toString()),
              ),
              //income/expense
              Row(
                children: [
                  Radio(
                    value: CategoryType.income,
                    groupValue: _selectedCategoryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategoryType = CategoryType.income;
                        _categoryID = null;
                      });
                    },
                  ),
                  Text('Income'),
                  Radio(
                    value: CategoryType.expense,
                    groupValue: _selectedCategoryType,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategoryType = CategoryType.expense;
                        _categoryID = null;
                      });
                    },
                  ),
                  Text('Expense'),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 140),
                child: ElevatedButton(
                  onPressed: () {
                    addTransaction();
                    print('Submitted');
                  },
                  child: Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addTransaction() async {
    final _model = TransactionModel(
      purpose: _purposeTextEditingController.text,
      amount: _amountTextEditingController.text,
      date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );

    await TransactionDb().addTransaction(_model);
    Navigator.of(context).pop();
  }
}
