import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const HomePage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double totalIncome = transactions
        .where((t) => t['isIncome'])
        .fold(0, (sum, t) => sum + t['amount']);
    double totalExpense = transactions
        .where((t) => !t['isIncome'])
        .fold(0, (sum, t) => sum + t['amount']);
    double balance = totalIncome - totalExpense;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    "Total Saldo",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp ${balance.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  title: const Text("Pemasukan"),
                  trailing: Text("Rp ${totalIncome.toStringAsFixed(0)}"),
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_upward, color: Colors.red),
                  title: const Text("Pengeluaran"),
                  trailing: Text("Rp ${totalExpense.toStringAsFixed(0)}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
