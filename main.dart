import 'package:flutter/material.dart';

void main() => runApp(const MashinistKuryerApp());

const navy = Color(0xFF173B62);
const green = Color(0xFF16865B);

class MashinistKuryerApp extends StatelessWidget {
  const MashinistKuryerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MASHINIST KURYER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MASHINIST KURYER')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Xush kelibsiz!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Kerakli kabinetni tanlang.'),
          const SizedBox(height: 20),
          RoleCard(
            icon: Icons.train,
            title: 'Mashinist kabineti',
            subtitle: 'Ro‘yxatdan o‘tish va konvert uchun buyurtma berish',
            onTap: () => open(context, const RegistrationScreen(role: 'Mashinist')),
          ),
          RoleCard(
            icon: Icons.delivery_dining,
            title: 'Kuryer kabineti',
            subtitle: 'Ro‘yxatdan o‘tish, buyurtmani qabul qilish va yetkazish',
            onTap: () => open(context, const RegistrationScreen(role: 'Kuryer')),
          ),
          RoleCard(
            icon: Icons.admin_panel_settings,
            title: 'Administrator kabineti',
            subtitle: 'Arizalar, buyurtmalar va moliya nazorati',
            onTap: () => open(context, const AdminScreen()),
          ),
          const SizedBox(height: 12),
          Card(
            color: Colors.amber.shade50,
            child: const Padding(
              padding: EdgeInsets.all(14),
              child: Text(
                'DIQQAT: Bu dastlabki prototip. SMS, xarita/GPS, to‘lov va server hozircha ulanmagan.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const RoleCard({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(backgroundColor: navy.withOpacity(.1), child: Icon(icon, color: navy)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text(subtitle)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  final String role;
  const RegistrationScreen({super.key, required this.role});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final name = TextEditingController();
  final phone = TextEditingController(text: '+998');
  final workplace = TextEditingController();
  String vehicle = 'Avtomobil';
  bool submitted = false;

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    workplace.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courier = widget.role == 'Kuryer';
    return Scaffold(
      appBar: AppBar(title: Text('${widget.role} ro‘yxatdan o‘tishi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Ma’lumotlaringizni kiriting', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: name, decoration: const InputDecoration(labelText: 'F.I.Sh.', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: phone, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Telefon raqami', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          if (!courier)
            TextField(controller: workplace, decoration: const InputDecoration(labelText: 'Lokomotiv deposi / ish joyi', border: OutlineInputBorder()))
          else ...[
            TextField(controller: workplace, decoration: const InputDecoration(labelText: 'Yashash hududi', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: vehicle,
              decoration: const InputDecoration(labelText: 'Transport turi', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'Avtomobil', child: Text('Avtomobil')),
                DropdownMenuItem(value: 'Mototsikl', child: Text('Mototsikl')),
              ],
              onChanged: (v) => setState(() => vehicle = v ?? 'Avtomobil'),
            ),
            const SizedBox(height: 12),
            const Card(child: Padding(
              padding: EdgeInsets.all(14),
              child: Text('Keyingi bosqichda haydovchilik guvohnomasi va transport texnik pasporti suratlarini yuklash oynasi qo‘shiladi.'),
            )),
          ],
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              if (name.text.trim().isEmpty || phone.text.trim().length < 10 || workplace.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Barcha maydonlarni to‘ldiring.')));
                return;
              }
              setState(() => submitted = true);
            },
            child: const Text('SMS kod olish'),
          ),
          if (submitted) ...[
            const SizedBox(height: 16),
            const Card(
              color: Color(0xFFEAF4FF),
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text('Namuna: haqiqiy SMS yuborilmadi. Hisob administrator tekshiruvidan keyin faollashtiriladi.'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administrator kabineti')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(leading: Icon(Icons.person_search), title: Text('Yangi arizalar'), subtitle: Text('Mashinist va kuryerlarni tekshirish'))),
          Card(child: ListTile(leading: Icon(Icons.assignment), title: Text('Buyurtmalar'), subtitle: Text('Faol, yakunlangan va bekor qilingan buyurtmalar'))),
          Card(child: ListTile(leading: Icon(Icons.account_balance_wallet), title: Text('Moliya'), subtitle: Text('10% komissiya va kuryer balanslari'))),
          Card(child: ListTile(leading: Icon(Icons.report_problem), title: Text('Xavfsizlik hodisalari'), subtitle: Text('Kuryer yuborgan xabarlar va kechikishlar'))),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text('Bu hozircha namuna ekran. Haqiqiy administrator kirishi, ma’lumotlar bazasi va ruxsatlar keyin ulanadi.'),
          ),
        ],
      ),
    );
  }
}
