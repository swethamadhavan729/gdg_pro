import 'package:flutter/material.dart';

class VerificationResultScreen extends StatelessWidget {
  final Map<String, String>? voterDetails;

  VerificationResultScreen({required this.voterDetails});

  @override
  Widget build(BuildContext context) {
    bool isMatched = voterDetails != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verification Result"),
        backgroundColor: const Color.fromARGB(255, 26, 115, 232), // AppBar Color Blue
      ),
      body: Container(
        color: const Color.fromARGB(255, 123, 179, 219), // Background color blue
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: isMatched
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        voterDetails!['photo']!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Text("Name: ${voterDetails!['name']}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Voter ID: ${voterDetails!['voterId']}",
                          style: const TextStyle(fontSize: 16)),
                      Text("Aadhar No: ${voterDetails!['aadharNo']}",
                          style: const TextStyle(fontSize: 16)),
                      Text("Phone No: ${voterDetails!['phoneNo']}",
                          style: const TextStyle(fontSize: 16)),
                      Text("D.O.B: ${voterDetails!['dob']}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      const Text(
                        "Verified",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/voterList', (route) => false);
                        },
                        child: const Text("Back to Home"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button Color
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 80),
                      const SizedBox(height: 10),
                      const Text(
                        "Voter can't be identified",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/voterList', (route) => false);
                        },
                        child: const Text("Back to Home"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
