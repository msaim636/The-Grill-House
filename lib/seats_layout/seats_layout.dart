import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/add_seat/add_seat.dart';
import 'package:desk_flow/models/seat_model.dart';
import 'package:desk_flow/services/supabase_services.dart';
import 'package:desk_flow/widget/seat.dart';

class SeatsLayout extends StatefulWidget {
  const SeatsLayout({super.key});

  @override
  State<SeatsLayout> createState() => _SeatsLayoutState();
}

class _SeatsLayoutState extends State<SeatsLayout> {
  Widget get addSeatButton => ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddSeat(), // Destination screen
        ),
      );
    },
    child: const Text('Add Seat'),
  );

  List<SeatModel> seatList = [];
  void fetchSeat() async {
    try {
      final data = await SupabaseServices().getSeat();
      setState(() => seatList = data);
    } catch (e) {}
  }

  late Future<Map<String, dynamic>> _profileFuture;

  @override
  void initState() {
    super.initState();
    Supabase.instance.client.from('seats').stream(primaryKey: ['id']).listen((
      data,
    ) {
      setState(() {
        seatList = data.map((e) => SeatModel.fromJson(e)).toList();
      });
    });
    _profileFuture = Supabase.instance.client
        .from('profiles')
        .select('role')
        .eq('id', Supabase.instance.client.auth.currentUser!.id)
        .single();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F7FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Separates title and button nicely
                children: [
                  const Text(
                    'Seats Layout',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: _profileFuture,
                    builder: (context, snapshot) {
                      // 1. Constrain the indicator so it doesn't break your horizontal layout
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }

                      // 2. Return button if user is authenticated as admin
                      if (snapshot.hasData &&
                          snapshot.data!['role'] == 'admin') {
                        return addSeatButton;
                      }

                      // 3. MANDATORY: Return empty widget if user is not admin or query fails
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),

              //Type Bar
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Available
                    Row(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xff0D8D37),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Available',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    //Reserved
                    Row(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xffFA476D),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Reserved',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    //Your Seat
                    Row(
                      children: [
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            color: const Color(0xff6C36C3),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Your Seat',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: seatList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // 4 items per horizontal row
                    crossAxisSpacing:
                        10, // Horizontal spacing between grid items

                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: ((context, index) {
                    return Seat(seat: seatList[index]);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
