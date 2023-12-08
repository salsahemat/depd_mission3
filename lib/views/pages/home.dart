part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textFieldController = TextEditingController();

  List<Province> provinceData = [];

  ///
  dynamic selectedProvinceOrigin;
  dynamic selectedProvinceDestination;

  bool isLoading = false;
  bool isLoadingCityOrigin = false;
  bool isLoadingCityDestination = false;

  Future<dynamic> getProvinces() async {
    ////
    await MasterDataService.getProvince().then((value) {
      setState(() {
        provinceData = value;

        ///
        isLoading = false;
      });
    });
  }

  dynamic cityDataOrigin;
  dynamic cityIdOrigin;
  dynamic selectedCityOrigin;
  dynamic selectedCityDestination;

  dynamic selectedCourier;

  List<City> cityData = [];
  List<City> cityDataDestination = [];

  Future<dynamic> getCities(var provId) async {
    ////
    await MasterDataService.getCity(provId).then((value) {
      setState(() {
        cityData = value;
        isLoadingCityOrigin = false;
      });
    });
  }

  Future<dynamic> getCitiesDestination(var provId) async {
    ////
    await MasterDataService.getCity(provId).then((value) {
      setState(() {
        cityDataDestination = value;
        isLoadingCityDestination = false;
      });
    });
  }

  List<Costs> costsList = [];

  Future<dynamic> getCosts(var origin, var destination, var weight, var courier) async {
    ////
    await MasterDataService.getCost(origin,destination,weight,courier).then((value) {
      setState(() {
        costsList = value;
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   isLoading = true;
    // });
    getProvinces(); ////
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w800,fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: selectedCourier,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        elevation: 4,
                        style: TextStyle(color: Colors.black),
                        hint: selectedCourier == null
                            ? Text('Pilih Courier')
                            : Text(selectedCourier),
                        items: ["jne", "tiki", "pos"]
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCourier = newValue;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: Container(
                        width: 150,
                        child: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            hintText: 'Berat (gr)',
                            contentPadding: EdgeInsets.all(0.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Origin",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedProvinceOrigin,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 4,
                          style: TextStyle(color: Colors.black),
                          hint: selectedProvinceOrigin == null
                              ? Text('Pilih Provinsi')
                              : Text(selectedProvinceOrigin.province),
                          items: provinceData.map<DropdownMenuItem<Province>>(
                            (Province value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value.province.toString()),
                              );
                            },
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedProvinceOrigin = newValue;
                              isLoadingCityOrigin = true;
                              getCities(selectedProvinceOrigin.provinceId);
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 150,
                        child: isLoadingCityOrigin == true
                            ? UiLoading.loadingSmall()
                            : DropdownButton(
                                isExpanded: true,
                                value: selectedCityOrigin,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 4,
                                style: TextStyle(color: Colors.black),
                                hint: selectedCityOrigin == null
                                    ? Text('Pilih Kota')
                                    : Text(selectedCityOrigin.cityName),
                                items: cityData.map<DropdownMenuItem<City>>(
                                  (City value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value.cityName.toString()),
                                    );
                                  },
                                ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityOrigin = newValue;
                                  });
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Destination",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          value: selectedProvinceDestination,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          elevation: 4,
                          style: TextStyle(color: Colors.black),
                          hint: selectedProvinceDestination == null
                              ? Text('Pilih Provinsi')
                              : Text(selectedProvinceDestination.province),
                          items: provinceData.map<DropdownMenuItem<Province>>(
                            (Province value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value.province.toString()),
                              );
                            },
                          ).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedProvinceDestination = newValue;
                              isLoadingCityDestination = true;
                              getCitiesDestination(
                                selectedProvinceDestination.provinceId,
                              );
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 150,
                        child: isLoadingCityDestination == true
                            ? UiLoading.loadingSmall()
                            : DropdownButtonFormField(
                                isExpanded: true,
                                value: selectedCityDestination,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                elevation: 4,
                                style: TextStyle(color: Colors.black),
                                hint: selectedCityDestination == null
                                    ? Text('Pilih Kota')
                                    : Text(selectedCityDestination.cityName),
                                items: cityDataDestination
                                    .map<DropdownMenuItem<City>>(
                                  (City value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value.cityName.toString(),
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedCityDestination = newValue;
                                  });
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            ElevatedButton(
                onPressed: ()=> {
                  if (selectedCityDestination!=null && selectedCityOrigin!=null && selectedCourier!=null && _textFieldController.text.isNotEmpty){
                    getCosts(selectedCityOrigin.cityId, selectedCityDestination.cityId, _textFieldController.text, selectedCourier)
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Hitung Estimasi Harga', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)),
            SizedBox(height: 16.0,),
            costsList.isEmpty
                ? Container(
              height: 200,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text("Tidak ada data"),
                    ),
                ) : isLoading == true ? UiLoading.loadingBlock()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: costsList.length,
                    itemBuilder: (context, index) {
                      return CardProvince(costsList[index]);
                    },
                  ),
          ],
        ),
      ),
      // isLoading == true ? UiLoading.loadingBlock() : Container(),
    );
  }
}
