import 'package:battari/wait_for_call_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallWidget extends StatelessWidget {
  const CallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(200),
              ),
              child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Icon(
                        size: 40,
                        Icons.volume_up,
                      ),
                      Text("スピーカー",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 13))
                    ],
                  ))),
          SizedBox(
            width: 50,
          ),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(color: Colors.grey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Icon(size: 40, Icons.mic_off_outlined),
                  ),
                  const Text("ミュート",
                      style: TextStyle(fontWeight: FontWeight.w100)),
                ],
              ),
            ),
          )
        ]),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Colors.red),
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Consumer(builder: (context, ref, _) {
                    return IconButton(
                        onPressed: () {
                          ref
                              .read(waitForCallNotifierProvider.notifier)
                              .endCall();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ));
                  }),
                ))
          ],
        )
      ],
    );
  }
}
