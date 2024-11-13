// import 'package:app_movies/presentation/user/acount.dart';
// import 'package:app_movies/presentation/user/bloc/user_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Profile extends StatefulWidget {
//   const Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();

//   final TextEditingController _birthdayController = TextEditingController();

//   String? _gender; // Variable to store gender value

//   final List<String> _genderOptions = ['Nam', 'Nữ', 'Khác']; // Gender options

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UserBloc()..add(GetUserEvent()),
//       child: Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.amber),
//           title: const Text(
//             'Profile',
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.blueAccent,
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: ListView(
//               children: [
//                 const SizedBox(height: 16),
//                 Card(
//                   elevation: 5,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: BlocConsumer<UserBloc, UserState>(
//                       listener: (context, state) {},
//                       builder: (context, state) {
//                         if (state is UserLoading) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         } else if (state is UserGetState) {
//                           // Khi dữ liệu đã được tải thành công
//                           return Column(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(90),
//                                 child: Image.asset(
//                                   'assets/images/anh3.png',
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               const SizedBox(height: 10),
//                               Text(
//                                 state.email, // Lấy email từ trạng thái
//                                 style: const TextStyle(fontSize: 18),
//                               ),
//                             ],
//                           );
//                         }

//                         // Trường hợp không có dữ liệu
//                         return const Center(child: Text('No user data found.'));
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // TextField for First Name
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     controller: _firstNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'First Name',
//                       prefixIcon: Icon(Icons.people),
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blueAccent),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // TextField for Last Name
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     controller: _lastNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Last Name',
//                       prefixIcon: Icon(Icons.people),
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blueAccent),
//                       ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // TextField for Date of Birth
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: TextField(
//                     controller: _birthdayController,
//                     decoration: const InputDecoration(
//                       labelText: 'Date of Birth',
//                       prefixIcon: Icon(Icons.calendar_today),
//                       border: OutlineInputBorder(),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blueAccent),
//                       ),
//                     ),
//                     keyboardType: TextInputType.datetime,
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // Dropdown for Gender
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: DropdownButtonFormField<String>(
//                     value: _gender,
//                     decoration: const InputDecoration(
//                       labelText: 'Gender',
//                       border: OutlineInputBorder(),
//                     ),
//                     items: _genderOptions.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _gender = value; // Update the selected gender
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 ElevatedButton(
//                   onPressed: () {
//                     // Hành động đăng xuất
//                   },
//                   child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Acount()));
//                       },
//                       child: const Text('Update Profile')),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
