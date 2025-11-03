import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_news/core/configs/router.dart';
import 'package:football_news/core/utils/snack_bar.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/components/loading.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AppRouter.auth;
    return Obx(() {
      final user = auth.firebaseUser.value;

      return Layout(
        content: user == null
            ? Loading(title: 'Not logged in')
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: user.photoURL != null
                            ? NetworkImage(user.photoURL!)
                            : const AssetImage('assets/images/man.png')
                                  as ImageProvider,
                      ),
                      Text(
                        user.displayName == null ? '' : 'Anonymous User',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        user.email ?? 'No email',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      // Copyable UID
                      GestureDetector(
                        onTap: () async {
                          if (user.uid.isNotEmpty) {
                            await Clipboard.setData(
                              ClipboardData(text: user.uid),
                            );
                            if (!context.mounted) return;
                            MySnackBar.show(
                              context,
                              message: 'Copied UID to clipboard',
                              type: MessageType.success,
                            );
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(user.uid),
                            const SizedBox(width: 8),
                            Icon(Icons.copy, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: auth.signOut,
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
