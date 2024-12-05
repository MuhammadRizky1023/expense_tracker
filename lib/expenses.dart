import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
import 'package:expense_tracker/widget/expenses/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<Expenses> createState(){
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses>{
  final List<Expense> _registerExpenses = [
    Expense(title: 'Flutter Course', amount: 20.00, date:  DateTime.now(), category:  Category.work),
    Expense(title: 'Cinema', amount: 52.13, date: DateTime.now(), category: Category.leisure)
  ];

  
  void _addExpense(Expense expense){
    setState(() {
      setState(() {
        _registerExpenses.add(expense);
      });
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registerExpenses.indexOf(expense);
    setState(() {
      _registerExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(label: 'Remove', onPressed: (){
          _registerExpenses.insert(expenseIndex, expense);
        }),
      )
    );
  }

  void  _openAddExpenseOverlay() {
    showModalBottomSheet(isScrollControlled: true, context: context, builder: (ctx)=> NewExpense(onAddExpense: _addExpense));
  }
  @override
  Widget build(BuildContext context){
    Widget mainContent = const Center(
      child: Text('No Expense found. Start adding some!'),
    );
    if(_registerExpenses.isNotEmpty){
      mainContent =  ExpensesList(expenses: _registerExpenses, onRemoveExpense: _removeExpense,);
    }
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracer'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
      children:  [
        Chart(expenses: _registerExpenses),
        Expanded(child: mainContent),
      ],
    )
    );
  }
}