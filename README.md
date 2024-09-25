# Udayah

Welcome to Udayah! We are calling all open-source enthusiasts to contribute to this project. Feel free to add new features, report issues, or suggest improvements. Before contributing, kindly outline the use case, benefits, and aim of your proposed feature or changes.

## Tech Stack

- **Frontend:** Flutter
- **Backend:** Node.js, Firebase, Aws

## Local Setup

### Flutter Setup

1. Install Flutter by following the official [Flutter documentation](https://docs.flutter.dev/get-started/install).
2. Configure your own Firebase setup and link it to the project.
3. Navigate to the `lib/` folder in the Flutter project for development.

### Node.js Setup

1. Navigate to the `functions/` folder which contains the backend logic.

2. To set up the email-sending feature, follow these steps:

   - Create an `email.json` file in the `functions/` directory.
   - Add emails in the following format (up to 15 emails):
     ```json
     [
       {
         "email_id": "00001",
         "email_address": "test@in.ibm",
         "added_by": "admin"
       },
       ...
     ]
     ```

3. Create a `.env` file in the `functions/` folder and define the `ENCRYPTION_KEY`. Make sure this matches the key used in Flutter (see details below).

### Encryption Setup

In the Flutter project, go to `lib/encryption.dart` and ensure that the encryption key matches the one defined in your `.env` file in the Node.js backend. The key can be set like this in Flutter:

```dart
static final key = encrypt.Key.fromUtf8("your key"); // Ensure this is the same as in Node.js
```

### Backend Setup

1. In the `functions/` folder, ensure you have Node.js installed. If not, you can download and install it from the [official Node.js website](https://nodejs.org/).

2. Once Node.js is installed, open a terminal and navigate to the `functions/` folder.

3. Run the following command to install the required dependencies:
   ```bash
   npm install
   ```

4. After installation, start the backend server by running:
   ```bash
   npm start
   ```

5. Ensure that the server is running properly and that you can access the API endpoints.

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
