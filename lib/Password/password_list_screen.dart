import 'package:flutter/material.dart';
import 'add_password_screen.dart';
import 'package:simple_vault/services/secure_storage_service.dart';
import 'package:simple_vault/l10n/app_localizations.dart';

class PasswordListScreen extends StatefulWidget {
  const PasswordListScreen({super.key});

  @override
  State<PasswordListScreen> createState() => _PasswordListScreenState();
}

class _PasswordListScreenState extends State<PasswordListScreen> {
  List<Map<String, String>> passwordList = [];
  final Set<int> _visibleIndices = {};

  Future<void> saveData() async => SecureStorageService.savePasswords(passwordList);

  Future<void> loadData() async {
    final data = await SecureStorageService.loadPasswords();
    setState(() => passwordList = data);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final double sh = MediaQuery.of(context).size.height;
    final double sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(l10n.myPasswords, style: TextStyle(fontSize: sw * 0.05)),
          ),
          backgroundColor: const Color(0xFFF8F9FF),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: passwordList.isEmpty
          ? Center(
              child: Text(
                l10n.noPasswordsYet,
                style: TextStyle(fontSize: sw * 0.045, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: sh * 0.01),
              itemCount: passwordList.length,
              itemBuilder: (context, index) {
                final item = passwordList[index];
                final bool isVisible = _visibleIndices.contains(index);
                return Card(
                  color: const Color.fromARGB(255, 250, 250, 254),
                  margin: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.01),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.005),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF005AC1).withValues(alpha: 0.1),
                      child: Icon(Icons.vpn_key, color: const Color(0xFF005AC1), size: sw * 0.05),
                    ),
                    title: Text(
                      item['site'] ?? "",
                      style: TextStyle(fontSize: sw * 0.042, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      isVisible ? item['pass'] ?? "" : "*" * (item['pass']?.length ?? 0),
                      style: TextStyle(letterSpacing: 2, fontSize: sw * 0.035),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                            color: const Color(0xFF005AC1),
                            size: sw * 0.055,
                          ),
                          onPressed: () {
                            setState(() {
                              isVisible ? _visibleIndices.remove(index) : _visibleIndices.add(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent, size: sw * 0.055),
                          onPressed: () {
                            setState(() {
                              _visibleIndices.remove(index);
                              passwordList.removeAt(index);
                              saveData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF005AC1),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddPasswordScreen(
              onSave: (site, pass) {
                setState(() {
                  passwordList.add({'site': site, 'pass': pass});
                  saveData();
                });
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: sw * 0.07),
      ),
    );
  }
}
