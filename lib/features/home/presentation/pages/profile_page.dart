import 'dart:developer';
import 'dart:io';

import 'package:answer_five/core/utils/theme/custom_theme.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:answer_five/features/authentication/presentation/bloc/auth_event.dart';
import 'package:answer_five/features/home/presentation/bloc/home_state.dart';
import 'package:answer_five/features/picker/presentation/bloc/picker_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../../../picker/presentation/bloc/picker_bloc.dart';
import '../../../picker/presentation/bloc/picker_state.dart';
import '../bloc/home_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final player = (context.read<HomeBloc>().state as HomeLoadSuccess).player;
    final usernameController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: GradientBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  children: [
                    BlocListener<PickerBloc, PickerState>(
                      listener: (context, state) {
                        if (state is PickerLoadSuccess) {
                          showDialog<ImageSource>(
                              context: context,
                              builder: (context) => Dialog.fullscreen(
                                    child: GradientBackground(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: FileImage(
                                                File(state.xFile!.path),
                                              ),
                                              radius: 100,
                                            ),
                                            Card(
                                              elevation: 15,
                                              child: Column(children: [
                                                const Text(
                                                  "Do you want to save this picture",
                                                  textAlign: TextAlign.center,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        child:
                                                            const Text("Yes"),
                                                        onPressed: () {
                                                          log(state
                                                              .xFile!.path);
                                                          context
                                                              .read<AuthBloc>()
                                                              .add(AuthPhotoUrlUpdated(
                                                                  name: state
                                                                      .xFile!
                                                                      .name,
                                                                  path: state
                                                                      .xFile!
                                                                      .path));
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                    ElevatedButton(
                                                        child: const Text("No"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  ],
                                                ),
                                              ]),
                                            )
                                          ],
                                        ),
                                      ),

                                      // content: const Text(
                                      //   "Do you want to save this picture",
                                      //   textAlign: TextAlign.center,
                                      // ),
                                      // actions: [
                                      //   Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceEvenly,
                                      //     children: [
                                      //       ElevatedButton(
                                      //           child: const Text("Yes"),
                                      //           onPressed: () {
                                      //             context.read<HomeBloc>().add(
                                      //                 HomeImageUploaded(
                                      //                     state.xFile!));
                                      //             Navigator.of(context).pop();
                                      //           }),
                                      //       ElevatedButton(
                                      //           child: const Text("No"),
                                      //           onPressed: () {
                                      //             Navigator.of(context).pop();
                                      //           }),
                                      //     ],
                                      //   ),
                                      // ],
                                    ),
                                  ));
                        }
                      },
                      child: const SizedBox(),
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) => state is HomeLoadSuccess
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(state.player.photoUrl),
                              radius: 100,
                            )
                          : const CircleAvatar(
                              radius: 100,
                              child: FlutterLogo(
                                size: 100,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: 5,
                      child: IconButton(
                          onPressed: () {
                            showDialog<ImageSource>(
                                context: context,
                                builder: (context) => AlertDialog(
                                        content: const Text(
                                          "Choose image source",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  child: const Text("Camera"),
                                                  onPressed: () {
                                                    context.read<PickerBloc>().add(
                                                        const PickerCameraPicked());
                                                    Navigator.of(context).pop();
                                                  }),
                                              ElevatedButton(
                                                  child: const Text("Gallery"),
                                                  onPressed: () {
                                                    context.read<PickerBloc>().add(
                                                        const PickerImagePicked());
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          ),
                                        ]));
                          },
                          icon: const Icon(Icons.camera_alt)),
                    ),
                  ],
                ),
                Text(
                  'UserId:\n${player.id}',
                  textAlign: TextAlign.center,
                ),
                Container(
                  child: Column(
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) => state is HomeLoadSuccess
                            ? Text(
                                'Username:\n${state.player.username}',
                                textAlign: TextAlign.center,
                              )
                            : const Text(
                                'Username:\n empty}',
                                textAlign: TextAlign.center,
                              ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog<ImageSource>(
                                context: context,
                                builder: (context) => AlertDialog(
                                        content: const Text(
                                          "Change username\nInput between 3 to 10 characters",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Column(
                                            children: [
                                              TextFormField(
                                                controller: usernameController,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                      child: const Text("Save"),
                                                      onPressed: () {
                                                        if (usernameController
                                                                    .text
                                                                    .length <
                                                                3 ||
                                                            usernameController
                                                                .text.isEmpty ||
                                                            usernameController
                                                                    .text
                                                                    .length >
                                                                10) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                const SnackBar(
                                                                    content: Text(
                                                                        "Input error")));
                                                        } else {
                                                          context
                                                              .read<AuthBloc>()
                                                              .add(AuthUsernameUpdated(
                                                                  username:
                                                                      usernameController
                                                                          .text));
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      }),
                                                  ElevatedButton(
                                                      child: const Text("Exit"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]));
                          },
                          icon: const Icon(Icons.edit)),
                    ],
                  ),
                ),
                Text(
                  'Email:\n${player.email}',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Back'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
