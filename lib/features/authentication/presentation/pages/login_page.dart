import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/common/app_logo.dart';
import '../../../../core/widgets/textfields/custom_text_field.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }
    if (!value.contains("@")) {
      return "Enter a valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
          AuthLoginRequested(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          switch (state.user.role) {
            case "admin":
              context.go("/admin/dashboard");
              break;
            case "lecturer":
              context.go("/lecturer/dashboard");
              break;
            case "student":
              context.go("/student/dashboard");
              break;
            default:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account role not found."),
                ),
              );
          }
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Stack(
  children: [

    //------------------------------------------
    // Premium Background
    //------------------------------------------

    Container(
      decoration: const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFCFDFF),
      Color(0xffF4F8FF),
      Color(0xffEDF4FF),
      Color(0xffE7F0FF),
    ],
    stops: [0.0, .35, .70, 1],
  ),
)
    ),

    //------------------------------------------
    // Top Left Glow
    //------------------------------------------
Positioned(
  top: -220,
  left: -180,
  child: Container(
    width: 520,
    height: 520,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xff4F46E5).withOpacity(.15),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff4F46E5).withOpacity(.20),
          blurRadius: 220,
          spreadRadius: 90,
        ),
      ],
    ),
  ),
),
 
    //------------------------------------------
    // Top Right Glow
    //------------------------------------------

  Positioned(
  top: 160,
  left: 40,
  child: Container(
    width: 10,
    height: 10,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.85),
      shape: BoxShape.circle,
    ),
  ),
),

Positioned(
  top: 260,
  right: 70,
  child: Container(
    width: 14,
    height: 14,
    decoration: BoxDecoration(
      color: const Color(0xff2563EB).withOpacity(.18),
      shape: BoxShape.circle,
    ),
  ),
),

Positioned(
  bottom: 170,
  left: 60,
  child: Container(
    width: 18,
    height: 18,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.75),
      shape: BoxShape.circle,
    ),
  ),
),

    //------------------------------------------
    // Bottom Left Glow
    //------------------------------------------

   Positioned(
  top: -100,
  right: -40,
  child: Container(
    width: 350,
    height: 350,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(.65),
      boxShadow: [
       BoxShadow(
  color: const Color(0xff2563EB).withOpacity(.08),
  blurRadius: 70,
  spreadRadius: 5,
  offset: const Offset(0,35),
),

BoxShadow(
  color: Colors.white.withOpacity(.75),
  blurRadius: 20,
  offset: const Offset(0,-5),
),
      ],
    ),
  ),
),

Positioned(
  top: 130,
  right: 40,
  child: Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(.9),
          Colors.white.withOpacity(.55),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff2563EB).withOpacity(.15),
          blurRadius: 45,
        ),
      ],
    ),
  ),
),

    //------------------------------------------
    // Bottom Right Glow
    //------------------------------------------

Positioned(
  bottom: -250,
  right: -180,
  child: Container(
    width: 540,
    height: 540,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: const Color(0xff2563EB).withOpacity(.12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xff2563EB).withOpacity(.18),
          blurRadius: 220,
          spreadRadius: 90,
        ),
      ],
    ),
  ),
),

Positioned(
  bottom: 150,
  left: 30,
  child: Container(
    height: 110,
    width: 110,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          const Color(0xff60A5FA).withOpacity(.18),
          const Color(0xff2563EB).withOpacity(.05),
        ],
      ),
    ),
  ),
),
    //------------------------------------------
    // Decorative Floating Cards
    //------------------------------------------

    Positioned(
      top: 110,
      left: 30,
      child: Transform.rotate(
        angle: -.35,
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(.22),
            border: Border.all(
              color: Colors.white.withOpacity(.45),
            ),
          ),
        ),
      ),
    ),

    Positioned(
      bottom: 140,
      right: 35,
      child: Transform.rotate(
        angle: .28,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withOpacity(.18),
            border: Border.all(
              color: Colors.white.withOpacity(.45),
            ),
          ),
        ),
      ),
    ),

    Positioned(
      top: 260,
      right: 55,
      child: Transform.rotate(
        angle: -.20,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(.25),
          ),
        ),
      ),
    ),

    //------------------------------------------
    // Login UI
    //------------------------------------------

            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width > 600
                          ? 430
                          : double.infinity,
                    ),
                    child: GlassCard(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 10),

                            const AppLogo(logoSize: 95),

                            const SizedBox(height: 60),

                            const Text(
                              "Welcome Back",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0F172A),
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              "Sign in to continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 35),

                            CustomTextField(
                              controller: emailController,
                              hint: "Email Address",
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: validateEmail,
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                              controller: passwordController,
                              hint: "Password",
                              prefixIcon: Icons.lock_outline,
                              obscureText: obscurePassword,
                              validator: validatePassword,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                                icon: Icon(
                                  obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),

                            const SizedBox(height: 18),

                            Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: rememberMe,
                                        activeColor: const Color(0xFF4F46E5),
                                        onChanged: (value) {
                                          setState(() {
                                            rememberMe = value ?? false;
                                          });
                                        },
                                      ),
                                      const Flexible(
                                        child: Text(
                                          "Remember Me",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Forgot Password feature coming soon.",
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color(0xFF4F46E5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return PrimaryButton(
                                  text: "LOGIN",
                                  icon: Icons.login_rounded,
                                  isLoading: state is AuthLoading,
                                  onPressed: login,
                                );
                              },
                            ),

                            const SizedBox(height: 35),

                            const Divider(color: Colors.black12),

                            const SizedBox(height: 12),

                            const Text(
                              "CampusOne Developed by Abdullah",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 4),

                            const Text(
                              "© 2026 CampusOne",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}