import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app/module/authentication/bloc/authentication_bloc.dart';
import 'package:chat_app/module/authentication/repository/authentication_repository.dart';
import 'package:chat_app/router/app_router.gr.dart';
import 'package:chat_app/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
          child: this,
        ),
      ],
      child: this,
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Flutter Talks",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: 5),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Your Gateway to Conversations",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if(state is AuthenticationSuccess){
                  context.pushRoute(const ChatRoute());
                }
              },
              builder: (context, state) {
                return CustomButton(
                  customHeight: 50,
                  customWidth: MediaQuery.of(context).size.width / 1.7,
                  borderColor: Colors.black,
                  radius: 12,
                  buttonState:
                      state is AuthenticationLoading ? ButtonState.inProgress : ButtonState.normal,
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(const SingInWithGoogleEvent());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ic_google.png',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Signin with Google",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
