import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:we_chat_app/location_services.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  String? lat, lng;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(23.04514731288731, 72.51512427787496),
    zoom: 17.4746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{
    MarkerId('marker_id_1'): Marker(
      markerId: MarkerId('marker_id_1'),
      position: LatLng(23.04514731288731, 72.51512427787496),
      infoWindow: InfoWindow(
        title: 'My current location',
      ),
      onTap: () {
        //_onMarkerTapped(markerId);
      },
      onDragEnd: (LatLng position) {},
    )
  };
  GoogleMapController? mapController;
  void liveLocation() async {
    LocationService service = LocationService();
    var locationData = await service.getLocation();
    setState(() {
      lat = locationData!.latitude.toString();
      lng = locationData!.longitude.toString();
      kGooglePlex = CameraPosition(
        target: LatLng(double.parse(lat!), double.parse(lng!)),
        zoom: 17.4746,
      );

      markers = <MarkerId, Marker>{
        MarkerId('marker_id_1'): Marker(
          markerId: MarkerId('marker_id_1'),
          position: LatLng(double.parse(lat!), double.parse(lng!)),
          infoWindow: InfoWindow(
            title: 'My current location',
          ),
          onTap: () {
            //_onMarkerTapped(markerId);
          },
          onDragEnd: (LatLng position) {},
        )
      };
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(double.parse(lat!), double.parse(lng!)), zoom: 17)
          //17 is new zoom level
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 650,
              child: GoogleMap(
                mapType: MapType.normal,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers.values),
                initialCameraPosition: kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      liveLocation();
                    },
                    child: Text('Get Current Location'))),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      if (lat != null && lng != null) {
                        Navigator.pop(context, ({"lat": lat, "lng": lng}));
                      } else {
                        liveLocation();
                      }

                      /*liveLocation();
                      ChatController().addChatToFirebase();
                      Navigator.pop(context,({"lat":lat,"lng":lng}));*/
                    },
                    child: Text('Share Current Location')))
          ],
        ),
      ),
    );
  }
}
