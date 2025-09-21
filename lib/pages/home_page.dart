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
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _bannerVisible = true);
    });
  }

  void _addStudent(Student student) {
    setState(() => students.add(student));
  }

  void _editStudent(int index, Student updated) {
    setState(() => students[index] = updated);
  }

  void _deleteStudent(int index) {
    setState(() => students.removeAt(index));
  }

  // ✅ Fungsi baru: membuka FormPage dan menangkap hasil untuk auto-refresh
  Future<void> _openFormPage({Student? student, int? index}) async {
    final result = await Navigator.push<Student>(
      context,
      MaterialPageRoute(
        builder: (_) => FormPage(
          student: student,
          onSubmit: (s) {
            Navigator.pop(context, s);
          },
        ),
      ),
    );

    if (result != null) {
      if (student != null && index != null) {
        _editStudent(index, result);
      } else {
        _addStudent(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PPDB Online",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // ✅ Body
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEAF2F8), Color(0xFFFDFEFE)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Banner Welcome
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
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withOpacity(0.85),
                        Colors.blueAccent.withOpacity(0.85),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.school, size: 70, color: Colors.white),
                      SizedBox(height: 12),
                      Text(
                        "Selamat Datang di PPDB Online",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Daftarkan diri Anda dengan mudah, cepat, dan praktis!",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: const [
                    Icon(Icons.info, color: Colors.indigo, size: 40),
                    SizedBox(width: 14),
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

            const SizedBox(height: 24),
            const Text(
              "Data Pendaftar",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // ✅ List siswa dengan titik tiga per item
            students.isEmpty
                ? Column(
                    children: const [
                      SizedBox(height: 30),
                      Icon(Icons.people_alt_outlined,
                          size: 80, color: Colors.grey),
                      SizedBox(height: 12),
                      Text("Belum ada pendaftar.",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  )
                : Column(
                    children: students.asMap().entries.map((entry) {
                      final index = entry.key;
                      final s = entry.value;

                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 500 + (index * 200)),
                        tween: Tween(begin: 0, end: 1),
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            leading: CircleAvatar(
                              backgroundColor: Colors.indigo,
                              radius: 25,
                              child: Text(
                                s.namaLengkap.isNotEmpty
                                    ? s.namaLengkap[0].toUpperCase()
                                    : "?",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            title: Text(
                              s.namaLengkap,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "NISN: ${s.nisn}\nJK: ${s.jenisKelamin}",
                              style: const TextStyle(fontSize: 13),
                            ),
                            trailing: PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == "edit") {
                                  _openFormPage(student: s, index: index);
                                } else if (value == "delete") {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.warning,
                                                size: 50,
                                                color:
                                                    Colors.redAccent.shade200),
                                            const SizedBox(height: 12),
                                            Text(
                                              "Hapus Data",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red.shade700),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Yakin ingin menghapus data '${s.namaLengkap}'?",
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  child: const Text("Batal"),
                                                ),
                                                ElevatedButton.icon(
                                                  icon: const Icon(Icons.delete),
                                                  label: const Text("Hapus"),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    foregroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    _deleteStudent(index);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            "Data '${s.namaLengkap}' berhasil dihapus"),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (value == "cancel") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Aksi dibatalkan")),
                                  );
                                }
                              },
                              itemBuilder: (context) => const [
                                PopupMenuItem(
                                    value: "edit", child: Text("✏️ Edit")),
                                PopupMenuItem(
                                    value: "delete", child: Text("🗑️ Hapus")),
                                PopupMenuItem(
                                    value: "cancel", child: Text("❌ Batal")),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),

      // Tombol daftar
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.indigo, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => _openFormPage(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text("Daftar", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}