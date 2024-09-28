import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:shippi/models/companies_list.dart';
import 'package:shippi/provider/companies.dart';
import 'package:shippi/responsive.dart';
import 'package:shippi/styles/fonts.dart';
import 'package:shippi/widgets/email_temp.dart';
import 'package:shippi/styles/styles.dart';
import 'package:shippi/widgets/category_box.dart';
import 'dart:html' as html;

class CompaniesList extends StatefulWidget {
  CompaniesList({Key? key}) : super(key: key);

  @override
  _CompaniesListState createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<CompaniesProvider>().searchEmails(_searchController.text);
    });
    // Call fetchEmails when widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CompaniesProvider>(context, listen: false).fetchEmails();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget CustomCircleProfile(name, url) {
    return CircleAvatar(
      radius: 31,
      backgroundColor: Styles.brandBackgroundColor, // Placeholder color
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder:
              'assets/astranaut.png', // Path to a local placeholder image
          image: url,
          imageErrorBuilder: (context, error, stackTrace) {
            return Center(
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: AppTextStyles.regular,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompaniesProvider>(builder: (context, data, child) {
      if (data.loading) {
        return Center(child: CircularProgressIndicator());
      }
      return CategoryBox(
        title: "Companies",
        suffix: data.selectedEmail.isEmpty
            ? null
            : GestureDetector(
              onTap: () {
                data.deselectEmailAddress();
              },
                child: Transform.flip(
                    flipX: true, child: Icon(Icons.arrow_back_ios))),
        children: [
          Expanded(
            child: Column(
              children: [
                // Search Bar
                data.selectedEmail.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: AppTextStyles.regularBlack,
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "Search Companies",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      )
                    : Container(),
                Responsive.isMobile(context)
                    ? Expanded(
                        child: Column(
                          children: [
                            data.selectedEmail.isEmpty
                                ? Expanded(
                                    flex: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount: data.emails.length,
                                        itemBuilder: (context, index) {
                                          final email = data.emails[index];

                                          return Card(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0,
                                            ),
                                            elevation: 2.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: ListTile(
                                              onTap: () {
                                                data.selectEmailAddress(
                                                    email.emailAddress);
                                                // print("Pressed ${filteredCompanies[index]}");
                                              },
                                              leading: CustomCircleProfile(
                                                  getDomainFromEmail(
                                                      email.emailAddress),
                                                  "https://logo.clearbit.com/${getDomainFromEmail(email.emailAddress)}"),

                                              //  CircleAvatar(
                                              //   backgroundImage: NetworkImage(
                                              //       "https://logo.clearbit.com/${getDomainFromEmail(email.emailAddress)}"),
                                              // ),
                                              title: Text(
                                                email.emailAddress,
                                                style:
                                                    AppTextStyles.regularBlack,
                                              ),
                                              // subtitle: Text(email.emailAddress),
                                              trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 16.0),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Container(),
                            Container(
                              color: Colors.grey[300],
                              height: 1,
                            ),
                            data.selectedEmail.isEmpty
                                ? SelectEmail()
                                : Expanded(
                                    flex: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: ListView(
                                        children: [
                                          Row(
                                            children: [
                                              CustomCircleProfile(
                                                  getDomainFromEmail(
                                                      data.selectedEmail),
                                                  "https://logo.clearbit.com/${getDomainFromEmail(data.selectedEmail)}"),
                                              // ClipRRect(
                                              //   borderRadius:
                                              //       BorderRadius.circular(25.0),
                                              //   child: Image.network(
                                              //     "https://logo.clearbit.com/${getDomainFromEmail(data.selectedEmail)}",
                                              //     width: 100.0,
                                              //     height: 100.0,
                                              //     errorBuilder: (context,
                                              //         exception, stackTrace) {
                                              //       return Icon(
                                              //         Icons.image,
                                              //         size: 40,
                                              //       );
                                              //     },
                                              //   ),
                                              // ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getDomainFromEmail(
                                                        data.selectedEmail),
                                                    style: AppTextStyles
                                                        .heading1Black,
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  GestureDetector(
                                                    onTap: () {
                                                      html.window.open(
                                                          'http://${getDomainFromEmail(data.selectedEmail)}',
                                                          'new tab');
                                                    },
                                                    child: Text(
                                                      getDomainFromEmail(
                                                          data.selectedEmail),
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data.selectedEmail,
                                                style:
                                                    AppTextStyles.regularBlack,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _copyToClipboard(
                                                      data.selectedEmail);
                                                },
                                                child: Text(
                                                  'Copy',
                                                  style: AppTextStyles
                                                      .regularBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24.0),
                                          EmailTemplates(),
                                        ],
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Row(
                          children: [
                            // Left Sidebar: Filtered Company List
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: data.emails.length,
                                  itemBuilder: (context, index) {
                                    final email = data.emails[index];

                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          data.selectEmailAddress(
                                              email.emailAddress);
                                          // print("Pressed ${filteredCompanies[index]}");
                                        },
                                        leading: CustomCircleProfile(
                                            getDomainFromEmail(
                                                email.emailAddress),
                                            "https://logo.clearbit.com/${getDomainFromEmail(email.emailAddress)}"),

                                        // CircleAvatar(
                                        //   backgroundImage: NetworkImage(
                                        //       "https://logo.clearbit.com/${getDomainFromEmail(email.emailAddress)}"),
                                        // ),
                                        title: Text(
                                          email.emailAddress,
                                          style: AppTextStyles.regularBlack,
                                        ),
                                        // subtitle: Text(email.emailAddress),
                                        trailing: Icon(Icons.arrow_forward_ios,
                                            size: 16.0),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Divider Line
                            Container(
                              color: Colors.grey[300],
                              width: 1,
                            ),
                            // Right Sidebar: Company Details

                            data.selectedEmail.isEmpty
                                ? SelectEmail()
                                : Expanded(
                                    flex: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                      ),
                                      child: ListView(
                                        children: [
                                          Row(
                                            children: [
                                              CustomCircleProfile(
                                                  getDomainFromEmail(
                                                      data.selectedEmail),
                                                  "https://logo.clearbit.com/${getDomainFromEmail(data.selectedEmail)}"),
                                              // ClipRRect(
                                              //   borderRadius:
                                              //       BorderRadius.circular(25.0),
                                              //   child: Image.network(
                                              //     "https://logo.clearbit.com/${getDomainFromEmail(data.selectedEmail)}",
                                              //     width: 100.0,
                                              //     height: 100.0,
                                              //     errorBuilder: (context,
                                              //         exception, stackTrace) {
                                              //       return Flexible(
                                              //           child: Icon(
                                              //         Icons.image,
                                              //         size: 40,
                                              //       ));
                                              //     },
                                              //   ),
                                              // ),
                                              SizedBox(width: 10.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getDomainFromEmail(
                                                        data.selectedEmail),
                                                    style: AppTextStyles
                                                        .heading1Black,
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  GestureDetector(
                                                    onTap: () {
                                                      html.window.open(
                                                          'http://${getDomainFromEmail(data.selectedEmail)}',
                                                          'new tab');
                                                    },
                                                    child: Text(
                                                      getDomainFromEmail(
                                                          data.selectedEmail),
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                data.selectedEmail,
                                                style:
                                                    AppTextStyles.regularBlack,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  _copyToClipboard(
                                                      data.selectedEmail);
                                                },
                                                child: Text(
                                                  'Copy',
                                                  style: AppTextStyles
                                                      .regularBlack,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24.0),
                                          EmailTemplates(),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

String getDomainFromEmail(String email) {
  // Split the email address at the '@' symbol
  List<String> parts = email.split('@');

  // Check if the email address contains '@'
  if (parts.length == 2) {
    return parts[1]; // Return the domain part
  } else {
    return ''; // Return an empty string if the email is invalid
  }
}

void _copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    // Optionally, show a message to indicate that the text has been copied
    // print('Text copied to clipboard!');
  });
}

Widget SelectEmail() {
  return Expanded(
    flex: 6,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centers the Row
        children: [
          // Icon Widget
          Icon(
            Icons.email, // Use the desired icon
            size: 40, // Adjust the size as needed
            color: Colors.black, // Adjust the color as needed
          ),
          SizedBox(width: 16), // Spacing between the icon and text
          // Text Widget
          Text(
            "Please choose email",
            style: AppTextStyles.heading1Black,
          ),
        ],
      ),
    ),
  );
}
