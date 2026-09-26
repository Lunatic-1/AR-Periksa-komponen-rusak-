import '../models/component.dart';

/// Data contoh — digunakan sebagai fallback jika API gagal dijangkau atau sedang masa development.
final List<Component> sampleComponents = [
  const Component(
    id: 'fan-01',
    name: 'Kipas Pendingin (Cooling Fan)',
    status: ComponentStatus.damaged,
    description:
        'Kipas menunjukkan getaran tidak normal dan suara berisik saat beroperasi. '
        'Kemungkinan bearing aus atau baling-baling tidak seimbang.',
    modelAssetPath: 'assets/models/fan.glb',
    maintenanceSteps: [
      MaintenanceStep(
        title: 'Matikan daya utama',
        description:
            'Pastikan sumber listrik ke unit sudah diputus total sebelum membuka casing.',
      ),
      MaintenanceStep(
        title: 'Lepas baut casing',
        description: 'Gunakan obeng plus untuk melepas 4 baut penutup kipas.',
      ),
      MaintenanceStep(
        title: 'Periksa bearing kipas',
        description:
            'Cek apakah bearing aus atau kering; beri pelumas jika masih bisa diselamatkan, '
            'ganti jika sudah longgar.',
      ),
      MaintenanceStep(
        title: 'Pasang kembali & uji nyala',
        description: 'Rakit ulang casing, nyalakan unit, dan pastikan suara sudah normal.',
      ),
    ],
  ),
  const Component(
    id: 'belt-02',
    name: 'Belt Konveyor',
    status: ComponentStatus.warning,
    description:
        'Belt menunjukkan tanda keausan pada tepi. Belum kritis, tapi perlu '
        'pemeriksaan berkala agar tidak putus mendadak.',
    modelAssetPath: 'assets/models/belt.glb',
    maintenanceSteps: [
      MaintenanceStep(
        title: 'Cek ketegangan belt',
        description: 'Pastikan tensi belt sesuai spesifikasi pada manual mesin.',
      ),
      MaintenanceStep(
        title: 'Periksa alignment',
        description: 'Pastikan belt sejajar dengan pulley, tidak miring ke salah satu sisi.',
      ),
    ],
  ),
  const Component(
    id: 'motor-03',
    name: 'Motor Listrik',
    status: ComponentStatus.normal,
    description: 'Kondisi motor saat ini normal. Tidak ada tindakan yang diperlukan.',
    modelAssetPath: 'assets/models/motor.glb',
    maintenanceSteps: [
      MaintenanceStep(
        title: 'Pemeriksaan rutin',
        description: 'Lanjutkan jadwal pemeriksaan berkala sesuai SOP.',
      ),
    ],
  ),
];
