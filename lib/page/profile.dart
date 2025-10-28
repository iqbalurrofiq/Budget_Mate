import 'package:budget_mate/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BudgetMateApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Catatan Keuangan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const AddTransactionPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beranda")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Saldo Saat Ini", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(
              "Rp 2.450.000",
              style: TextStyle(
                fontSize: 28,
                color: Colors.teal[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Transaksi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Judul Transaksi'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(value: 'Pemasukan', child: Text('Pemasukan')),
                DropdownMenuItem(
                  value: 'Pengeluaran',
                  child: Text('Pengeluaran'),
                ),
              ],
              onChanged: (value) {},
              decoration: const InputDecoration(labelText: 'Jenis Transaksi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {'title': 'Gaji', 'amount': 3000000, 'type': 'Pemasukan'},
      {'title': 'Makan', 'amount': 50000, 'type': 'Pengeluaran'},
      {'title': 'Transport', 'amount': 20000, 'type': 'Pengeluaran'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Riwayat Transaksi")),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          var t = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              leading: Icon(
                t['type'] == 'Pemasukan'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward,
                color: t['type'] == 'Pemasukan' ? Colors.green : Colors.red,
              ),
              title: Text(t['title']),
              subtitle: Text(t['type']),
              trailing: Text(
                "Rp ${t['amount']}",
                style: TextStyle(
                  color: t['type'] == 'Pemasukan' ? Colors.green : Colors.red,
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

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Pengguna")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://i.pinimg.com/564x/d1/5b/b8/d15bb8e0137ff39cce7d9f6dfd33d15b.jpg',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Iqbalur Rofiq",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "iqbalurrofq@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Statistik keuangan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Column(
                        children: [
                          Text(
                            "Pemasukan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp 3.000.000",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Pengeluaran",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp 550.000",
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Saldo",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rp 2.450.000",
                            style: TextStyle(color: Colors.teal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Tombol aksi
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.teal),
              title: const Text("Edit Profil"),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.blue),
              title: const Text("Tentang Aplikasi"),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Aplikasi Catatan Keuangan',
                  applicationVersion: 'v1.0',
                  children: const [
                    Text(
                      "Dibuat oleh mahasiswa TI untuk tugas UAS dengan Flutter.",
                    ),
                  ],
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Keluar"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
