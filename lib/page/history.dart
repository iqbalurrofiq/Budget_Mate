import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const HistoryPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Transaksi"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: transactions.isEmpty
          ? const Center(child: Text("Belum ada transaksi."))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final t = transactions.reversed.toList()[index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      t['isIncome'] ? Icons.arrow_downward : Icons.arrow_upward,
                      color: t['isIncome'] ? Colors.green : Colors.red,
                    ),
                    title: Text(t['title']),
                    subtitle: Text(
                      "${t['date'].day}/${t['date'].month}/${t['date'].year}",
                    ),
                    trailing: Text(
                      "Rp ${t['amount'].toStringAsFixed(0)}",
                      style: TextStyle(
                        color: t['isIncome'] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
