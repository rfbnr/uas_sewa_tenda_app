import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field_widget.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../home/screens/dashboard_route.dart';
import '../bloc/auth_bloc.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.gradient1,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradient2,
                AppColors.gradient1,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpaceHeight(40),
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: double.infinity,
                  height: 200,
                ),
              ),
              SpaceHeight(40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Selamat Datang",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SpaceHeight(10),
                    Text(
                      "Silahkan login untuk melakukan pemesanan sewa tenda untuk kebutuhan camping anda.",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    SpaceHeight(20),
                    CustomTextField(
                      fillColor: AppColors.white,
                      labelColor: AppColors.white,
                      controller: emailController,
                      label: "Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SpaceHeight(20),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final showPassword = state.showPassword;

                        return CustomTextField(
                          fillColor: AppColors.white,
                          labelColor: AppColors.white,
                          controller: passwordController,
                          label: "Kata Sandi",
                          obscureText: showPassword!,
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.grey,
                            ),
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    VisibilityPassword(showPassword),
                                  );
                            },
                          ),
                        );
                      },
                    ),
                    const SpaceHeight(54.0),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state.loginStatus == LoginStatus.loading) {
                          EasyLoading.dismiss();
                          EasyLoading.show(
                            status: "loading...",
                            dismissOnTap: false,
                            maskType: EasyLoadingMaskType.black,
                          );
                        } else if (state.loginStatus == LoginStatus.success) {
                          EasyLoading.dismiss();
                          EasyLoading.showSuccess("Berhasil Login");

                          context.read<AuthBloc>().add(
                                SaveUserLogin(),
                              );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const DashboardRoute();
                            }),
                            (route) => false,
                          );
                        } else if (state.loginStatus == LoginStatus.failure) {
                          final error = state.error!;
                          EasyLoading.dismiss();
                          EasyLoading.showError(error.message!);
                        }
                      },
                      builder: (context, state) {
                        return Button.filled(
                          label: "Masuk",
                          width: double.infinity,
                          color: AppColors.primary,
                          textColor: AppColors.white,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  UserLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                    const SpaceHeight(20.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const RegisterScreen();
                          }),
                        );
                      },
                      child: Center(
                        child: Text(
                          "Belum mempunyai akun? Register disini.",
                          style: TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
