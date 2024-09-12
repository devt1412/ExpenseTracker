import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:expense_tracker/helpers/database_helper.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key? key, required this.onRemoveExpense})
      : super(key: key);

  final Function(Expense expense) onRemoveExpense;

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<Expense> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final expenses = await DatabaseHelper.instance.getExpenses();
    setState(() {
      _expenses = expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(_expenses[index].id),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        onDismissed: (direction) {
          final deletedExpense = _expenses[index];
          setState(() {
            _expenses.removeAt(index);
          });
          DatabaseHelper.instance.deleteExpense(deletedExpense.id);
          widget.onRemoveExpense(deletedExpense);
        },
        child: ExpenseItem(_expenses[index]),
      ),
    );
  }
}
