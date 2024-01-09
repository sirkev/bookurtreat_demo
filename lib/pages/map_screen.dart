import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:logger/logger.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.listenerMapSingleTapping.addListener(() async {
        var position = controller.listenerMapSingleTapping.value!;
        if (position != null) {
          await controller.addMarker(position,
              markerIcon: MarkerIcon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.red,
                ),
              ));
        }
      });
    });
  }

  final logger = Logger();

  // default constructor
  // MapController controller = MapController(
  //   initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
  //   areaLimit: BoundingBox(
  //     east: 10.4922941,
  //     north: 47.8084648,
  //     south: 45.817995,
  //     west:  5.9559113,
  //   ),
  // );
  // final controller = MapController.withPosition(
  //   initPosition: GeoPoint(
  //     latitude: 47.4358055,
  //     longitude: 8.4737324,
  //   ),
  // );
  final controller = MapController(
      initMapWithUserPosition: UserTrackingOption(enableTracking: true),
      areaLimit: BoundingBox.world());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Street Maps Demo'),
      ),
      body: OSMFlutter(
          controller: controller,
          // mapIsLoading: const Center(child: CircularProgressIndicator(),),
          onMapIsReady: (bool isReady) async {
            if (isReady) {
              await controller.currentLocation();
            }
          },
          onGeoPointClicked: (point) {
            showModalBottomSheet(context: context, builder: (context){
              return Card(color: Colors.white,child:Text('${point.longitude}') ,);
            });

          },
          onLocationChanged: (point) {},
          osmOption: OSMOption(
            userTrackingOption: const UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: const ZoomOption(
              initZoom: 12,
              minZoomLevel: 3,
              maxZoomLevel: 14,
              stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
              personMarker: const MarkerIcon(
                icon: Icon(
                  Icons.personal_injury,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: const MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            roadConfiguration: const RoadOption(
              roadColor: Colors.blueGrey,
            ),
            markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.red,
                size: 56,
              ),
            )),
          )),
    );
  }
}
