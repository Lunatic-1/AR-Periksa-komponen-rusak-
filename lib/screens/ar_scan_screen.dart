import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import '../models/component.dart';
import '../services/api_service.dart';
import 'component_detail_screen.dart';

class ARScanScreen extends StatefulWidget {
  const ARScanScreen({super.key});

  @override
  State<ARScanScreen> createState() => _ARScanScreenState();
}

class _ARScanScreenState extends State<ARScanScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  final Map<String, Component> _placedNodes = {};
  bool _isPlacing = false;

  final ApiService _apiService = ApiService();
  List<Component> _availableComponents = [];

  @override
  void initState() {
    super.initState();
    _loadComponents();
  }

  Future<void> _loadComponents() async {
    try {
      final components = await _apiService.fetchComponents();
      setState(() {
        _availableComponents = components;
      });
    } catch (e) {
      // Handle error gracefully
      print('Gagal memuat komponen untuk AR: $e');
    }
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Komponen'),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Arahkan kamera ke permukaan komponen,\nlalu ketuk layar untuk menandai lokasi',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
  ) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    arAnchorManager = anchorManager;

    arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      showWorldOrigin: false,
      handleTaps: true,
    );
    arObjectManager!.onInitialize();

    arSessionManager!.onPlaneOrPointTap = _onPlaneTapped;
    arObjectManager!.onNodeTap = _onNodeTapped;
  }

  Future<void> _onPlaneTapped(List<ARHitTestResult> hitTestResults) async {
    if (_isPlacing) return; 
    
    // ignore: unused_local_variable
    final hit = hitTestResults.firstWhere(
      (result) => result.type == ARHitTestResultType.plane,
      orElse: () => hitTestResults.first,
    );

    final component = await _pickComponentToPlace();
    if (component == null) return;

    setState(() => _isPlacing = true);

    final newNode = ARNode(
      type: NodeType.localGLTF2,
      uri: component.modelAssetPath,
      scale: vector.Vector3(0.2, 0.2, 0.2),
      position: vector.Vector3(0.0, 0.0, 0.0),
    );

    final didAdd = await arObjectManager!.addNode(
      newNode,
      planeAnchor: null,
    );

    if (didAdd == true && newNode.name != null) {
      _placedNodes[newNode.name!] = component;
    }

    setState(() => _isPlacing = false);
  }

  void _onNodeTapped(List<String> nodeNames) {
    if (nodeNames.isEmpty) return;
    final component = _placedNodes[nodeNames.first];
    if (component == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ComponentDetailScreen(component: component)),
    );
  }

  Future<Component?> _pickComponentToPlace() {
    if (_availableComponents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data komponen belum dimuat')),
      );
      return Future.value(null);
    }
    
    return showModalBottomSheet<Component>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: _availableComponents.map((component) {
              return ListTile(
                title: Text(component.name),
                onTap: () => Navigator.pop(context, component),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
