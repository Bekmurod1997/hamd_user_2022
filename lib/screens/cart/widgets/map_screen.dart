import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamd_user/apiservices/all_services.dart';
import 'package:hamd_user/constants/colors.dart';
import 'package:hamd_user/providers/delivery_price_provider.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _googleMapController;
  Position? _currentPosition;
  String? _currentAddress;
  LatLng? _finalPosition;
  Marker? _origin;
  @override
  void dispose() {
    _googleMapController!.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
    getCurrentPosition();
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(39.645293, 66.954771),
    zoom: 11.5,
  );
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // locatinga ruxsat berilsa ishlidi
      getCurrentPosition();
    }
  }

  getCurrentPosition() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

        if (_googleMapController != null)
          _googleMapController!.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                    _currentPosition!.latitude, _currentPosition!.longitude),
                zoom: 15.0,
              ),
            ),
          );

        print('this is get current position method');
        print(_currentPosition);
        print(_currentPosition!.latitude);
        print(_currentPosition!.longitude);
        String pos =
            '${_currentPosition!.latitude}, ${_currentPosition!.longitude}';
        context.read<DeliveryPriceProvider>().fetchDeliveryPrice(context, pos);
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _finalPosition?.latitude == null
              ? _currentPosition!.latitude
              : _finalPosition!.latitude,
          _finalPosition?.longitude == null
              ? _currentPosition!.longitude
              : _finalPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street}";
        _finalPosition =
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      });
      print('=====');
      print(_currentAddress);
    } catch (e) {
      print(e);
    }
  }

  _getAddressFromLatLngOnMove(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.street}}";
        _finalPosition = LatLng(position.latitude, position.longitude);
      });

      String pos = '${_finalPosition!.latitude}, ${_finalPosition!.longitude}';
      context.read<DeliveryPriceProvider>().fetchDeliveryPrice(context, pos);
      _getAddressFromLatLng();
    } catch (e) {
      print(e);
    }
  }

  void _addMarker(LatLng pos) {
    setState(() {
      _origin = null;
    });
    if (_origin == null) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });
      _getAddressFromLatLngOnMove(pos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            markers: {
              if (_origin != null) _origin!,
            },
            onTap: (LatLng pos) => _addMarker(pos),
          ),
          SafeArea(
              child: Container(
            width: double.infinity,
            child: Column(
              children: [
                const Text(
                  'Адрес',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                // Consumer<DeliveryPriceProvider>(
                //   builder: (context, price, child) {
                //     return price.isLoading
                //         ? Text('')
                //         : Text(price.myLocation!.deliveryPrice.toString());
                //   },
                // ),
                // const SizedBox(height: 40),
                Text(
                  _currentAddress != null ? _currentAddress! : '',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0, right: 20),
              child: SizedBox(
                width: 240.0,
                height: 50.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  color: ColorPalatte.strongRedColor,
                  child: const Text(
                    'Готово',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      letterSpacing: 1.1,
                    ),
                  ),
                  onPressed: () {
                    print(_finalPosition);
                    print(_finalPosition!.latitude);
                    print(_finalPosition!.longitude);
                    Get.back(
                      result: {
                        'address': _currentAddress,
                        'position': _finalPosition,
                        // 'lat': _finalPosition.latitude.toString(),
                        // 'lng': _finalPosition.longitude.toString(),
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: ColorPalatte.strongRedColor,
            child: const Icon(
              Icons.near_me,
              size: 30.0,
            ),
            onPressed: () => _determinePosition()),
        // onPressed: () => getCurrentPosition()),
      ),
    );
  }
}
