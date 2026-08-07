import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/models/seat_model.dart';
import 'package:desk_flow/services/supabase_services.dart';

class AddSeat extends StatefulWidget {
  const AddSeat({super.key});

  @override
  State<AddSeat> createState() => _AddSeatState();
}

class _AddSeatState extends State<AddSeat> {
  final seat_number = TextEditingController();
  String _selectedStatus = 'available';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5A289E),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                'Add Seat',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),

              child: Icon(
                Icons.chair_rounded,
                color: Color(0xff5A289E),
                size: 50,
              ),
            ),
            SizedBox(height: 50),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //SeatNumber
                Row(
                  children: [
                    SizedBox(width: 14),
                    Text(
                      "Seat Number",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: seat_number,
                    decoration: const InputDecoration(
                      hintText: 'e.g. B01',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 160, 160),
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: Color(0xffFEFCFA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 226, 224, 224),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 226, 224, 224),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color(0xffF56A14),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //Seat Status
                Row(
                  children: [
                    SizedBox(width: 14),
                    Text(
                      "Seat Status",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width - 16,
                    initialSelection: _selectedStatus,
                    hintText: "Select Seat Status",

                    inputDecorationTheme: const InputDecorationTheme(
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 163, 160, 160),
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: Color(0xffFEFCFA),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 226, 224, 224),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 226, 224, 224),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                        borderSide: BorderSide(
                          color: Color(0xffF56A14),
                          width: 1,
                        ),
                      ),
                    ),

                    onSelected: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedStatus = value;
                        });
                      }
                    },

                    dropdownMenuEntries: const [
                      DropdownMenuEntry<String>(
                        value: 'available',
                        label: 'Available',
                        leadingIcon: Icon(
                          Icons.circle,
                          color: Color(0xff0D8D37),
                          size: 12,
                        ),
                      ),
                      DropdownMenuEntry<String>(
                        value: 'reserved',
                        label: 'Reserved',
                        leadingIcon: Icon(
                          Icons.circle,
                          color: Color(0xffFA476D),
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (seat_number.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill required fields"),
                            ),
                          );
                          return;
                        }
                        SeatModel newSeat = SeatModel(
                          seatNumber: seat_number.text.trim(),
                          seatStatus: _selectedStatus,
                          user_id:
                              Supabase.instance.client.auth.currentUser!.id,
                        );
                        print(newSeat.toJson());
                        await SupabaseServices().addSeat(newSeat.toJson());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Seat Added Successfully")),
                        );

                        Navigator.pop(context);
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("Error: $e")));
                      }
                    },

                    child: Center(
                      child: Text(
                        'Save Seat',
                        style: TextStyle(
                          color: Color(0xff5A289E),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
