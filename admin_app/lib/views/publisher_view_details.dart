// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../models/publisher_model.dart';

class PublisherViewDetails extends StatefulWidget {
  const PublisherViewDetails({super.key});

  @override
  State<PublisherViewDetails> createState() => _PublisherViewDetailsState();
}

// view publisher details screens
class _PublisherViewDetailsState extends State<PublisherViewDetails> {
  @override
  Widget build(BuildContext context) {
    final ui = ModalRoute.of(context)!.settings.arguments as Publisher;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
        title: Text(
          ui.name.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                const Gap(50),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    border: Border.all(width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: ui.profileImage!.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            'assets/images/PhUserBold.svg',
                            fit: BoxFit.contain,
                            height: 100,
                            color: Colors.black,
                          ),
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            ui.profileImage.toString(),
                            // fit: BoxFit.cover,
                            // color: Colors.black,
                          ),
                        ),
                ),
                CustomTile(
                  title: 'Name',
                  value: ui.name.toString(),
                ),
                CustomTile(
                  title: 'Father Name',
                  value: ui.fatherName.toString(),
                ),
                CustomTile(
                  title: 'Email',
                  value: ui.email.toString(),
                ),
                CustomTile(
                  title: 'Gender',
                  value: ui.gender.toString(),
                ),
                CustomTile(
                  title: 'Register Date',
                  value: DateFormat.yMMMEd().format(ui.createDate!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  const CustomTile({super.key, required this.title, required this.value});
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(7),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2, color: Color(0x23534C4C)),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF534C4C),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
