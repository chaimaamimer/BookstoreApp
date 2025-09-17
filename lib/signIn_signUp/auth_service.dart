import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  //signin with email and password
  Future<AuthResponse> signInWithPassword({required String email, required String password})  async {
    return await supabase.auth.signInWithPassword(email: email, password: password);
  }
  //signup with email and password
  Future<AuthResponse> signUpWithPassword({required String email, required String password}) async {
    return await supabase.auth.signUp(email: email, password: password);
  }
}