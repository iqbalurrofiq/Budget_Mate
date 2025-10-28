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

    return Scaffold(
      appBar: AppBar(
        title: const Text("BudgetMate"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Saldo Kamu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Rp ${balance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard(
                  Icons.arrow_downward,
                  "Pemasukan",
                  totalIncome,
                  Colors.green,
                ),
                _buildSummaryCard(
                  Icons.arrow_upward,
                  "Pengeluaran",
                  totalExpense,
                  Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Transaksi Terakhir",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            transactions.isEmpty
                ? const Text("Belum ada transaksi.")
                : Column(
                    children: transactions.reversed.take(3).map((t) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                            t['isIncome']
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: t['isIncome'] ? Colors.green : Colors.red,
                          ),
                          title: Text(t['title']),
                          trailing: Text(
                            "Rp ${t['amount'].toStringAsFixed(0)}",
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    IconData icon,
    String label,
    double amount,
    Color color,
  ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Rp ${amount.toStringAsFixed(0)}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
