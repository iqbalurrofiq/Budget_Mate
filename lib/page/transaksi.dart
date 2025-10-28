import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  final Function(String, double, bool) onAdd;

  const AddTransactionPage({super.key, required this.onAdd});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = true;

  void _submit() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    widget.onAdd(title, amount, _isIncome);

    _titleController.clear();
    _amountController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ Transaksi berhasil ditambahkan!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Transaksi"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Judul Transaksi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: "Jumlah (Rp)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text("Jenis Transaksi"),
              subtitle: Text(_isIncome ? "Pemasukan" : "Pengeluaran"),
              value: _isIncome,
              onChanged: (val) => setState(() => _isIncome = val),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.save),
              label: const Text("Simpan", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
