import 'package:flutter/material.dart';
import 'package:simple_vault/l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        title: Text(
          l10n.privacyPolicy,
          style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF2F2F7),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        children: [
          _buildSection(
            screenWidth,
            l10n.lastUpdated,
            l10n.dateValue,
          ),
          _buildSection(
            screenWidth,
            l10n.overview,
            l10n.overviewDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.dataCollection,
            l10n.dataCollectionDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.dataStorage,
            l10n.dataStorageDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.security,
            l10n.securityDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.permissions,
            l10n.permissionsDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.thirdPartyServices,
            l10n.thirdPartyServicesDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.policyChanges,
            l10n.policyChangesDesc,
          ),
          _buildSection(
            screenWidth,
            l10n.contact,
            l10n.contactDesc,
          ),
          SizedBox(height: screenWidth * 0.05),
        ],
      ),
    );
  }

  Widget _buildSection(double screenWidth, String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.042,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1C1E),
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Text(
            content,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
