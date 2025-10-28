import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_news/ui/components/text_input.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  final FormBuilderState? form;
  final bool isError;

  const SignUp({super.key, this.form, this.isError = false});

  @override
  Widget build(BuildContext context) {
    var ckpassword = ''.obs;
    var isVisible = false.obs;
    var isConfirm = false.obs;
    final password = TextEditingController();
    final confirmed = TextEditingController();

    return Wrap(
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
          if (isError) {
            password.clear();
            confirmed.clear();
            // ckpassword.value = '';
          }

          return Column(
            spacing: 6,
            children: [
              TextInput(
                name: 'password',
                label: 'Password',
                controller: password,
                autofocus: isError,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                obscureText: !isVisible.value,
                onChanged: (value) {
                  ckpassword.value = value ?? '';

                  // Trigger revalidation of confirm_password when password changes
                  form?.fields['confirm_password']?.validate();
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => isVisible.value = !isVisible.value,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Password is required',
                  ),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: 'Password must be at least 6 characters',
                  ),
                ]),
              ),

              TextInput(
                name: 'confirm_password',
                label: 'Confirm Password',
                controller: confirmed,
                keyboardType: TextInputType.visiblePassword,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                obscureText: !isConfirm.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirm.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () => isConfirm.value = !isConfirm.value,
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (val != ckpassword.value) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
