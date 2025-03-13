import 'package:flutter/material.dart';
import 'camera_screen.dart';
import 'voter_detail_screen.dart';

class VoterListScreen extends StatefulWidget {
  @override
  _VoterListScreenState createState() => _VoterListScreenState();
}

class _VoterListScreenState extends State<VoterListScreen> {
  List<Map<String, String>> voters = [
    {'name': 'Indhu', 'id': '101201', 'status': '✗'},
    {'name': 'Jai', 'id': '101202', 'status': '✗'},
    {'name': 'Ishu', 'id': '101203', 'status': '✓'},
    {'name': 'Menaka', 'id': '101204', 'status': '✓'},
    {'name': 'Malathi', 'id': '101205', 'status': '✗'},
    {'name': 'Kani', 'id': '101206', 'status': '✓'},
    {'name': 'Gangesh', 'id': '101207', 'status': '✗'},
    {'name': 'Roshan', 'id': '101208', 'status': '✓'},
    {'name': 'Abi', 'id': '101209', 'status': '✓'},
    {'name': 'Yuvan', 'id': '101210', 'status': '✗'},
    {'name': 'Barath', 'id': '101211', 'status': '✓'},
    {'name': 'Sri', 'id': '101212', 'status': '✗'},
    {'name': 'Maha', 'id': '101213', 'status': '✓'},
    {'name': 'Prithiga', 'id': '101214', 'status': '✓'},
    {'name': 'Mithran', 'id': '101215', 'status': '✗'},
    {'name': 'Mathavan', 'id': '101216', 'status': '✓'},
    {'name': 'Anusuya', 'id': '101217', 'status': '✗'},
    {'name': 'Rohini', 'id': '101218', 'status': '✓'},
    {'name': 'Swetha', 'id': '101219', 'status': '✓'},
    {'name': 'Sophia', 'id': '101220', 'status': '✗'},
  ];

  String searchQuery = '';

  void updateVoterStatus(String voterId) {
    setState(() {
      for (var voter in voters) {
        if (voter['id'] == voterId) {
          voter['status'] = '✓';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Voters List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search Voter...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80), // Extra space for the button
              itemCount: voters.length,
              itemBuilder: (context, index) {
                final voter = voters[index];
                if (searchQuery.isNotEmpty &&
                    !voter['name']!.toLowerCase().contains(searchQuery) &&
                    !voter['id']!.contains(searchQuery)) {
                  return const SizedBox.shrink();
                }
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    title: Text(voter['name']!, style: const TextStyle(color: Colors.black)),
                    subtitle: Text("Voter ID: ${voter['id']!}", style: const TextStyle(color: Colors.black54)),
                    trailing: Text(
                      voter['status']!,
                      style: TextStyle(
                        fontSize: 20,
                        color: voter['status'] == '✓' ? Colors.green : Colors.red,
                      ),
                    ),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VoterDetailScreen(
                            voterName: voter['name']!,
                            voterId: voter['id']!,
                            status: voter['status']!,
                          ),
                        ),
                      );
                      if (result == true) {
                        updateVoterStatus(voter['id']!);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.blue.shade200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CameraScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text(
                "Open Camera",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
