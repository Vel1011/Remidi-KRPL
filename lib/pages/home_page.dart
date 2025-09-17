import 'package:flutter/material.dart';
import '../models/student.dart';
import 'form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Student> students = [];
  bool _bannerVisible = false;

  @override
  void initState() {
    super.initState();
    // animasi banner
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _bannerVisible = true);
    });
  }

  void _addStudent(Student student) {
    setState(() => students.add(student));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PPDB Online",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.home, color: Colors.white),
            label: const Text("Home", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.info_outline, color: Colors.white),
            label:
                const Text("Informasi", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone, color: Colors.white),
            label: const Text("Kontak", style: TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.help_outline, color: Colors.white),
            label: const Text("Tentang", style: TextStyle(color: Colors.white)),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFF1F8E9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Banner
            AnimatedSlide(
              duration: const Duration(milliseconds: 800),
              offset: _bannerVisible ? Offset.zero : const Offset(0, -0.3),
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 800),
                opacity: _bannerVisible ? 1 : 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.lightBlueAccent, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.school, size: 70, color: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        "Selamat Datang di PPDB Online",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Daftarkan diri Anda dengan mudah dan cepat",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Informasi
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: -50, end: 0),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Transform.translate(
                    offset: Offset(value, 0), child: child);
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: const [
                      Icon(Icons.info, color: Colors.indigo, size: 40),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Silakan isi formulir pendaftaran dengan lengkap. Pastikan data sesuai dengan dokumen resmi.",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Data Pendaftar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Daftar siswa
            students.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Belum ada pendaftar.",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : Column(
                    children: students.asMap().entries.map((entry) {
                      final index = entry.key;
                      final s = entry.value;

                      return TweenAnimationBuilder<double>(
                        duration:
                            Duration(milliseconds: 500 + (index * 200)),
                        tween: Tween(begin: 0, end: 1),
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              child: const Icon(Icons.person,
                                  color: Colors.white),
                            ),
                            title: Text(s.namaLengkap,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "NISN: ${s.nisn}\nJK: ${s.jenisKelamin}"),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16, color: Colors.grey),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),

      // Tombol daftar
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormPage(onSubmit: _addStudent),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Daftar"),
      ),
    );
  }
}