import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/component.dart';
import '../data/sample_components.dart';

class ApiService {
  // Ganti dengan base URL backend Anda jika sudah ada, misal: 'https://api.perusahaananda.com'
  static const String baseUrl = 'https://jsonplaceholder.typicode.com'; 

  /// Mengambil daftar komponen dari backend.
  /// Sementara menggunakan dummy fallback jika belum ada endpoint beneran.
  Future<List<Component>> fetchComponents() async {
    try {
      // Contoh request sebenarnya:
      // final response = await http.get(Uri.parse('$baseUrl/components'));
      
      // Karena belum ada API beneran, kita simulasi network delay selama 1.5 detik
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Simulasi seolah-olah mendapat response json:
      // if (response.statusCode == 200) {
      //   List jsonResponse = json.decode(response.body);
      //   return jsonResponse.map((data) => Component.fromJson(data)).toList();
      // } else {
      //   throw Exception('Gagal memuat komponen');
      // }

      // Mengembalikan data statis sebagai ganti API sungguhan:
      return sampleComponents;
      
    } catch (e) {
      // Jika error (misal no internet), kita throw exception
      throw Exception('Gagal terhubung ke server: $e');
    }
  }
}
