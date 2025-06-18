import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  final Widget child;

  const AuthWrapper({
    super.key,
    required this.child,
  });

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    if (!authService.isBiometricEnabled) {
      setState(() => _isAuthenticated = true);
      return;
    }

    final authenticated = await authService.authenticate();
    setState(() => _isAuthenticated = authenticated);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return CupertinoPageScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.lock_shield,
                size: 64,
                color: CupertinoColors.systemGrey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Authentication Required',
                style: TextStyle(
                  fontSize: 20,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                onPressed: _checkAuthentication,
                child: const Text('Authenticate'),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
