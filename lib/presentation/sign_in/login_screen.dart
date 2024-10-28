import 'package:app_movies/presentation/home/home_screen.dart';
import 'package:app_movies/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:app_movies/presentation/sign_up/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading =
      false; // Thay đổi thành không final để có thể thay đổi trạng thái
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(color: Color(0xff211F30)),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context) => SignInBloc(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // Gán key cho Form
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Login Here',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff211F30),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Trường nhập email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          fillColor: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ('Vui lòng nhập vào ô văn bản!');
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Vui lòng nhập đúng định dạng email!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    // Trường nhập mật khẩu
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
                          return ('Vui lòng nhập vào ô văn bản!');
                        }
                        if (value.length < 6) {
                          return ('Vui lòng nhập trên 6 kí tự');
                        }
                        return null;
                      },
                      obscureText: !_isPasswordVisible,
                    ),
                    const SizedBox(height: 20),
                    // Nút đăng nhập
                    BlocConsumer<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is SignInLoading) {
                          setState(() {
                            _isLoading = true; // Bắt đầu loading
                          });
                        }
                        if (state is SignInFailure) {
                          setState(() {
                            _isLoading = false; // Dừng loading khi thất bại
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        if (state is SignInSuccess) {
                          setState(() {
                            _isLoading = false; // Dừng loading khi thành công
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () async {
                            // Kiểm tra xem form có hợp lệ không
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInEvent(
                                  _emailController.text, _passController.text));
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
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Về lại đăng kí? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Đăng kí',
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
    );
  }
}
