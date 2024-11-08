import 'package:app_movies/presentation/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Acount extends StatefulWidget {
  const Acount({super.key});

  @override
  State<Acount> createState() => _AcountState();
}

class _AcountState extends State<Acount> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String? _gender;

  final List<String> _genderOptions = ['Nam', 'Nữ', 'Khác'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(GetUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Thông tin cá nhân',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue.shade700,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade700, Colors.blue.shade100],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  elevation: 8,
                  //user
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.white,

                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is UserSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Thông tin đã được lưu thành công!',
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Colors.green.shade600,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is UserGetState) {
                          // Chỉ set giá trị một lần khi state thay đổi
                          if (_firstNameController.text.isEmpty) {
                            _firstNameController.text = state.firstName;
                            _lastNameController.text = state.lastName;
                            _emailController.text = state.email;
                            _birthdayController.text = state.dob;
                            _gender = state.gender;
                          }
                        }

                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<UserBloc>()
                                    .add(ImageUserEvent(imageUrl: ''));
                              },
                              child: const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Email display

                            // First Name Field
                            TextField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: 'Họ',
                                prefixIcon: const Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Last Name Field
                            TextField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: 'Tên',
                                prefixIcon: const Icon(Icons.person_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Date of Birth Field
                            TextField(
                              controller: _birthdayController,
                              decoration: InputDecoration(
                                labelText: 'Ngày sinh',
                                prefixIcon:
                                    const Icon(Icons.calendar_today_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                            const SizedBox(height: 16),

                            // Gender Dropdown
                            DropdownButtonFormField<String>(
                              value: _gender,
                              decoration: InputDecoration(
                                labelText: 'Giới tính',
                                prefixIcon: const Icon(Icons.people_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade700, width: 2),
                                ),
                              ),
                              items: _genderOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  //trim để xóa khoảng trắng ở đầu và cuối
                                  String firstName =
                                      _firstNameController.text.trim();
                                  String lastName =
                                      _lastNameController.text.trim();
                                  String dob = _birthdayController.text.trim();
                                  String genderValue = _gender!;
                                  String imageUrl = '';

                                  if (state is UserGetState) {
                                    context
                                        .read<UserBloc>()
                                        .add(UpdateUserEvent(
                                          firstName: firstName,
                                          lastName: lastName,
                                          dob: dob,
                                          gender: genderValue,
                                          imageUrl: imageUrl,
                                        ));
                                  } else {
                                    context.read<UserBloc>().add(CreatUserEvent(
                                          firstName: firstName,
                                          lastName: lastName,
                                          dob: dob,
                                          gender: genderValue,
                                          imageUrl: imageUrl,
                                        ));
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Thông tin đã được cập nhật thành công'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Lưu thông tin',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
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
