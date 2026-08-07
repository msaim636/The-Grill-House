import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/models/seat_model.dart';

class SupabaseServices {
  final supabase = Supabase.instance.client;
  //Add Seat
  Future<void> addSeat(Map<String, dynamic> data) async {
    await supabase.from('seats').insert(data);
  }
  //Fetch Seat

  Future<List<SeatModel>> getSeat() async {
    final response = await supabase.from('seats').select();

    return response.map<SeatModel>((e) => SeatModel.fromJson(e)).toList();
  }
}
