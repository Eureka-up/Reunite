/// Bundled offline fallback of Egypt governorates with main cities/districts.
///
/// The UI NEVER reads this directly — it goes through [LocationsRepository]
/// (`GET /locations/governorates` in real mode, this bundle in mock mode
/// or when the API is unreachable). The UI shows two dropdowns:
/// governorate -> city. **Only the city value is sent to the API**
/// (`POST /auth/register { ..., city }`).
class EgyptLocations {
  const EgyptLocations._();

  /// Governorate -> list of cities. Values are sent/stored as-is (Arabic).
  static const Map<String, List<String>> governorateCities = {
    'القاهرة': ['مدينة نصر', 'مصر الجديدة', 'المعادي', 'حلوان', 'شبرا', 'عين شمس', 'التجمع الخامس'],
    'الجيزة': ['فيصل', 'الهرم', '6 أكتوبر', 'الشيخ زايد', 'إمبابة', 'البدرشين'],
    'الإسكندرية': ['المنتزه', 'سيدي جابر', 'محرم بك', 'العجمي', 'برج العرب'],
    'الدقهلية': ['المنصورة', 'طلخا', 'ميت غمر', 'دكرنس'],
    'البحر الأحمر': ['الغردقة', 'مرسى علم', 'سفاجا', 'القصير'],
    'البحيرة': ['دمنهور', 'كفر الدوار', 'رشيد', 'إيتاي البارود'],
    'الفيوم': ['الفيوم', 'سنورس', 'إطسا'],
    'الغربية': ['طنطا', 'المحلة الكبرى', 'كفر الزيات', 'زفتى'],
    'الإسماعيلية': ['الإسماعيلية', 'فايد', 'القنطرة'],
    'المنوفية': ['شبين الكوم', 'منوف', 'السادات'],
    'المنيا': ['المنيا', 'ملوي', 'مغاغة'],
    'القليوبية': ['بنها', 'شبرا الخيمة', 'قليوب', 'العبور'],
    'الوادي الجديد': ['الخارجة', 'الداخلة'],
    'السويس': ['السويس', 'الأربعين', 'عتاقة'],
    'أسوان': ['أسوان', 'كوم أمبو', 'إدفو'],
    'أسيوط': ['أسيوط', 'ديروط', 'منفلوط'],
    'بني سويف': ['بني سويف', 'الواسطى', 'ناصر'],
    'بورسعيد': ['بورسعيد', 'بورفؤاد'],
    'دمياط': ['دمياط', 'رأس البر', 'كفر سعد'],
    'الشرقية': ['الزقازيق', 'العاشر من رمضان', 'بلبيس'],
    'جنوب سيناء': ['شرم الشيخ', 'دهب', 'نويبع'],
    'كفر الشيخ': ['كفر الشيخ', 'دسوق', 'فوه'],
    'مطروح': ['مرسى مطروح', 'الحمام', 'الضبعة'],
    'الأقصر': ['الأقصر', 'إسنا', 'أرمنت'],
    'قنا': ['قنا', 'نجع حمادي', 'قوص'],
    'شمال سيناء': ['العريش', 'رفح', 'الشيخ زويد'],
    'سوهاج': ['سوهاج', 'جرجا', 'طهطا'],
  };

  static List<String> get governorates => governorateCities.keys.toList();

  static List<String> citiesOf(String? governorate) =>
      governorate == null ? const [] : governorateCities[governorate] ?? const [];
}
