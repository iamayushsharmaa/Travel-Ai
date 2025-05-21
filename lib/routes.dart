import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:triptide/screens/auth/onboarding_page.dart';
import 'package:triptide/screens/auth/signin_page.dart';
import 'package:triptide/screens/home/home.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: OnBoardingPage()),
  },
);

final loggedInRoute = RouteMap(
    routes: {
      '/': (_) => const MaterialPage(child: HomePage()),
    }
);