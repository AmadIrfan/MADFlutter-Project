import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:user_app/models/novel.dart';
import 'package:user_app/models/user_model.dart';
import 'package:user_app/res/buttons/custom_button.dart';
import 'package:user_app/res/routes/route_name.dart';
import 'package:user_app/utils/utils.dart';
import 'package:user_app/view%20model/provider/user_provider.dart';

import '../view model/services/api_calls.dart';

class ViewBookDetails extends StatefulWidget {
  const ViewBookDetails({super.key});

  @override
  State<ViewBookDetails> createState() => _ViewBookDetailsState();
}

class _ViewBookDetailsState extends State<ViewBookDetails> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> map = {
    "userId": '',
    "novelId": '',
    "feedback": '',
    "Rating": 0.0,
  };
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);
    user.refreshUser();
    final bookValue = ModalRoute.of(context)!.settings.arguments as Book?;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 428,
                height: 304,
                decoration: const ShapeDecoration(
                  color: Color(0xFF171B36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(),
                        child: bookValue!.images!.isEmpty
                            ? Image.asset(
                                'assets/images/Group.png',
                                color: Colors.white,
                              )
                            : Image.network(
                                bookValue.images!.first,
                              ),
                      ),
                      const Gap(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            bookValue.name!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Cabin Condensed',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            bookValue.genre!,
                            style: const TextStyle(
                              color: Color(0xFFDCDDE2),
                              fontSize: 16,
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(20),
              Center(
                child: Container(
                  width: 348,
                  height: 92,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 35,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Author",
                          style: TextStyle(
                            color: Color(0xFF9091A0),
                            fontSize: 14,
                            fontFamily: 'HK Grotesk',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          bookValue.author!,
                          style: const TextStyle(
                            color: Color(0xFF4D506C),
                            fontSize: 24,
                            fontFamily: 'HK Grotesk',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'About The Novel',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF4D506C),
                    fontSize: 18,
                    fontFamily: 'Cabin Condensed',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bookValue.summery!,
                  style: const TextStyle(
                    color: Color(0xFF9091A0),
                    fontSize: 14,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Images',
                  style: TextStyle(
                    color: Color(0xFF4D506C),
                    fontSize: 18,
                    fontFamily: 'HK Grotesk',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              bookValue.images!.isNotEmpty
                  ? SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bookValue.images!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 100,
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(),
                            // color: Colors.amber,
                            child: Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    // blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    offset: Offset(0, 10),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: bookValue.images!.isEmpty
                                  ? Image.asset(
                                      'assets/images/bg.png',
                                      // color: Colors.blue,
                                    )
                                  : Image.network(
                                      bookValue.images![index].toString(),
                                      // color: Colors.green,
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('Images Not Available'),
                    ),
              const Gap(20),
              bookValue.chapters!.isNotEmpty
                  ? Column(
                      children: [
                        CustomButton(
                            text: 'View Book',
                            onClick: () {
                              Navigator.pushNamed(
                                  context, RouteName.viewBookChapter,
                                  arguments: bookValue);
                            }),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Book is currently  Not Available for read or Download',
                      ),
                    ),
              CustomButton(
                text: 'Review',
                onClick: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 400,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Gap(25),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text('Review'),
                                  border: OutlineInputBorder(),
                                  suffix: Text('/5.0'),
                                ),
                                onSaved: (v) {
                                  map = {
                                    "userId": user.getUser!.id,
                                    "novelId": bookValue.sId,
                                    "feedback": map['feedback'],
                                    "Rating": v!,
                                  };
                                },
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Please enter value between 0 to 5';
                                  } else if (double.parse(v) > 5.0) {
                                    return 'Please enter value between 0 to 5';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const Gap(20),
                              TextFormField(
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  label: Text('Review Text'),
                                  border: OutlineInputBorder(),
                                ),
                                onSaved: (v) {
                                  map = {
                                    "userId": map['userId'],
                                    "novelId": map['novelId'],
                                    "feedback": v!,
                                    "Rating": map['Rating'],
                                  };
                                },
                                validator: (v) {
                                  return null;
                                },
                              ),
                              const Gap(10),
                              ElevatedButton(
                                onPressed: isLoading
                                    ? () {}
                                    : () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            await Provider.of<ApiCalls>(context,
                                                    listen: false)
                                                .setRating(map);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Utils().showToast(
                                                'Successfully Reviewed');
                                          }
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Utils().showToast(e.toString());
                                        }
                                      },
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Text('submit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
