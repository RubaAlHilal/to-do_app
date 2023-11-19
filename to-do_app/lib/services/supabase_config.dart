import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseIntegeration {
  get getSupabaseInitialize async {
    final supabaseInitialize = await Supabase.initialize(
      url: dotenv.env['url'].toString(),
      anonKey: dotenv.env['anonKey'].toString(),
    );
    return supabaseInitialize;
  }
}

SupabaseClient get getSupabase {
  final supabase = Supabase.instance.client;
  return supabase;
}

// supabaseConfig() async {

//   await Supabase.initialize(
//     url: "https://zkidhsvhkjshockssdec.supabase.co",
//     anonKey:
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpraWRoc3Zoa2pzaG9ja3NzZGVjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk3NzcyMTQsImV4cCI6MjAxNTM1MzIxNH0.3AqZboq5v9C35jZX5IY1qdR8Xve6gHXQn5HaGFwOuW8",
//   );
// }
