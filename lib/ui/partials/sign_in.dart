import 'package:flutter/material.dart';
import 'package:football_news/ui/components/text_input.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var isVisible = false.obs;

    return Wrap(
      runSpacing: 6,
      children: [
        TextInput(
          autofocus: true,
          name: 'email',
          label: 'Email Address',
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(errorText: 'Email is required'),
            FormBuilderValidators.email(errorText: 'Enter a valid email'),
          ]),
        ),
        Obx(() {
          return TextInput(
            name: 'password',
            label: 'Password',
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            obscureText: !isVisible.value,
            suffixIcon: IconButton(
              icon: Icon(
                isVisible.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () => isVisible.value = !isVisible.value,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(errorText: 'Password is required'),
              FormBuilderValidators.minLength(
                6,
                errorText: 'Password must be at least 6 characters',
              ),
            ]),
          );
        }),
      ],
    );
  }
}
