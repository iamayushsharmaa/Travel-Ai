import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/auth/provider/auth_providers.dart';

import '../models/user_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isUpdating = false;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userInfoProvider)!;
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController(text: user.password);
  }

  void updateFields(UserModel user) {
    nameController.text = user.name!;
    emailController.text = user.email;
    passwordController.text = user.password!;
  }

  void updateUserData() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    ref
        .read(authStateNotifierProvider.notifier)
        .updateUserData(name, email, password);

    print(isUpdating);
    setState(() {
      isUpdating = false;
    });
    print(isUpdating);
  }

  void signOut() {
    ref.read(authStateNotifierProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    final userDataAsync = ref.watch(userDataProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey.shade100,
        elevation: 0.5,
        leading:
            isUpdating
                ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                  },
                )
                : IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => context.pop(),
                ),
        actions: [
          isUpdating
              ? IconButton(
                icon: const Icon(Icons.check),
                onPressed: () => updateUserData(),
              )
              : IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  userDataAsync.whenData((user) {
                    updateFields(user);
                    setState(() => isUpdating = true);
                  });
                },
              ),
        ],
      ),
      body: userDataAsync.when(
        data: (user) {
          updateFields(user);
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 76,
                  backgroundImage:
                      user.profilePic != null && user.profilePic!.isNotEmpty
                          ? NetworkImage(user.profilePic!)
                          : const AssetImage('assets/images/travel.jpg')
                              as ImageProvider,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  readOnly: !isUpdating,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController, // FIXED
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  obscureText: true,
                  readOnly: !isUpdating,
                ),
                const SizedBox(height: 25),
                isUpdating
                    ? const SizedBox()
                    : SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => signOut(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
