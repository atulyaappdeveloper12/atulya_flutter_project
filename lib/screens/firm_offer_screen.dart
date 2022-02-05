import 'package:flutter/material.dart';

class FirmOfferScreen extends StatefulWidget {
  const FirmOfferScreen({Key? key}) : super(key: key);

  @override
  _FirmOfferScreenState createState() => _FirmOfferScreenState();
}

class _FirmOfferScreenState extends State<FirmOfferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffe5e5e5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 350,
                height: 700,
                color: const Color(0xffeeeeee).withOpacity(0.9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Image.asset(
                                  "images/uicash.png",
                                  width: 130,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.person,
                          size: 100,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text(
                      "FIRM OFFER",
                      style: TextStyle(
                          color: Color(0xfff11616),
                          fontSize: 24,
                          fontWeight: FontWeight.w800),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "India to UAE",
                            style: TextStyle(
                                color: Color(0xff5d5fef),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "26-Feb-2022",
                            style: TextStyle(
                                color: Color(0xff5d5fef),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                              text: const TextSpan(
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  children: [
                                TextSpan(
                                    text: "INR 100,000 ",
                                    style: TextStyle(color: Color(0xff5d5fef))),
                                TextSpan(text: "to "),
                                TextSpan(text: "AED 5,100")
                              ]))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: [
                          TextSpan(text: "Our Partner : "),
                          TextSpan(
                              text: "Saad Exchange",
                              style: TextStyle(color: Color(0xff183bf5)))
                        ])),
                    Center(
                      child: Image.asset(
                        "images/qrcode_icon.png",
                        width: 300,
                        height: 180,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Proceed to any branches\n "
                        "along with"
                        " your passport\n & show this QR code"
                        " to\n avail this exclusive rate",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Center(
                        child: Text(
                      "Click here for the location of"
                      " SAAD Exchange",
                      style: TextStyle(
                          color: Color(0xff7879f1),
                          fontWeight: FontWeight.w500),
                    )),
                    const SizedBox(height: 10,),
                    Center(
                      child: Container(
                        color: Colors.transparent,
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xff7e7e7e)
                            ),
                            onPressed: (){},
                            child: const Text("EXIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
