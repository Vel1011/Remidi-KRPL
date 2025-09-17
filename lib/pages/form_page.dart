import 'package:flutter/material.dart';
import '../models/student.dart';

class FormPage extends StatefulWidget {
  final Function(Student) onSubmit;

  const FormPage({super.key, required this.onSubmit});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

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
  final negaraCtrl = TextEditingController();
  final kodeposCtrl = TextEditingController();

  final ayahCtrl = TextEditingController();
  final ibuCtrl = TextEditingController();
  final waliCtrl = TextEditingController();
  final alamatOrtuCtrl = TextEditingController();

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
        negara: negaraCtrl.text,
        kodePos: kodeposCtrl.text,
        namaAyah: ayahCtrl.text,
        namaIbu: ibuCtrl.text,
        namaWali: waliCtrl.text,
        alamatOrtu: alamatOrtuCtrl.text,
      );
      widget.onSubmit(student);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data berhasil disimpan")),
      );

      _formKey.currentState!.reset();
      // Bersihkan semua field
      nisnCtrl.clear();
      namaCtrl.clear();
      tempatCtrl.clear();
      telpCtrl.clear();
      nikCtrl.clear();
      jalanCtrl.clear();
      rtrwCtrl.clear();
      dusunCtrl.clear();
      desaCtrl.clear();
      kecamatanCtrl.clear();
      kabupatenCtrl.clear();
      provinsiCtrl.clear();
      negaraCtrl.clear();
      kodeposCtrl.clear();
      ayahCtrl.clear();
      ibuCtrl.clear();
      waliCtrl.clear();
      alamatOrtuCtrl.clear();

      setState(() {
        jk = null;
        agama = null;
        tglLahir = null;
      });
    }
  }

  @override
  void dispose() {
    // Buang controller agar tidak memory leak
    nisnCtrl.dispose();
    namaCtrl.dispose();
    tempatCtrl.dispose();
    telpCtrl.dispose();
    nikCtrl.dispose();
    jalanCtrl.dispose();
    rtrwCtrl.dispose();
    dusunCtrl.dispose();
    desaCtrl.dispose();
    kecamatanCtrl.dispose();
    kabupatenCtrl.dispose();
    provinsiCtrl.dispose();
    negaraCtrl.dispose();
    kodeposCtrl.dispose();
    ayahCtrl.dispose();
    ibuCtrl.dispose();
    waliCtrl.dispose();
    alamatOrtuCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Formulir PPDB", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            TextFormField(
              controller: nisnCtrl,
              decoration: const InputDecoration(
                labelText: "NISN",
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
            ),
            TextFormField(
              controller: namaCtrl,
              decoration: const InputDecoration(
                labelText: "Nama Lengkap",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v!.isEmpty ? "Wajib diisi" : null,
            ),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Jenis Kelamin",
                prefixIcon: Icon(Icons.people),
              ),
              value: jk,
              items: ["Laki-laki", "Perempuan"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => jk = val),
            ),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Agama",
                prefixIcon: Icon(Icons.account_balance),
              ),
              value: agama,
              items: ["Islam", "Kristen", "Katolik", "Hindu", "Buddha", "Konghucu"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => agama = val),
            ),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: tempatCtrl,
                    decoration: const InputDecoration(
                      labelText: "Tempat Lahir",
                      prefixIcon: Icon(Icons.location_city),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2010),
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

            TextFormField(
              controller: telpCtrl,
              decoration: const InputDecoration(
                labelText: "No. Telp/HP",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            TextFormField(
              controller: nikCtrl,
              decoration: const InputDecoration(
                labelText: "NIK",
                prefixIcon: Icon(Icons.credit_card),
              ),
            ),

            const SizedBox(height: 16),
            const Text("Alamat", style: TextStyle(fontWeight: FontWeight.bold)),

            TextFormField(
              controller: jalanCtrl,
              decoration: const InputDecoration(
                labelText: "Jalan",
                prefixIcon: Icon(Icons.home),
              ),
            ),
            TextFormField(
              controller: rtrwCtrl,
              decoration: const InputDecoration(
                labelText: "RT/RW",
                prefixIcon: Icon(Icons.map),
              ),
            ),
            TextFormField(
              controller: dusunCtrl,
              decoration: const InputDecoration(
                labelText: "Dusun",
                prefixIcon: Icon(Icons.landscape),
              ),
            ),
            TextFormField(
              controller: desaCtrl,
              decoration: const InputDecoration(
                labelText: "Desa",
                prefixIcon: Icon(Icons.villa),
              ),
            ),
            TextFormField(
              controller: kecamatanCtrl,
              decoration: const InputDecoration(
                labelText: "Kecamatan",
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            TextFormField(
              controller: kabupatenCtrl,
              decoration: const InputDecoration(
                labelText: "Kabupaten",
                prefixIcon: Icon(Icons.apartment),
              ),
            ),
            TextFormField(
              controller: provinsiCtrl,
              decoration: const InputDecoration(
                labelText: "Provinsi",
                prefixIcon: Icon(Icons.flag),
              ),
            ),
            TextFormField(
              controller: negaraCtrl,
              decoration: const InputDecoration(
                labelText: "Negara",
                prefixIcon: Icon(Icons.public),
              ),
            ),
            TextFormField(
              controller: kodeposCtrl,
              decoration: const InputDecoration(
                labelText: "Kode Pos",
                prefixIcon: Icon(Icons.local_post_office),
              ),
            ),

            const SizedBox(height: 16),
            const Text("Orang Tua/Wali", style: TextStyle(fontWeight: FontWeight.bold)),

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
                labelText: "Nama Wali",
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

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.save),
              label: const Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}