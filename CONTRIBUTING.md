# Contributing to Udayah
Welcome to the Udayah community! 🎉 We’re excited to have you on board and appreciate your interest in helping improve this project. Please follow this guide to get started with contributing to Udayah. Let’s build a powerful, accessible platform for job seekers together!

## Table of Contents

- [Code of Conduct](#Code-of-Conduct)
- [How Can I Contribute?](#How-Can-I-Contribute?)
- [Setting Up the Project Locally](#Setting-Up-the-Project-Locally)
- [Submitting a Pull Request](#Submitting-a-Pull-Request)
- [Getting Help](#Getting-Help)
- [Support](#Support)


## Code of Conduct

Please adhere to the Code of Conduct in all interactions in this project. We aim to create a welcoming environment for everyone, and respecting others is our top priority.

## How Can I Contribute?

### Reporting Bugs

If you find any bugs, please open an issue with a detailed description.
Include the steps to reproduce the issue and any relevant screenshots.

### Suggesting New Features
We’re open to your ideas! If you have a feature suggestion, create an issue and provide as much detail as possible.

### Improving Documentation

Documentation improvements are always welcome. If you find areas that could be clearer or need examples, feel free to contribute!

### Writing Code
Contributions to new features, refactoring, or code improvements are welcome. Be sure to follow the coding and style guidelines detailed below.

## Setting Up the Project Locally


To set up Udayah for local development, follow these steps:

### Prerequisites

- Install Flutter version **3.19** by following the [Flutter documentation](https://docs.flutter.dev/get-started/install).
- Set up your own Firebase instance and link it to the project for in-app account creation for now.

- for web check out [Flutter Web documentation](https://docs.flutter.dev/platform-integration/web/building)


### Clone this repository:

```git clone https://github.com/your-username/udayah.git```

- cd udayah

- Then navigate to the `lib/` folder within the Flutter project to begin development.

   ``` flutter run -d chrome```


### Backend Setup
Navigate to the Backend Directory

- Go to the functions/ folder, which contains the backend code for Udayah.
- Install Dependencies
  ``` npm install ```
- Configure Environment Variables

Copy the ```.env.example``` file and rename it to ```.env``` in the functions/ directory.

- Set the following environment variables in the .env file:
- ```ENCRYPTION_KEY:``` This should match the encryption key used in the Flutter application.
- Database settings as required.

Start the Server

```npm start```


### Encryption Setup

In the Flutter project, go to `lib/encryption.dart` and ensure that the encryption key matches the one defined in your `.env` file in the Node.js backend. The key can be set like this in Flutter:

```dart
static final key = encrypt.Key.fromUtf8("your key"); // Ensure this is the same as in Node.js
```
### Update Flutter API Endpoint

In the Flutter project, navigate to `lib/data/constant.dart` and update the backend API endpoint to match your local or hosted server.

## Submitting a Pull Request

- Fork the repository and create a new branch from ```main```.
- Add and **commit** your changes with clear messages.
- Ensure your code follows the project’s code style and passes any existing tests.
- **Submit a Pull Request** with a description of your changes and reference any relevant issues.


## Getting Help
If you have questions let us know!


Thank you for being part of **Udayah**! We’re excited to work with you.


## Support
For any kind of support, please reach out to us at: Email: [udayah.in.reach@gmail.com](mailto:udayah.in.reach@gmail.com)

