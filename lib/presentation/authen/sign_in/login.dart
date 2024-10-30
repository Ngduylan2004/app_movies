// import 'package:app_movies/presentation/home/home_screen.dart';
// import 'package:app_movies/presentation/sign_in/bloc/sign_in_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_overlay/loading_overlay.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;
//   final bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff211F30),
//       appBar: AppBar(
//         title: const Text(
//           'Login',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xff211F30),
//       ),
//       body: BlocProvider(
//         create: (context) => SignInBloc(),
//         child: LoadingOverlay(
//           isLoading: _isLoading,
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                       prefixIcon: Icon(Icons.email),
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return ('vui lòng nhập vào ô text!');
//                       }
//                       if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                         return 'Vui lòng nhập đúng định dạng email!';
//                       }
//                       return null;
//                     },
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 16.0),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       prefixIcon: const Icon(Icons.lock),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _isPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _isPasswordVisible = !_isPasswordVisible;
//                           });
//                         },
//                       ),
//                       border: const OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return ('vui lòng nhập vào ô text!');
//                       }
//                       if (value.length < 6) {
//                         return ('vui lòng nhập trên 6 kí tự');
//                       }
//                       return null;
//                     },
//                     obscureText: !_isPasswordVisible,
//                   ),
//                   const SizedBox(height: 24.0),
//                   BlocConsumer<SignInBloc, SignInState>(
//                     listener: (context, state) {
//                       if (state is SignInFailure) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(state.error),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                       if (state is SignInSuccess) {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const HomeScreen(),
//                           ),
//                         );
//                       }
//                     },
//                     builder: (context, state) {
//                       if (state is SignInLoading) {
//                         // Hiển thị loading khi đang đăng nhập
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       return ElevatedButton(
//                         onPressed: () async {
//                           // Check if the form is valid
//                           if (_formKey.currentState!.validate()) {
//                             context.read<SignInBloc>().add(SignInEvent(
//                                 _emailController.text,
//                                 _passwordController.text));
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xffFFC107),
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 30),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:app_movies/presentation/home/home_screen.dart';
// import 'package:app_movies/presentation/sign_in/login_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class RootPage extends StatelessWidget {
//   const RootPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (_, snapshot) {
//           if (snapshot.data == null) {
//             return const LoginScreen();
//           } else {
//             return const HomeScreen();
//           }
//         });
//   }
// }
// xem lại authStateChanges(), và xem streem lays từ firebase luôn k càn tự set
