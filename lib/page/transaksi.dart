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
      const SnackBar(content: Text("Transaksi berhasil ditambahkan!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Judul Transaksi"),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: "Jumlah (Rp)"),
            keyboardType: TextInputType.number,
          ),
          SwitchListTile(
            title: const Text("Jenis Transaksi"),
            subtitle: Text(_isIncome ? "Pemasukan" : "Pengeluaran"),
            value: _isIncome,
            onChanged: (val) => setState(() => _isIncome = val),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.save),
            label: const Text("Simpan Transaksi"),
          ),
        ],
      ),
    );
  }
}
