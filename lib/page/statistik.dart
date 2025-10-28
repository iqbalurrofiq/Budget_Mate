import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const StatisticsPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalIncome = transactions
        .where((t) => t['isIncome'])
        .fold(0, (sum, t) => sum + t['amount']);
    double totalExpense = transactions
        .where((t) => !t['isIncome'])
        .fold(0, (sum, t) => sum + t['amount']);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistik Keuangan"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bar_chart, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            Text(
              "Total Pemasukan: Rp ${totalIncome.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            Text(
              "Total Pengeluaran: Rp ${totalExpense.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              "Saldo Akhir: Rp ${(totalIncome - totalExpense).toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
