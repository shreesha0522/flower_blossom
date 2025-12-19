// import 'package:flutter/material.dart';

// class AboutScreen extends StatefulWidget {
//   final String userName; // Logged-in user's name

//   const AboutScreen({super.key, required this.userName});

//   @override
//   State<AboutScreen> createState() => _AboutScreenState();
// }

// class _AboutScreenState extends State<AboutScreen> {
//   String selectedCountry = 'Nepal';
//   bool isDarkMode = false;
//   final TextEditingController feedbackController = TextEditingController();

//   void _chooseCountry() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//           title: const Text('Select Country'),
//           children: [
//             _countryOption('Australia', '🇦🇺'),
//             _countryOption('Nepal', '🇳🇵'),
//             _countryOption('UK', '🇬🇧'),
//             _countryOption('USA', '🇺🇸'),
//             _countryOption('Canada', '🇨🇦'),
//             _countryOption('India', '🇮🇳'),
//             _countryOption('Japan', '🇯🇵'),
//             _countryOption('Germany', '🇩🇪'),
//             _countryOption('France', '🇫🇷'),
//             _countryOption('China', '🇨🇳'),
//           ],
//         );
//       },
//     );
//   }

//   SimpleDialogOption _countryOption(String country, String flag) {
//     return SimpleDialogOption(
//       onPressed: () {
//         setState(() => selectedCountry = country);
//         Navigator.pop(context);
//       },
//       child: Row(
//         children: [
//           Text(flag, style: const TextStyle(fontSize: 18)),
//           const SizedBox(width: 8),
//           Text(country),
//         ],
//       ),
//     );
//   }

//   void _showAccountInfo() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Account Information'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Name: ${widget.userName}'),
//             const SizedBox(height: 4),
//             const Text('Membership: Premium'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showPolicies() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Policies'),
//         content: const Text(
//           '1. Privacy Policy: Your data is safe.\n'
//           '2. Terms of Service: Use the app responsibly.\n'
//           '3. Refund Policy: Orders can be refunded within 7 days.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showHelp() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Help'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text('• To browse flowers, use the Home screen.'),
//             SizedBox(height: 4),
//             Text('• To place an order, select a flower and go to Payment.'),
//             SizedBox(height: 4),
//             Text('• To edit your profile, go to Account Information.'),
//             SizedBox(height: 4),
//             Text('• For any issues, contact support@example.com.'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showFeedback() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Feedback'),
//         content: TextField(
//           controller: feedbackController,
//           maxLines: 4,
//           decoration: const InputDecoration(
//             hintText: 'Enter your feedback here',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final feedback = feedbackController.text.trim();
//               if (feedback.isNotEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Feedback submitted!')),
//                 );
//                 feedbackController.clear();
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Submit'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: isDarkMode ? Colors.grey[900] : const Color(0xFFFCE4EC),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.person, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Account Information'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: _showAccountInfo,
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.public, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Country'),
//                   subtitle: Text(selectedCountry),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: _chooseCountry,
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.dark_mode, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Dark Mode'),
//                   trailing: Switch(
//                     value: isDarkMode,
//                     onChanged: (val) {
//                       setState(() {
//                         isDarkMode = val;
//                       });
//                     },
//                   ),
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.policy, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Policies'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: _showPolicies,
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.help, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Help'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: _showHelp,
//                 ),
//                 const Divider(),

//                 ListTile(
//                   leading: const Icon(Icons.feedback, color: Color.fromARGB(255, 229, 128, 162)),
//                   title: const Text('Feedback'),
//                   trailing: const Icon(Icons.arrow_forward_ios),
//                   onTap: _showFeedback,
//                 ),
//                 const Divider(),
//               ],
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context); // Go back to login/dashboard
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 229, 128, 162),
//                 foregroundColor: Colors.black,
//                 minimumSize: const Size(double.infinity, 48),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Logout',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
