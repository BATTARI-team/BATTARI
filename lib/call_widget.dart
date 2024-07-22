import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Container(
          //color: Color.fromRGBO(18, 17, 23, 0.9),
          color: Color.fromRGBO(0, 0, 0, 0.8),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    //decoration: BoxDecoration(
                    //    borderRadius: BorderRadius.circular(200),
                    //    border: Border.all(color: Colors.grey, width: 1)),

                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Icon(
                              size: 30,
                              Icons.volume_up,
                              color: Colors.white,
                            ),
                          ),
                          //const Text("ミュート",
                          //    style: TextStyle(
                          //        fontWeight: FontWeight.w100,
                          //        color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                      width: 110,
                      height: 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          border: Border.all(color: Colors.grey, width: 1),
                          color: Colors.red),
                      child: Consumer(builder: (context, ref, _) {
                        return IconButton(
                            onPressed: () {
                              ref
                                  .read(waitForCallNotifierProvider.notifier)
                                  .endCall();
                            },
                            icon: Icon(
                              Icons.call_end,
                              size: 30,
                              color: Colors.white,
                            ));
                      })),
                  SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                    height: 90,
                    width: 90,
                    //decoration: BoxDecoration(
                    //    borderRadius: BorderRadius.circular(200),
                    //    border: Border.all(color: Colors.grey, width: 1)),

                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                            ),
                            child: Icon(
                              size: 30,
                              Icons.mic_off_outlined,
                              color: Colors.white,
                            ),
                          ),
                          //const Text("ミュート",
                          //    style: TextStyle(
                          //        fontWeight: FontWeight.w100,
                          //        color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
