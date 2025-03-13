import 'package:flutter/material.dart';

class VoterDetailScreen extends StatefulWidget {
  final String voterName;
  final String voterId;
  final String status;

  VoterDetailScreen({
    required this.voterName,
    required this.voterId,
    required this.status,
  });

  @override
  _VoterDetailScreenState createState() => _VoterDetailScreenState();
}

class _VoterDetailScreenState extends State<VoterDetailScreen> {
  String status = '';

  Map<String, dynamic> voterDetails = {
    '101219': {
      'photo':'lib/assets/swetha.jpg',
      'gender': 'Female',
      'aadhar': '1234-5678-9012',
      'phone': '9876543210',
      'dob': '12-05-1990'
    },
    '101202': {
      'photo': 'assets/voter2.jpg',
      'gender': 'Male',
      'aadhar': '2345-6789-0123',
      'phone': '8765432109',
      'dob': '01-02-1985'
    },
  };

  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  void verifyVoter() {
    setState(() {
      status = '✓';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Voter Verified Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final voter = voterDetails[widget.voterId] ?? {};
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voter Details"),
      ),
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: voter['photo'] != null
                        ? AssetImage(voter['photo'])
                        : const AssetImage('assets/default.png'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.voterName,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text("Voter ID: ${widget.voterId}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Gender: ${voter['gender'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Aadhar No: ${voter['aadhar'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Phone No: ${voter['phone'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("D.O.B: ${voter['dob'] ?? 'N/A'}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Text(
                    "Status: $status",
                    style: TextStyle(
                      fontSize: 20,
                      color: status == '✓' ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: status == '✓' ? null : verifyVoter,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

