import 'package:flutter/material.dart';

class YesterdayOrders extends StatelessWidget {
  const YesterdayOrders({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 210,
          width: 1450,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "#Products",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 160,
                              width: 200,
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return const Text(
                                    "2 x Adiddas Super Star",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 92, 91, 91)),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "#Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.qr_code),
                                ),
                                Text(
                                  "302015",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 91, 91)),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.person),
                                ),
                                Text(
                                  "hamed hossam eldin",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 91, 91)),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.phone_android),
                                ),
                                Text(
                                  "01063876967",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 91, 91)),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.date_range),
                                ),
                                Text(
                                  "16/9/2002",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 91, 91)),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.timer),
                                ),
                                Text(
                                  "03:14 AM",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 92, 91, 91)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.blue),
                                  ),
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.red),
                                    ),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.replay_outlined,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
