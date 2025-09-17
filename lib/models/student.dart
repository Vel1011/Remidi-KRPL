// lib/models/student.dart
import 'dart:convert';

class Student {
  final String nisn;
  final String namaLengkap;
  final String jenisKelamin;
  final String agama;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String noTelp;
  final String nik;

  // Alamat
  final String jalan;
  final String rtrw;
  final String dusun;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;
  final String negara;
  final String kodePos;

  // Orang Tua / Wali
  final String namaAyah;
  final String namaIbu;
  final String namaWali;
  final String alamatOrtu;

  // Constructor
  Student({
    required this.nisn,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.agama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.noTelp,
    required this.nik,
    required this.jalan,
    required this.rtrw,
    required this.dusun,
    required this.desa,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
    required this.negara,
    required this.kodePos,
    required this.namaAyah,
    required this.namaIbu,
    required this.namaWali,
    required this.alamatOrtu,
  });

  /// Konversi ke Map (misalnya untuk database / API)
  Map<String, dynamic> toMap() {
    return {
      'nisn': nisn,
      'namaLengkap': namaLengkap,
      'jenisKelamin': jenisKelamin,
      'agama': agama,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir.toIso8601String(),
      'noTelp': noTelp,
      'nik': nik,
      'jalan': jalan,
      'rtrw': rtrw,
      'dusun': dusun,
      'desa': desa,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
      'provinsi': provinsi,
      'negara': negara,
      'kodePos': kodePos,
      'namaAyah': namaAyah,
      'namaIbu': namaIbu,
      'namaWali': namaWali,
      'alamatOrtu': alamatOrtu,
    };
  }

  /// Membuat Student dari Map
  /// Mendukung bila map['tanggalLahir'] berupa ISO String atau DateTime
  factory Student.fromMap(Map<String, dynamic> map) {
    // Ambil nilai tanggalLahir dengan fallback ke DateTime.now()
    DateTime tanggal;
    final maybe = map['tanggalLahir'];
    if (maybe is DateTime) {
      tanggal = maybe;
    } else if (maybe is String && maybe.isNotEmpty) {
      tanggal = DateTime.tryParse(maybe) ?? DateTime.now();
    } else {
      tanggal = DateTime.now();
    }

    return Student(
      nisn: map['nisn']?.toString() ?? '',
      namaLengkap: map['namaLengkap']?.toString() ?? '',
      jenisKelamin: map['jenisKelamin']?.toString() ?? '',
      agama: map['agama']?.toString() ?? '',
      tempatLahir: map['tempatLahir']?.toString() ?? '',
      tanggalLahir: tanggal,
      noTelp: map['noTelp']?.toString() ?? '',
      nik: map['nik']?.toString() ?? '',
      jalan: map['jalan']?.toString() ?? '',
      rtrw: map['rtrw']?.toString() ?? '',
      dusun: map['dusun']?.toString() ?? '',
      desa: map['desa']?.toString() ?? '',
      kecamatan: map['kecamatan']?.toString() ?? '',
      kabupaten: map['kabupaten']?.toString() ?? '',
      provinsi: map['provinsi']?.toString() ?? '',
      negara: map['negara']?.toString() ?? '',
      kodePos: map['kodePos']?.toString() ?? '',
      namaAyah: map['namaAyah']?.toString() ?? '',
      namaIbu: map['namaIbu']?.toString() ?? '',
      namaWali: map['namaWali']?.toString() ?? '',
      alamatOrtu: map['alamatOrtu']?.toString() ?? '',
    );
  }

  /// Konversi ke JSON string
  String toJson() => jsonEncode(toMap());

  /// Buat Student dari JSON string
  factory Student.fromJson(String source) =>
      Student.fromMap(jsonDecode(source) as Map<String, dynamic>);

  /// Debugging mudah
  @override
  String toString() {
    return 'Student(nisn: $nisn, namaLengkap: $namaLengkap, jk: $jenisKelamin, agama: $agama, tempatLahir: $tempatLahir, tglLahir: $tanggalLahir, telp: $noTelp, nik: $nik)';
  }
}