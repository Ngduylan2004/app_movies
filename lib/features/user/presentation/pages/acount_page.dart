import 'package:app_movies/core/utils/base_screen.dart';
import 'package:app_movies/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcountPage extends StatefulWidget {
  const AcountPage({super.key});

  @override
  State<AcountPage> createState() => _AcountPageState();
}

class _AcountPageState extends State<AcountPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  String? _gender;
  final List<String> _genderOptions = ['Nam', 'Nữ', 'Khác'];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocProvider(
        create: (context) => UserBloc()..add(GetUserEvent()),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              AppLocalizations.of(context)!.profileTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue.shade700,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.blue.shade100],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: BlocConsumer<UserBloc, UserState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is UserGetState) {
                            if (_firstNameController.text.isEmpty) {
                              _firstNameController.text = state.firstName;
                              _lastNameController.text = state.lastName;
                              _emailController.text = state.email;
                              _birthdayController.text = state.dob;
                              _gender = state.gender;
                            }
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.blue.shade100,
                                      child: const CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          Icons.person,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade700,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              TextField(
                                controller: _firstNameController,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.firstName,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade700,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _lastNameController,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.lastName,
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade700,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextField(
                                controller: _birthdayController,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.birthday,
                                  prefixIcon:
                                      const Icon(Icons.calendar_today_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade700,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                              const SizedBox(height: 20),
                              DropdownButtonFormField<String>(
                                value: _gender,
                                decoration: InputDecoration(
                                  labelText:
                                      AppLocalizations.of(context)!.gender,
                                  prefixIcon: const Icon(Icons.people_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.blue.shade700,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
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
                              const SizedBox(height: 32),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade700,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  String firstName =
                                      _firstNameController.text.trim();
                                  String lastName =
                                      _lastNameController.text.trim();
                                  String dob = _birthdayController.text.trim();
                                  String genderValue = _gender ?? '';
                                  String imageUrl = '';

                                  if (state is UserGetState) {
                                    context.read<UserBloc>().add(
                                          UpdateUserEvent(
                                            firstName: firstName,
                                            lastName: lastName,
                                            dob: dob,
                                            gender: genderValue,
                                            imageUrl: imageUrl,
                                          ),
                                        );
                                  } else {
                                    context.read<UserBloc>().add(
                                          CreatUserEvent(
                                            firstName: firstName,
                                            lastName: lastName,
                                            dob: dob,
                                            gender: genderValue,
                                            imageUrl: imageUrl,
                                          ),
                                        );
                                  }

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Thông tin đã được cập nhật thành công',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      backgroundColor: Colors.green.shade600,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.saveButton,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
