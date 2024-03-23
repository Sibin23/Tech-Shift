import 'package:flutter/material.dart';
import 'package:prosample_1/User/Profile/terms_policies.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class TermsButton extends StatefulWidget {
  const TermsButton({super.key});

  @override
  State<TermsButton> createState() => _TermsButtonState();
}

class _TermsButtonState extends State<TermsButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => const TermsAndPolicy())),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                              'assets/icons/terms&conditions.png',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .1),
                                          const SizedBox(width: 10),
                                          Text('Terms & Conditions',
                                              style: TextStyling.subtitle2),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          color: AppColors.appTheme)
                                    ],
                                  ),
                                ),
                              ),
                            );
  }
}