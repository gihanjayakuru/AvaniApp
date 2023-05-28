import 'package:flutter/material.dart';
import 'form_data.dart';
import 'service_list.dart';
import 'database_helper.dart';

class LocationListScreen extends StatefulWidget {
  @override
  _LocationListScreenState createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<FormData> savedFormData = [];
  FormData? selectedFormData;

  @override
  void initState() {
    super.initState();
    _loadFormData();
  }

  void _loadFormData() async {
    List<Map<String, dynamic>> formDataList =
        await DatabaseHelper.instance.getFormDataList();

    savedFormData = formDataList.map((formDataMap) {
      return FormData(
        id: formDataMap['id'],
        location: formDataMap['location'],
        filterClean: formDataMap['filterClean'],
        blowerCheck: formDataMap['blowerCheck'],
        inspectCleanIduCoilFins: formDataMap['inspectCleanIduCoilFins'],
        checkCleanDrainPlate: formDataMap['checkCleanDrainPlate'],
        drainPumpCheck: formDataMap['drainPumpCheck'],
        checkPipingDuckInsulation: formDataMap['checkPipingDuckInsulation'],
        checkNoise: formDataMap['checkNoise'],
        indoorHousingCondition: formDataMap['indoorHousingCondition'],
        pcbStatus: formDataMap['pcbStatus'],
        acSlidinDoorOperation: formDataMap['acSlidinDoorOperation'],
        thermostatSetting: formDataMap['thermostatSetting'],
        drainLineClean: formDataMap['drainLineClean'],
        compressorNoise: formDataMap['compressorNoise'],
        fanNoise: formDataMap['fanNoise'],
        outdoorHousingCondition: formDataMap['outdoorHousingCondition'],
        remark: formDataMap['remark'],
        date: formDataMap['date'],
        technicianName: formDataMap['technicianName'],
      );
    }).toList();

    setState(() {
      // Trigger a rebuild to display the retrieved data
    });
  }

  void _deleteFormData(FormData formData) async {
    await DatabaseHelper.instance.deleteFormData(formData.id);

    setState(() {
      savedFormData.remove(formData);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item deleted'),
        duration: Duration(seconds: 2),
      ),
    );
  }

//
  void _showDetailsDialog(BuildContext context, FormData formData, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Location'),
                  subtitle: Text(formData.location ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Filter Clean'),
                  subtitle: Text(formData.filterClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Blower Check'),
                  subtitle: Text(formData.blowerCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Inspect Clean IDU Coil Fins'),
                  subtitle: Text(formData.inspectCleanIduCoilFins ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Clean Drain Plate'),
                  subtitle: Text(formData.checkCleanDrainPlate ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Drain Pump Check'),
                  subtitle: Text(formData.drainPumpCheck ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Piping Duck Insulation'),
                  subtitle: Text(formData.checkPipingDuckInsulation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Check Noise'),
                  subtitle: Text(formData.checkNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Indoor Housing Condition'),
                  subtitle: Text(formData.indoorHousingCondition ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('PCB Status'),
                  subtitle: Text(formData.pcbStatus ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('AC Sliding Door Operation'),
                  subtitle: Text(formData.acSlidinDoorOperation ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Thermostat Setting'),
                  subtitle: Text(formData.thermostatSetting ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Drain Line Clean'),
                  subtitle: Text(formData.drainLineClean ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Compressor Noise'),
                  subtitle: Text(formData.compressorNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Fan Noise'),
                  subtitle: Text(formData.fanNoise ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Outdoor Housing Condition'),
                  subtitle: Text(formData.outdoorHousingCondition ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Remark'),
                  subtitle: Text(formData.remark ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Date'),
                  subtitle: Text(formData.date ?? ''),
                ),
                Divider(),
                ListTile(
                  title: Text('Technician Name'),
                  subtitle: Text(formData.technicianName ?? ''),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationListScreen(
                        // formData: formData,
                        ),
                  ),
                );
              },
              child: Text('ADD'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FormData> filteredFormData = savedFormData.where((formData) {
      final location = formData.location.toLowerCase();
      final query = _searchController.text.toLowerCase();
      return location.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Location List Screen'),
      ),
      body: ListView.builder(
        itemCount: savedFormData.length,
        itemBuilder: (context, index) {
          FormData formData = savedFormData[index];
          return Card(
            child: ListTile(
              onTap: () {
                _showDetailsDialog(context, formData, index);
              },
              title: Text('location: ${formData.location ?? ''}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created: ${formData.date ?? ''}'),
                  Text('id: ${formData.id}'),
                  Text('technicianName: ${formData.technicianName ?? ''}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteFormData(formData);
                },
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (int index) {
          if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ServiceListScreen()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'LocationList',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ServiceList',
          ),
        ],
      ),
    );
  }
}
