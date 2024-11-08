// import 'package:app_movies/presentation/user/acount.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatelessWidget {
//   const Profile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         centerTitle: true,
//         title: const Text('Profile', style: TextStyle(color: Colors.white)),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Ảnh đại diện
//               const CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(
//                   'https://via.placeholder.com/150', // Thay bằng URL ảnh đại diện
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               // Tên người dùng
//               const Text(
//                 'Nguyễn Duy Lan',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8.0),
//               // Email
//               const Text(
//                 'email@example.com',
//                 style: TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 8.0),
//               // Số điện thoại
//               const Text(
//                 '+84 123 456 789',
//                 style: TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 16.0),
//               // Gói đăng ký
//               const Text(
//                 'Gói đăng ký: VIP',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 32.0),
//               // Thông tin bổ sung
//               const Text(
//                 'Mô tả: Tôi là một nhà phát triển ứng dụng di động với niềm đam mê tạo ra các ứng dụng chất lượng.',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16.0),
//               // Địa chỉ
//               const Text(
//                 'Địa chỉ: 123 Đường ABC, Quận 1, TP.HCM',
//                 style: TextStyle(fontSize: 14, color: Colors.grey),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16.0),
//               // Nút đăng xuất
//               ElevatedButton(
//                 onPressed: () {
//                   // Hành động đăng xuất
//                 },
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const Acount()));
//                     },
//                     child: const Text('Update Profile')),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
