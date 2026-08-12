class AppStrings {
  AppStrings._();

  static const String appName = 'POS App';
  static const String welcomeTitle = 'Welcome to POS App';
  static const String welcomeSubtitle = 'Manage your sales, products, and receipts seamlessly.';
  static const String getStarted = 'Get Started';
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String products = 'Products';
  static const String skip = 'Skip';
  static const String next = 'Next';
  static const String errorOccurred = 'Something went wrong. Please try again.';

  // ---- Added: Sign In screen ----
  static const String signIn = 'Sign In';
  static const String welcomeBack = 'Welcome Back';
  static const String emailAddress = 'Email Address';
  static const String emailHint = 'admin@enterprise.com';
  static const String password = 'Password';
  static const String passwordHint = 'secret_password';
  static const String rememberMe = 'Remember Me';
  static const String forgotPassword = 'Forgot Password?';
  static const String orContinueWith = 'or continue with';
  static const String google = 'Google';
  static const String apple = 'Apple';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String register = 'Register';
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Enter a valid email';
  static const String passwordRequired = 'Password is required';

  // ---- Added: OTP Verification screen ----
  static const String identityVerification = 'Identity Verification';
  static const String verifyYourAccount = 'Verify Your Account';
  static const String otpSubtitle = 'Enter the 6-digit code sent to your enterprise email.';
  static const String resendOtpInPrefix = 'Resend OTP in ';
  static const String verifyAndProceed = 'Verify & Proceed';
  static const String didntReceiveCode = "Didn't receive code? ";
  static const String resendOtp = 'Resend OTP';

  // ---- Added: Register screen ----
  static const String registerWorkspace = 'Register Workspace';
  static const String createYourAccount = 'Create Your Account';
  static const String fullName = 'Full Name';
  static const String fullNameHint = 'Alex Carter';
  static const String registerEmailHint = 'alex@enterprise.com';
  static const String registerPasswordHint = 'MySecureP@ss1';
  static const String confirmPassword = 'Confirm Password';
  static const String agreeToTermsPrefix = 'I agree to the ';
  static const String termsAndConditions = 'Terms & Conditions';
  static const String createAccount = 'Create Account';
  static const String alreadyHaveAccount = 'Already have an account? ';

  static const String fullNameRequired = 'Full name is required';
  static const String confirmPasswordRequired = 'Please confirm your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String mustAgreeToTerms = 'Please agree to the Terms & Conditions';

  // ---- Added: Change Password screen ----
  static const String changePasswordTitle = 'Change Password';
  static const String currentPassword = 'Current Password';
  static const String newPassword = 'New Password';
  static const String saveChanges = 'Save Changes';
  static const String currentPasswordRequired = 'Current password is required';
  static const String newPasswordSameAsCurrent = 'New password must be different from current password';

  // ---- Added: Forgot Password screen ----
  static const String forgotPasswordTitle = 'Forgot Password?';
  static const String forgotPasswordSubtitle = "Enter your email address and we'll send you a reset link";
  static const String sendResetLink = 'Send Reset Link';
  static const String backToLogin = 'Back to Login';

  // ---- Added: Reset Password screen ----
  static const String resetPasswordTitle = 'Create New Password';
  static const String resetPasswordSubtitle =
      'Your new password must be different from previous passwords.';
  // static const String newPassword = 'New Password';
  // static const String confirmPassword = 'Confirm Password';
  static const String updatePassword = 'Update Password';
  static const String reqMinLength = '8+ characters';
  static const String reqNumber = 'Contains a number';
  static const String reqSymbol = 'Contains a symbol';
  static const String reqMatch = 'Passwords match';
  // static const String passwordRequired = 'Password is required';

// ---- Added: Home screen ----
//   static const String welcomeBack = 'Welcome back,';
  static const String quickActions = 'Quick Actions';
  static const String recentActivity = 'Recent Activity';

  // ---- Added: Profile screen ----
  static const String accountSection = 'ACCOUNT';
  static const String preferencesSection = 'PREFERENCES';
  static const String securitySupportSection = 'SECURITY & SUPPORT';
  static const String personalInfoTitle = 'Personal Info';
  static const String personalInfoSubtitle = 'Configure name, email, credentials';
  static const String notificationSettingsTitle = 'Notification Settings';
  static const String notificationSettingsSubtitle = 'Push triggers, emails & Slack integrations';
  static const String languageTitle = 'Language';
  static const String privacyTitle = 'Privacy';
  static const String privacySubtitle = 'Control visibility and cluster logs exposure';
  static const String connectedAppsTitle = 'Connected Apps';
  static const String twoFactorAuthTitle = 'Two-Factor Auth';
  static const String helpCenterTitle = 'Help Center';
  static const String helpCenterSubtitle = 'Documentation, ticket desk & server diagnostics';
  static const String settingsTitle = 'Settings';
  static const String settingsSubtitle = 'App preferences, account management & security';

  // ---- Added: Edit Profile screen ----
  static const String editProfileTitle = 'Edit Profile';
  static const String done = 'Done';
  static const String changeProfilePhoto = 'Change Profile Photo';
  // static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String designationTitle2 = 'Designation / Title';
  static const String bio = 'Bio';
  // static const String saveChanges = 'Save Changes';
  // static const String fullNameRequired = 'Full name is required';

// ---- Added: Activity screen ----
  static const String activityLogsTitle = 'Activity Logs';
  static const String filterToday = 'Today';
  static const String filterThisWeek = 'This Week';
  static const String filterThisMonth = 'This Month';

  // ---- Added: Notifications screen ----
  static const String notificationsTitle = 'Notifications';
  static const String markAllAsRead = 'Mark All as Read';
  static const String filterAll = 'All';
  static const String filterUnread = 'Unread';
  static const String notificationsTip = 'Tip: Swipe left on a notification to archive or configure triggers.';
  static const String categoryAlert = 'ALERT';
  static const String categoryOrder = 'ORDER';
  static const String categorySystem = 'SYSTEM';

  // ---- Added: Settings screen ----
  // static const String settingsTitle = 'Settings';
  static const String appearanceSection = 'APPEARANCE';
  static const String notificationsSection = 'NOTIFICATIONS';
  static const String securitySection = 'SECURITY';
  static const String generalSection = 'GENERAL';
  static const String legalSection = 'LEGAL';
  static const String darkMode = 'Dark Mode';
  static const String appTheme = 'App Theme';
  static const String pushNotifications = 'Push Notifications';
  static const String emailNotifications = 'Email Notifications';
  static const String smsAlerts = 'SMS Alerts';
  static const String biometricAuth = 'Biometric Auth';
  static const String twoFactorAuth = 'Two-Factor Auth';
  static const String activeSessions = 'Active Sessions';
  static const String language = 'Language';
  static const String region = 'Region';
  static const String termsOfService = 'Terms of Service';
  static const String openSourceLicenses = 'Open Source Licenses';
  static const String logOut = 'Log Out';
  static const String deleteAccount = 'Delete Account';


  // ---- Added: Terms & Privacy screen ----
  static const String termsPrivacyTitle = 'Terms & Privacy';
  static const String termsLastUpdated = 'Last updated: January 15, 2026';
  static const String termsSection1Title = '1. Introduction';
  static const String termsSection1Body =
      'Welcome to EnterpriseSuite. By accessing, deploying, or utilizing our cloud platform '
      'and integrated services, you agree to be bound by these unified terms. Please read '
      'this agreement carefully.';
  static const String termsSection2Title = '2. Data Collection';
  static const String termsSection2Body =
      'To provision high-performance node servers, maintain container security, and '
      'optimize query latency, our system architecture collects secure operational metadata:';
  static const String termsSection3Title = '3. Usage Rights';
  static const String termsSection3Body =
      'EnterpriseSuite grants you a restricted, non-exclusive, revocable license to access '
      'our platform solely for authorized business operations. All dashboard templates, '
      'metadata pipelines, and user provisioning are governed by your subscription '
      'agreement tiers.';
  static const String termsSection4Title = '4. Privacy';
  static const String termsSection4Body =
      'We operate on a zero-trust architecture. All client properties, custom parameters, '
      'database schema descriptions, and system integrations remain your proprietary data. '
      'EnterpriseSuite does not sell, lease, or monetize organizational usage patterns.';
  static const String termsSection5Title = '5. Contact Us';
  static const String termsSection5Body =
      'For policy concerns, data extraction requests, or server security auditing '
      'parameters, please contact our specialized compliance division:';
  static const String termsContactName = 'EnterpriseSuite Compliance';
  static const String termsContactEmail = 'Email: legal@enterprisesuite.com';
  static const String termsContactSla = 'Response SLA: Within 2 business days';
}
