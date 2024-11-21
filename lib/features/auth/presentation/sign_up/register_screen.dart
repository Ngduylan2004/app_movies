import 'package:app_movies/features/auth/data/datasources/auth_data_source.dart';
import 'package:app_movies/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_movies/features/auth/presentation/sign_in/login_screen.dart';
import 'package:app_movies/features/auth/presentation/sign_up/bloc/signup_bloc.dart';
import 'package:app_movies/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false; // Change to non-final for state updates
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Register',
              style: TextStyle(color: Color(0xff211F30)),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: BlocProvider(
            create: (context) =>
                SignupBloc(AuthRepositoryImpl(AuthDataSourceImpl())),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Register Here',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff211F30),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Username Field
                      TextFormField(
                        controller: _username,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.people),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập vào ô văn bản!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập vào ô văn bản!';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Vui lòng nhập đúng định dạng email!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16.0),
                      // Password Field
                      TextFormField(
                        controller: _passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Vui lòng nhập vào ô văn bản!';
                          }
                          if (value.length < 6) {
                            return 'Vui lòng nhập trên 6 kí tự';
                          }
                          return null;
                        },
                        obscureText: !_isPasswordVisible,
                      ),
                      const SizedBox(height: 20),
                      // Register Button with BlocConsumer
                      BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state is SignupLoading) {
                            setState(() {
                              _isLoading = true; // Start loading
                            });
                          }
                          if (state is SignupFailure) {
                            setState(() {
                              _isLoading = false; // Stop loading on failure
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                          if (state is SignupSuccess) {
                            setState(() {
                              _isLoading = false; // Stop loading on success
                            });
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  // Check form validity
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignupBloc>().add(SignEventOne(
                                          _emailController.text,
                                          _passController.text,
                                          _username.text,
                                        ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffFFC107),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Google Registration Button
                              // ElevatedButton(
                              //   onPressed: () {
                              //     context
                              //         .read<SignupBloc>()
                              //         .add(SignupEventGoogle());
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: const Color(0xffDB4437),
                              //     padding: const EdgeInsets.symmetric(
                              //         vertical: 15, horizontal: 30),
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(12),
                              //     ),
                              //   ),
                              //   child: const Text(
                              //     'Register with Google',
                              //     style: TextStyle(
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.white,
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // Navigation to Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Bạn đã có tài khoản? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFC107),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
