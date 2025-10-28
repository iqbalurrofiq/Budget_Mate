import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  const HistoryPage({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Center(child: Text("Belum ada transaksi."))
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final t = transactions[index];
              return ListTile(
                leading: Icon(
                  t['isIncome'] ? Icons.arrow_downward : Icons.arrow_upward,
                  color: t['isIncome'] ? Colors.green : Colors.red,
                ),
                title: Text(t['title']),
                subtitle: Text(
                  "${t['date'].day}/${t['date'].month}/${t['date'].year}",
                ),
                trailing: Text("Rp ${t['amount'].toStringAsFixed(0)}"),
              );
            },
          );
  }
}
