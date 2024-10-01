# Udayah

We invite all open-source enthusiasts to join us in building a free platform for job seekers. In a world where many services for resumes, job emails, and related resources often come at a cost, Udayah stands out as a free, open-source alternative. Whether it’s adding new features, reporting issues, or suggesting improvements, your contributions can help make Udayah a valuable resource for job seekers.

Before contributing, kindly outline the use case, benefits, and goal of your proposed feature or changes. Together, let’s build something meaningful, accessible, and free for everyone!


## Tech Stack

- **Frontend:** Flutter
- **Backend:** Node.js, Firebase, Aws

## Local Setup

### Flutter Setup

1. Install Flutter by following the official [Flutter documentation](https://docs.flutter.dev/get-started/install).
2. Set up your own Firebase instance and link it to the project.
3. Navigate to the `lib/` folder within the Flutter project to begin development.
4. For more information on building for the web, refer to the [Flutter Web documentation](https://docs.flutter.dev/platform-integration/web/building).
5. To run the project in Chrome, execute the following command:  
   ```bash
   flutter run -d chrome
   ```
   
### Backend Setup

1. **Navigate to the `functions/` directory:**
   - This folder contains the backend logic for the project.

2. **Install dependencies:**
   - Run `npm install` to install all required dependencies.
     
3. **Environment Configuration:**
   - Copy the `.env.example` file and create a `.env` file in the `functions/` directory.
   - Define the `ENCRYPTION_KEY` in the `.env` file. Ensure that this key matches the one used in your Flutter application for encryption.
   - Define Database settings.

4. **Starting the Server:**
   - After configuring the `.env` file, run the server using the command `npm start`.

### Encryption Setup

In the Flutter project, go to `lib/encryption.dart` and ensure that the encryption key matches the one defined in your `.env` file in the Node.js backend. The key can be set like this in Flutter:

```dart
static final key = encrypt.Key.fromUtf8("your key"); // Ensure this is the same as in Node.js
```

### Update Flutter API Endpoint

In the Flutter project, navigate to `lib/data/constant.dart` and update the backend API endpoint to match your local or hosted server.

## Contributing

- Please open an issue before submitting pull requests.
- Clearly explain the use case, benefits, and goals for any new feature or fix.
- Respect the coding standards and maintain consistency in the codebase.

We look forward to your contributions!

Happy coding!

## Support
For any kind of support, please reach out to us at: Email: [udayah.in.reach@gmail.com](mailto:udayah.in.reach@gmail.com)
