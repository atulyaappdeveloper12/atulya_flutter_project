import 'dart:convert';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_cash/screens/indicative_rates_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ui_cash/screens/login_screen.dart';

class CurrencyRequirementScreen extends StatefulWidget {
  const CurrencyRequirementScreen({Key? key}) : super(key: key);

  @override
  _CurrencyRequirementScreenState createState() =>
      _CurrencyRequirementScreenState();
}

class _CurrencyRequirementScreenState extends State<CurrencyRequirementScreen> {
  TextEditingController countryDestinationController = TextEditingController();
  TextEditingController currencyRequiredController = TextEditingController();
  TextEditingController localCurrencyAmountController = TextEditingController();
  TextEditingController travelDateController = TextEditingController();

  String? name;

  DateTime? date;
  String dateFormat = '';

  String countryName = '';

  bool showDate = false;

  String accessToken = '';

  String destination = '';

  String currencyName = '';

  String currencySymbol = '';

  getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = (prefs.getString('accessToken').toString() ?? '');

      name = (prefs.getString('name') ?? '');

      countryName = (prefs.getString('countryName') ?? '');

      destination = (prefs.getString('destination') ?? '');

      currencyName = (prefs.getString('currency_name') ?? '');

      currencySymbol = (prefs.getString('currency_symbol') ?? '');
    });
  }

  @override
  void initState() {
    getInfo();
    setState(() {
      countryDestinationPost();
    });

    super.initState();
  }

  void currencyRequirementPost(
      String countryDestination, currencyRequired, localCurrencyAmount) async {
    var response = await http.post(
        Uri.parse(
            "https://projects.aamoditsolutions.com/uicash/api/v1/user/indicatives-rates"),
        body: {
          'country_origin': countryName.toString(),
          'country_destination': countryDestination,
          'currency_required': currencyRequired,
          'local_currency_amount': localCurrencyAmount,
          'travel_date': dateFormat.toString()
        });

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      print('Response: ' + responseData.toString());

      if (responseData['status'].toString() == 'false') {
        Fluttertoast.showToast(msg: 'Please fill data properly');
        print('Please fill data properly');
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const IndicativeRatesScreen()));
      }
    } else {
      Fluttertoast.showToast(msg: 'Error');
      print("Error code: " + response.statusCode.toString());
    }
  }

  void countryDestinationPost() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var res = await http.post(Uri.parse('https://projects.aamoditsolutions.com/uicash/api/v1/user/countries-destination'),
    headers: {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken'
    }
    );
    if(res.statusCode == 200) {
      var dataRes = jsonDecode(res.body);

      var value1 = print("Data Res: "+dataRes.toString());

      var value2 = print("Destination Country Name: "+dataRes['data'][0]['name'].toString());

      var value3 = print("Currency Name: "+dataRes['data'][0]['currency_name'].toString());

      var value4 = print("Currency Symbol: "+dataRes['data'][0]['currency_symbol'].toString());

      preferences.setString('destination', dataRes['data'][0]['name'].toString());

      preferences.setString('currency_name', dataRes['data'][0]['currency_name'].toString());

      preferences.setString('currency_symbol', dataRes['data'][0]['currency_symbol'].toString());

      setState(() {
      value1;
      value2;
      value3;
      value4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.grey),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffe5e5e5),
          actions: [
            IconButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
      body: Container(
        color: const Color(0xffe5e5e5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 615,
                color: const Color(0xffeeeeee).withOpacity(0.9),
                child: Column(
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
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Welcome $name",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 7,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      "Currency Requirement",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Form(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // Country-Origin
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffffffff).withOpacity(0.9),
                          ),
                          width: 300,
                          height: 50,
                          child: CountryListPick(
                            appBar: AppBar(
                              title: const Text(
                                "Select Country",
                                style: TextStyle(color: Colors.grey),
                              ),
                              iconTheme:
                                  const IconThemeData(color: Colors.grey),
                              backgroundColor: const Color(0xffe5e5e5),
                              elevation: 0,
                            ),
                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: true,
                              isShowCode: false,
                              isDownIcon: true,
                              showEnglishName: true,
                              labelColor: Colors.black,
                            ),
                            initialSelection: '+91',
                            onChanged: (CountryCode? code) async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'countryName', code!.name.toString());

                              print(code.name.toString());
                              print(code.flagUri.toString());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Country-Destination
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffffffff).withOpacity(0.9),
                          ),
                          width: 300,
                          height: 50,
                          child: Text(destination.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Currency Required
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xffffffff).withOpacity(0.9),
                          ),
                          width: 300,
                          height: 50,
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Text(currencySymbol.toString(),
                                style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text(currencyName.toString(),style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Local Currency Amount
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffffffff).withOpacity(0.9),
                          ),
                          width: 300,
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: localCurrencyAmountController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Local Currency Amount",
                              hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Travel Date
                        SizedBox(
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  alignment: Alignment.centerLeft,
                                  primary: Colors.white),
                              onPressed: () async {
                                date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2090));

                                setState(() {
                                  dateFormat =
                                      DateFormat('yyyy-MM-dd').format(date!);
                                });
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_rounded,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dateFormat.toString(),
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Proceed Button
                        Container(
                          color: Colors.transparent,
                          width: 300,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff7e7e7e),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                currencyRequirementPost(
                                  countryDestinationController.text,
                                  currencyRequiredController.text,
                                  localCurrencyAmountController.text,
                                );
                              },
                              child: const Text(
                                "Search for best rates",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                "The exchange rates are indicative."
                                " Final rates are confirmed 48 hours"
                                " before actual travel date",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w800),
                              ),
                            )
                          ],
                        )
                      ],
                    ))
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
