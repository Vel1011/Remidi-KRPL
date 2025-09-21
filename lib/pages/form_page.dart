import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/student.dart';
import 'home_page.dart'; // pastikan ada import ini

class FormPage extends StatefulWidget {
  final Function(Student) onSubmit;
  final Student? student;

  const FormPage({super.key, required this.onSubmit, this.student});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  // Controllers
  final nisnCtrl = TextEditingController();
  final namaCtrl = TextEditingController();
  String? jk;
  String? agama;
  final tempatCtrl = TextEditingController();
  DateTime? tglLahir;
  final telpCtrl = TextEditingController();
  final nikCtrl = TextEditingController();

  final jalanCtrl = TextEditingController();
  final rtrwCtrl = TextEditingController();
  final dusunCtrl = TextEditingController();
  final desaCtrl = TextEditingController();
  final kecamatanCtrl = TextEditingController();
  final kabupatenCtrl = TextEditingController();
  final provinsiCtrl = TextEditingController();
  final kodeposCtrl = TextEditingController();

  final ayahCtrl = TextEditingController();
  final ibuCtrl = TextEditingController();
  final waliCtrl = TextEditingController();
  final alamatOrtuCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      nisnCtrl.text = widget.student!.nisn;
      namaCtrl.text = widget.student!.namaLengkap;
      jk = widget.student!.jenisKelamin;
      agama = widget.student!.agama;
      tempatCtrl.text = widget.student!.tempatLahir;
      tglLahir = widget.student!.tanggalLahir;
      telpCtrl.text = widget.student!.noTelp;
      nikCtrl.text = widget.student!.nik;
      jalanCtrl.text = widget.student!.jalan;
      rtrwCtrl.text = widget.student!.rtrw;
      dusunCtrl.text = widget.student!.dusun;
      desaCtrl.text = widget.student!.desa;
      kecamatanCtrl.text = widget.student!.kecamatan;
      kabupatenCtrl.text = widget.student!.kabupaten;
      provinsiCtrl.text = widget.student!.provinsi;
      kodeposCtrl.text = widget.student!.kodePos;
      ayahCtrl.text = widget.student!.namaAyah;
      ibuCtrl.text = widget.student!.namaIbu;
      waliCtrl.text = widget.student!.namaWali;
      alamatOrtuCtrl.text = widget.student!.alamatOrtu;
    }
  }

  Future<List<Map<String, dynamic>>> _getDusunSuggestions(String pattern) async {
    try {
      final res = await supabase
          .from('locations')
          .select()
          .ilike('dusun', '%$pattern%');
      return (res as List).cast<Map<String, dynamic>>();
    } on PostgrestException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error Supabase: ${e.message}")));
      return [];
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tidak ada koneksi internet")));
      return [];
    }
  }

  void _fillAlamat(Map<String, dynamic> data) {
    dusunCtrl.text = data['dusun'] ?? '';
    desaCtrl.text = data['desa'] ?? '';
    kecamatanCtrl.text = data['kecamatan'] ?? '';
    kabupatenCtrl.text = data['kabupaten'] ?? '';
    provinsiCtrl.text = data['provinsi'] ?? '';
    kodeposCtrl.text = data['kode_pos'] ?? '';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        nisn: nisnCtrl.text,
        namaLengkap: namaCtrl.text,
        jenisKelamin: jk ?? "",
        agama: agama ?? "",
        tempatLahir: tempatCtrl.text,
        tanggalLahir: tglLahir ?? DateTime.now(),
        noTelp: telpCtrl.text,
        nik: nikCtrl.text,
        jalan: jalanCtrl.text,
        rtrw: rtrwCtrl.text,
        dusun: dusunCtrl.text,
        desa: desaCtrl.text,
        kecamatan: kecamatanCtrl.text,
        kabupaten: kabupatenCtrl.text,
        provinsi: provinsiCtrl.text,
        negara: "Indonesia",
        kodePos: kodeposCtrl.text,
        namaAyah: ayahCtrl.text,
        namaIbu: ibuCtrl.text,
        namaWali: waliCtrl.text,
        alamatOrtu: alamatOrtuCtrl.text,
      );

      // Kirim data ke HomePage melalui callback
      widget.onSubmit(student);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.student == null
              ? "✅ Data berhasil disimpan"
              : "✏️ Data berhasil diperbarui"),
        ),
      );

      // Langsung kembali ke HomePage
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    for (var ctrl in [
      nisnCtrl,
      namaCtrl,
      tempatCtrl,
      telpCtrl,
      nikCtrl,
      jalanCtrl,
      rtrwCtrl,
      dusunCtrl,
      desaCtrl,
      kecamatanCtrl,
      kabupatenCtrl,
      provinsiCtrl,
      kodeposCtrl,
      ayahCtrl,
      ibuCtrl,
      waliCtrl,
      alamatOrtuCtrl,
    ]) {
      ctrl.dispose();
    }
    super.dispose();
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? "Tambah Siswa" : "Edit Siswa"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Semua widget asli FormPage tetap utuh ===
              // Data Pribadi
              _sectionTitle("Data Pribadi"),
              _buildCard([
                TextFormField(
                  controller: nisnCtrl,
                  decoration: const InputDecoration(
                    labelText: "NISN",
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "NISN wajib diisi";
                    if (v.length != 10) return "NISN harus 10 digit";
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: namaCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nama Lengkap",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) =>
                      v!.isEmpty ? "Nama lengkap wajib diisi" : null,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Jenis Kelamin",
                    prefixIcon: Icon(Icons.people),
                  ),
                  value: jk,
                  validator: (v) => v == null ? "Pilih jenis kelamin" : null,
                  items: ["Laki-laki", "Perempuan"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => jk = val),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Agama",
                    prefixIcon: Icon(Icons.account_balance),
                  ),
                  value: agama,
                  validator: (v) => v == null ? "Pilih agama" : null,
                  items: [
                    "Islam",
                    "Kristen",
                    "Katolik",
                    "Hindu",
                    "Buddha",
                    "Konghucu"
                  ]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => setState(() => agama = val),
                ),
              ]),

              // === Tempat & Tanggal Lahir ===
              _sectionTitle("Tempat & Tanggal Lahir"),
              _buildCard([
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: tempatCtrl,
                        decoration: const InputDecoration(
                          labelText: "Tempat Lahir",
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Tempat lahir wajib diisi" : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: tglLahir ?? DateTime(2010),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => tglLahir = picked);
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: "Tanggal Lahir",
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            tglLahir != null
                                ? "${tglLahir!.day}/${tglLahir!.month}/${tglLahir!.year}"
                                : "Pilih tanggal",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),

              // === Alamat ===
              _sectionTitle("Alamat"),
              _buildCard([
                TextFormField(
                  controller: jalanCtrl,
                  decoration: const InputDecoration(
                    labelText: "Jalan",
                    prefixIcon: Icon(Icons.home),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: rtrwCtrl,
                  decoration: const InputDecoration(
                    labelText: "RT/RW",
                    prefixIcon: Icon(Icons.map),
                  ),
                ),
                const SizedBox(height: 12),
                TypeAheadFormField<Map<String, dynamic>>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: dusunCtrl,
                    decoration: const InputDecoration(
                      labelText: "Dusun",
                      prefixIcon: Icon(Icons.landscape),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await _getDusunSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['dusun'] ?? ''),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _fillAlamat(suggestion);
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: desaCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Desa",
                    prefixIcon: Icon(Icons.villa),
                  ),
                ),
                TextFormField(
                  controller: kecamatanCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Kecamatan",
                    prefixIcon: Icon(Icons.location_on),
                  ),
                ),
                TextFormField(
                  controller: kabupatenCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Kabupaten",
                    prefixIcon: Icon(Icons.apartment),
                  ),
                ),
                TextFormField(
                  controller: provinsiCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Provinsi",
                    prefixIcon: Icon(Icons.flag),
                  ),
                ),
                TextFormField(
                  controller: kodeposCtrl,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: "Kode Pos",
                    prefixIcon: Icon(Icons.local_post_office),
                  ),
                ),
              ]),

              // === Orang Tua / Wali ===
              _sectionTitle("Orang Tua / Wali"),
              _buildCard([
                TextFormField(
                  controller: ayahCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nama Ayah",
                    prefixIcon: Icon(Icons.male),
                  ),
                ),
                TextFormField(
                  controller: ibuCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nama Ibu",
                    prefixIcon: Icon(Icons.female),
                  ),
                ),
                TextFormField(
                  controller: waliCtrl,
                  decoration: const InputDecoration(
                    labelText: "Nama Wali (opsional)",
                    prefixIcon: Icon(Icons.group),
                  ),
                ),
                TextFormField(
                  controller: alamatOrtuCtrl,
                  decoration: const InputDecoration(
                    labelText: "Alamat Orang Tua/Wali",
                    prefixIcon: Icon(Icons.house),
                  ),
                ),
              ]),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submit, // <-- Callback simpan
                  icon: const Icon(Icons.save, color: Colors.white),
                  label: Text(
                    widget.student == null ? "Simpan" : "Update",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}