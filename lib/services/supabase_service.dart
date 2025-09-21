import 'package:supabase_flutter/supabase_flutter.dart';

/// Service Supabase untuk koneksi & query database
class SupabaseService {
  // URL & anon key dari project Supabase
  static const String supabaseUrl = "https://etijjorqofvnhmuwlkxg.supabase.co";
  static const String supabaseKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV0aWpqb3Jxb2Z2bmhtdXdsa3hnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwNTkzODcsImV4cCI6MjA3MzYzNTM4N30.DC9who4AxQHcgvQYA1FVEcbpVNrsVfp6_2NEba4GBtg";

  // Client Supabase
  static final SupabaseClient client =
      SupabaseClient(supabaseUrl, supabaseKey);

  // =========================================
  // SISWA
  // =========================================

  /// Insert data siswa ke tabel `siswa`
  static Future<void> insertStudent(Map<String, dynamic> data) async {
    try {
      await client.from('siswa').insert(data);
    } on PostgrestException catch (e) {
      throw Exception("Gagal insert ke Supabase: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Ambil semua data siswa
  static Future<List<Map<String, dynamic>>> fetchStudents() async {
    try {
      final response = await client.from('siswa').select();
      return response;
    } on PostgrestException catch (e) {
      throw Exception("Gagal ambil data: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Delete siswa by NISN
  static Future<void> deleteStudent(String nisn) async {
    try {
      await client.from('siswa').delete().eq('nisn', nisn);
    } on PostgrestException catch (e) {
      throw Exception("Gagal hapus: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Update data siswa by NISN
  static Future<void> updateStudent(String nisn, Map<String, dynamic> data) async {
    try {
      await client.from('siswa').update(data).eq('nisn', nisn);
    } on PostgrestException catch (e) {
      throw Exception("Gagal update: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Ambil data lengkap siswa + lokasi + orang_tua + wali
  static Future<List<Map<String, dynamic>>> fetchAllData() async {
    try {
      final response = await client
          .from('siswa')
          .select('*, lokasi(*), orang_tua(*), wali(*)');
      return response;
    } on PostgrestException catch (e) {
      throw Exception("Gagal ambil data lengkap: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Stream realtime siswa
  static Stream<List<Map<String, dynamic>>> subscribeStudents() {
    return client.from('siswa').stream(primaryKey: ['nisn']).execute();
  }

  // =========================================
  // LOKASI
  // =========================================

  static Future<List<Map<String, dynamic>>> fetchLokasi() async {
    try {
      final response = await client.from('lokasi').select();
      return response;
    } on PostgrestException catch (e) {
      throw Exception("Gagal ambil lokasi: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Stream realtime lokasi
  static Stream<List<Map<String, dynamic>>> subscribeLokasi() {
    return client.from('lokasi').stream(primaryKey: ['id']).execute();
  }

  // =========================================
  // ORANG TUA
  // =========================================

  static Future<void> insertOrangTua(Map<String, dynamic> data) async {
    try {
      await client.from('orang_tua').insert(data);
    } on PostgrestException catch (e) {
      throw Exception("Gagal insert orang tua: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> fetchOrangTua() async {
    try {
      final response = await client.from('orang_tua').select();
      return response;
    } on PostgrestException catch (e) {
      throw Exception("Gagal ambil orang tua: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Update orang tua
  static Future<void> updateOrangTua(String nik, Map<String, dynamic> data) async {
    try {
      await client.from('orang_tua').update(data).eq('nik', nik);
    } on PostgrestException catch (e) {
      throw Exception("Gagal update orang tua: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Delete orang tua
  static Future<void> deleteOrangTua(String nik) async {
    try {
      await client.from('orang_tua').delete().eq('nik', nik);
    } on PostgrestException catch (e) {
      throw Exception("Gagal hapus orang tua: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Stream realtime orang tua
  static Stream<List<Map<String, dynamic>>> subscribeOrangTua() {
    return client.from('orang_tua').stream(primaryKey: ['nik']).execute();
  }

  // =========================================
  // WALI
  // =========================================

  static Future<void> insertWali(Map<String, dynamic> data) async {
    try {
      await client.from('wali').insert(data);
    } on PostgrestException catch (e) {
      throw Exception("Gagal insert wali: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  static Future<List<Map<String, dynamic>>> fetchWali() async {
    try {
      final response = await client.from('wali').select();
      return response;
    } on PostgrestException catch (e) {
      throw Exception("Gagal ambil wali: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Update wali
  static Future<void> updateWali(String nik, Map<String, dynamic> data) async {
    try {
      await client.from('wali').update(data).eq('nik', nik);
    } on PostgrestException catch (e) {
      throw Exception("Gagal update wali: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Delete wali
  static Future<void> deleteWali(String nik) async {
    try {
      await client.from('wali').delete().eq('nik', nik);
    } on PostgrestException catch (e) {
      throw Exception("Gagal hapus wali: ${e.message}");
    } catch (e) {
      throw Exception("Kesalahan: $e");
    }
  }

  /// Stream realtime wali
  static Stream<List<Map<String, dynamic>>> subscribeWali() {
    return client.from('wali').stream(primaryKey: ['nik']).execute();
  }
}