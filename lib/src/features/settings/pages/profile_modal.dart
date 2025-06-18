import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/utils/preferences.dart';

class ProfileModal extends StatefulWidget {
  const ProfileModal({super.key});

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  bool _isEmailValid = true;
  bool _isEmailEmpty = false;

  final RegExp _emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final email = await Preferences.getEmail();
    if (email != null) {
      setState(() {
        _emailController.text = email;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  //Future<void> _saveEmail() async {
  //if (_emailController.text.isEmpty) return;

  Future<void> _saveEmail() async {
    final email = _emailController.text.trim();
    final isValid = _emailRegex.hasMatch(email);

    setState(() {
      _isEmailEmpty = email.isEmpty;
      _isEmailValid = isValid;
    });

    if (_isEmailEmpty || !_isEmailValid) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await Preferences.setEmail(_emailController.text);
      if (mounted) {
        Navigator.pop(context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        color: CupertinoColors.systemBackground,
        child: Column(children: [
          // Navigation bar
          Container(
            color: primary1,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Cancel',
                    style: poppinsRegular.copyWith(color: white),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'My Profile',
                  style: poppinsRegular.copyWith(
                    fontSize: 18,
                    color: white,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _isLoading ? null : _saveEmail,
                  child: Text(
                    'Save',
                    style: poppinsRegular.copyWith(color: white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: CupertinoFormSection(
            children: [
              CupertinoFormRow(
                prefix: Text(
                  'Email',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (!_isEmailValid || _isEmailEmpty)
                                ? CupertinoColors.systemRed
                                : CupertinoColors.separator,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/icons/email.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Expanded(
                              child: CupertinoTextField(
                                controller: _emailController,
                                textAlign: TextAlign.left,
                                placeholder: 'Enter your email',
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                style: poppinsRegular.copyWith(fontSize: 16),
                                decoration:
                                    null, // Bỏ decoration trong TextField vì đã có ở ngoài
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isEmailEmpty || !_isEmailValid)
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 4),
                          child: Text(
                            'enter your email',
                            style: poppinsRegular.copyWith(
                              fontSize: 13,
                              color: CupertinoColors.systemRed,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ]));
  }
}
