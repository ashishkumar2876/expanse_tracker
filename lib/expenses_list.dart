import 'package:expanse_tracker/expenseitem.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker/models/expense.dart';
import 'package:expanse_tracker/expanses.dart';
class ExpensesList extends StatelessWidget{
  const ExpensesList({super.key,required this.expenses,required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount:expenses.length,
      itemBuilder: (context,index)=>Dismissible(
        background: Container(color: Theme.of(context).cardTheme.color!.withOpacity(0.50),
        margin: Theme.of(context).cardTheme.margin!,
        ),

        onDismissed: (direction){
          onRemoveExpense(expenses[index]);
        },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index])
      ),
    );
  }

}