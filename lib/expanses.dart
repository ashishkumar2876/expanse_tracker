import 'package:expanse_tracker/expenses_list.dart';
import 'package:expanse_tracker/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expanse_tracker/chart.dart';
import 'package:expanse_tracker/models/expense.dart';

class Expanses extends StatefulWidget{
  const Expanses({super.key});
  @override
  State<Expanses> createState() {
    return _ExpansesState();
  }
}
class _ExpansesState extends State<Expanses>{
  final List<Expense> _regiteredExpanses=[
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure,
    )];
  _openAddExpenseOverLay(){
    showModalBottomSheet(
       useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx)=>NewExpense(onAddExpense: _addExpense,));
  }
  void _addExpense(Expense expense){

         setState(() {
           _regiteredExpanses.add(expense);
         });
  }
  void _removeExpense(Expense expense){
    final expenseIndex=_regiteredExpanses.indexOf(expense);
    setState(() {
      _regiteredExpanses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted!!'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: (){
            setState(() {
              _regiteredExpanses.insert(expenseIndex, expense);
            });
          },
        ),

      )
    );
  }
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    Widget mainContent=const Center(
      child: Text('No expenses found.Start adding some!!'),
    );
    if(_regiteredExpanses.isNotEmpty){
      mainContent=ExpensesList(expenses: _regiteredExpanses, onRemoveExpense: _removeExpense,);
    }
   return Scaffold(
     appBar: AppBar(
       title: Text('Flutter Expanse tracker!!'),
       actions: [
         IconButton(
             onPressed: _openAddExpenseOverLay,
             icon: Icon(Icons.add),
         ),
       ],
     ),
    body: width < 600 ? Column(
      children: [
        Text('The chart'),
        Chart(expenses: _regiteredExpanses),
        Expanded(child: mainContent),
      ],
    ) : Row(
      children: [
        Text('The chart'),
        Expanded(child: Chart(expenses: _regiteredExpanses)),
        Expanded(child: mainContent),
      ],
    )

   );
  }
  
}

