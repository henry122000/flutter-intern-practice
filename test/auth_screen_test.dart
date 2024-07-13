import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/screens/auth.dart'; 

void main() {
  group('AuthScreen Widget Tests', () {
    testWidgets('AuthScreen has a welcome message and buttons', (WidgetTester tester) async {
      // Build widget and trigger a frame.
      await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

      // Verify the welcome text is displayed.
      expect(find.text('Welcome!'), findsOneWidget);

      // Verify the sign-in button is displayed.
      expect(find.text('Sign in'), findsOneWidget);

      // Tap the create account button and verify the state changes.
      await tester.tap(find.text('Create an account'));
      await tester.pump();

      // Verify the sign-up button is displayed.
      expect(find.text('Sign up'), findsOneWidget);

      // Tap the "I already have an account!" button and verify the state changes back.
      await tester.tap(find.text('I already have an account!'));
      await tester.pump();

      // Verify the sign-in button is displayed again.
      expect(find.text('Sign in'), findsOneWidget);
    });

    testWidgets('AuthScreen form validation and submission', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AuthScreen()));

      // Find the email and password fields.
      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;
      final signInButton = find.text('Sign in');

      // Enter invalid email and password.
      await tester.enterText(emailField, 'invalidemail');
      await tester.enterText(passwordField, 'short');
      await tester.tap(signInButton);
      await tester.pump();

      // Verify validation errors are shown.
      expect(find.text('Please enter a valid email address.'), findsOneWidget);
      expect(find.text('Password should be at least 8 characters long'), findsOneWidget);

      // Enter valid email and password.
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.tap(signInButton);
      await tester.pump();

      // No validation errors should be shown.
      expect(find.text('Please enter a valid email address.'), findsNothing);
      expect(find.text('Password should be at least 8 characters long'), findsNothing);
    });
  });
}