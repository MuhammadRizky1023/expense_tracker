
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();


enum Category{food, travel, leisure, work,}
const CategoryIcons = {
  Category.food: Icons.launch,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
  Category.leisure: Icons.movie
};
class Expense {
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
  }): id = uuid.v4();
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}

class ExpenseBucket{
  const ExpenseBucket({
    required this.category,
    required this.expense
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category): expense = allExpenses.where((expense) =>  expense.category== category).toList();

  final Category category;
  final List<Expense> expense;

  double get totalExpenses{  
    double sum = 0;
    for (final expense in expense){
      sum += expense.amount;
    } return sum;
  }

}