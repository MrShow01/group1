# TODO: Implement Local User Authentication with SQLite

## Steps to Complete
- [ ] Update pubspec.yaml: Add sqflite dependency and remove Firebase dependencies (firebase_core, firebase_auth, cloud_firestore)
- [ ] Update lib/main.dart: Remove Firebase imports, modify UserRepository to accept database parameter and implement local registration/login using SQLite
- [ ] Update AuthCubit: Ensure it works with the modified UserRepository (no changes expected)
- [ ] Test the application: Run the app to verify local login/registration works
