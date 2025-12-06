// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Thinkr';

  @override
  String get home_title => 'Mau mengambil keputusan apa hari ini?';

  @override
  String get home_newDecision => 'Keputusan baru';

  @override
  String get home_history => 'Riwayat';

  @override
  String get home_recentDecisions => 'Keputusan terbaru';

  @override
  String get home_viewAllHistory => 'Lihat semua riwayat';

  @override
  String get login_signIn => 'Masuk';

  @override
  String get login_signOut => 'Keluar';

  @override
  String get login_subtitleSignin =>
      'Selamat datang kembali. Masuk untuk melanjutkan.';

  @override
  String get login_subtitleSignup => 'Buat akun untuk menyimpan keputusanmu.';

  @override
  String get login_email => 'Email';

  @override
  String get login_password => 'Kata sandi';

  @override
  String get login_confirmPassword => 'Konfirmasi kata sandi';

  @override
  String get login_emailRequired => 'Email wajib diisi';

  @override
  String get login_emailInvalid => 'Masukkan email yang valid';

  @override
  String get login_passwordRequired => 'Kata sandi wajib diisi';

  @override
  String get login_passwordTooShort => 'Kata sandi minimal 6 karakter';

  @override
  String get login_passwordMismatch => 'Kata sandi tidak sama';

  @override
  String get login_signinCta => 'Masuk';

  @override
  String get login_signupCta => 'Buat akun';

  @override
  String get login_needAccount => 'Belum punya akun? Daftar';

  @override
  String get login_haveAccount => 'Sudah punya akun? Masuk';

  @override
  String get login_orContinueWith => 'atau lanjut dengan';

  @override
  String get login_signinSuccess => 'Berhasil masuk';

  @override
  String get login_signupSuccess => 'Akun berhasil dibuat';

  @override
  String get history_title => 'Riwayat keputusan';

  @override
  String get history_emptyTitle => 'Belum ada keputusan';

  @override
  String get history_emptySubtitle => 'Buat keputusan untuk melihat di sini.';

  @override
  String get history_newDecision => 'Keputusan baru';

  @override
  String get history_options => 'opsi';

  @override
  String get history_criteria => 'kriteria';

  @override
  String history_bestOption(Object option) {
    return 'Terbaik: $option';
  }

  @override
  String get history_delete => 'Hapus';

  @override
  String get history_errorTitle => 'Gagal memuat riwayat';

  @override
  String get history_retry => 'Coba lagi';

  @override
  String get decision_editor_stepOptions => 'Tambah opsi';

  @override
  String get decision_editor_stepCriteria => 'Tambah kriteria & bobot';

  @override
  String get decision_editor_stepScores => 'Nilai setiap opsi';

  @override
  String get decision_editor_stepEvaluate => 'Next';

  @override
  String get settings_language => 'Bahasa';

  @override
  String get settings_language_english => 'Inggris';

  @override
  String get settings_language_indonesian => 'Indonesia';

  @override
  String get login_title => 'Masuk';

  @override
  String get login_welcome => 'Selamat datang di Thinkr';

  @override
  String get login_signInWithGoogle => 'Masuk dengan Google';

  @override
  String get decision_editor_title => 'Editor keputusan';

  @override
  String get decision_editor_subtitle =>
      'Tambah opsi, kriteria, bobot, dan skor untuk mendapat rekomendasi peringkat.';

  @override
  String get decision_editor_evaluate => 'Evaluasi';

  @override
  String get decision_editor_evaluating => 'Memproses...';

  @override
  String get decision_editor_save => 'Simpan keputusan';

  @override
  String get decision_editor_saving => 'Menyimpan...';

  @override
  String get decision_editor_saved => 'Keputusan tersimpan';

  @override
  String get decision_editor_defaultTitle => 'Keputusan tanpa judul';

  @override
  String get decision_editor_evaluatedChip => 'Sudah dievaluasi';

  @override
  String get decision_editor_titleLabel => 'Judul';

  @override
  String get decision_editor_titleHint => 'Apa yang ingin kamu putuskan?';

  @override
  String get decision_editor_optionsTitle => 'Opsi';

  @override
  String get decision_editor_optionsDescription =>
      'Daftar semua opsi yang dipertimbangkan.';

  @override
  String get decision_editor_optionHint => 'Tambah opsi';

  @override
  String get decision_editor_addOption => 'Tambah opsi';

  @override
  String get decision_editor_noOptions =>
      'Belum ada opsi. Tambah setidaknya dua untuk dibandingkan.';

  @override
  String get decision_editor_criteriaTitle => 'Kriteria & bobot';

  @override
  String get decision_editor_criteriaDescription =>
      'Hal apa yang penting? Atur bobot relatif tiap kriteria.';

  @override
  String get decision_editor_criterionHint => 'Tambah kriteria';

  @override
  String get decision_editor_weightLabel => 'Bobot';

  @override
  String get decision_editor_addCriterion => 'Tambah kriteria';

  @override
  String get decision_editor_weightsNote => 'Bobot dinormalisasi otomatis.';

  @override
  String get decision_editor_noCriteria =>
      'Belum ada kriteria. Tambah hal yang kamu nilai.';

  @override
  String get decision_editor_remove => 'Hapus';

  @override
  String get decision_editor_scoresTitle => 'Matriks skor';

  @override
  String get decision_editor_scoresDescription =>
      'Beri skor setiap opsi untuk tiap kriteria (rentang 0-10 cocok).';

  @override
  String get decision_editor_scoresEmpty =>
      'Tambahkan minimal satu opsi dan satu kriteria untuk mulai memberi skor.';

  @override
  String get decision_editor_scoreOptionHeader => 'Opsi';

  @override
  String get decision_editor_scorePlaceholder => '0-10';

  @override
  String get decision_editor_scoreRange => 'Nilai harus antara 1 sampai 10.';

  @override
  String get settings_title => 'Pengaturan';

  @override
  String get settings_languageLabel => 'Bahasa';

  @override
  String get decision_editor_resultTitle => 'Hasil';

  @override
  String get decision_editor_resultDescription =>
      'Evaluasi untuk melihat peringkat berbobot.';

  @override
  String get decision_editor_bestOption => 'Opsi terbaik';

  @override
  String get decision_editor_unknownOption => 'Opsi tidak dikenal';

  @override
  String get decision_editor_ranking => 'Peringkat';

  @override
  String get decision_editor_descriptionLabel => 'Deskripsi';

  @override
  String get decision_editor_descriptionHint =>
      'Tambahkan konteks atau batasan (opsional).';

  @override
  String get decision_editor_optionLabel => 'Opsi';

  @override
  String get decision_editor_criterionLabel => 'Kriteria';

  @override
  String get decision_editor_scoreHint =>
      'Tips: skor bisa pakai skala apa saja, misal 0-10.';

  @override
  String get decision_editor_scoreDefaultZero => 'Skor kosong dihitung 0.';

  @override
  String get decision_editor_validationOptions => 'Tambahkan minimal dua opsi.';

  @override
  String get decision_editor_validationCriteria =>
      'Tambahkan minimal satu kriteria.';

  @override
  String decision_editor_validationScores(int count) {
    return '$count skor masih kosong (dihitung 0).';
  }

  @override
  String get decision_editor_fixValidation =>
      'Lengkapi bagian wajib untuk lanjut.';

  @override
  String get decision_editor_templatesTitle => 'Template';

  @override
  String get decision_editor_templatesDescription =>
      'Mulai dari preset lalu sesuaikan.';

  @override
  String decision_editor_templateApplied(Object name) {
    return 'Template digunakan: $name';
  }

  @override
  String get decision_editor_templateCareer => 'Pilihan karier';

  @override
  String get decision_editor_templateCareerDesc =>
      'Bandingkan bertahan, pindah, atau freelance.';

  @override
  String get decision_editor_templateCareer_optionStay =>
      'Tetap di peran sekarang';

  @override
  String get decision_editor_templateCareer_optionNewCompany =>
      'Gabung perusahaan baru';

  @override
  String get decision_editor_templateCareer_optionFreelance =>
      'Freelance / konsultan';

  @override
  String get decision_editor_templateCareer_critComp => 'Kompensasi';

  @override
  String get decision_editor_templateCareer_critGrowth =>
      'Pertumbuhan & belajar';

  @override
  String get decision_editor_templateCareer_critBalance =>
      'Keseimbangan hidup-kerja';

  @override
  String get decision_editor_templateCareer_critStability => 'Stabilitas';

  @override
  String get decision_editor_templateProduct => 'Keputusan produk';

  @override
  String get decision_editor_templateProductDesc =>
      'Bangun vs beli vs open-source.';

  @override
  String get decision_editor_templateProduct_optionSaas => 'Beli SaaS';

  @override
  String get decision_editor_templateProduct_optionBuild => 'Bangun internal';

  @override
  String get decision_editor_templateProduct_optionOpenSource =>
      'Adopsi open-source';

  @override
  String get decision_editor_templateProduct_critCost => 'Biaya total';

  @override
  String get decision_editor_templateProduct_critSpeed => 'Waktu ke nilai';

  @override
  String get decision_editor_templateProduct_critScalability => 'Skalabilitas';

  @override
  String get decision_editor_templateProduct_critSupport =>
      'Dukungan & pemeliharaan';

  @override
  String get decision_editor_templateTravel => 'Rencana perjalanan';

  @override
  String get decision_editor_templateTravelDesc =>
      'Pilih gaya liburan terbaik.';

  @override
  String get decision_editor_templateTravel_optionBeach => 'Pantai / santai';

  @override
  String get decision_editor_templateTravel_optionCity => 'Kota / budaya';

  @override
  String get decision_editor_templateTravel_optionNature =>
      'Alam / petualangan';

  @override
  String get decision_editor_templateTravel_critBudget => 'Anggaran';

  @override
  String get decision_editor_templateTravel_critActivities =>
      'Aktivitas & pengalaman';

  @override
  String get decision_editor_templateTravel_critWeather => 'Preferensi cuaca';

  @override
  String get decision_editor_templateTravel_critTravelTime =>
      'Waktu perjalanan';

  @override
  String get decision_editor_templateFinance => 'Langkah finansial';

  @override
  String get decision_editor_templateFinanceDesc => 'Pilih alokasi dana.';

  @override
  String get decision_editor_templateFinance_optionIndex =>
      'Reksa dana indeks / ETF';

  @override
  String get decision_editor_templateFinance_optionRealEstate => 'Properti';

  @override
  String get decision_editor_templateFinance_optionCash => 'Tunai / tabungan';

  @override
  String get decision_editor_templateFinance_critRisk => 'Risiko';

  @override
  String get decision_editor_templateFinance_critReturn =>
      'Potensi imbal hasil';

  @override
  String get decision_editor_templateFinance_critLiquidity => 'Likuiditas';

  @override
  String get decision_editor_templateFinance_critHorizon => 'Horizon waktu';

  @override
  String get docs_title => 'Panduan Pengguna';

  @override
  String get docs_gettingStartedTitle => 'Memulai';

  @override
  String get docs_gettingStartedItem1 =>
      'Masuk dengan Google (web redirect, mobile di dalam aplikasi).';

  @override
  String get docs_gettingStartedItem2 =>
      'Beranda menampilkan hero prompt, keputusan terbaru, dan aksi cepat.';

  @override
  String get docs_createTitle => 'Buat Keputusan';

  @override
  String get docs_createItem1 => 'Judul & deskripsi: judul wajib diisi.';

  @override
  String get docs_createItem2 => 'Opsi: tambah minimal 2.';

  @override
  String get docs_createItem3 =>
      'Kriteria: tambah bobot (1–10) dan minimal 1 kriteria.';

  @override
  String get docs_createItem4 =>
      'Skor: isi semua pasangan opsi×kriteria dengan skor 1–10.';

  @override
  String get docs_createItem5 =>
      'Evaluasi menjalankan WSM di server dan menyimpan otomatis setelah konfirmasi.';

  @override
  String get docs_createItem6 =>
      'Perubahan belum disimpan akan diminta konfirmasi saat kembali.';

  @override
  String get docs_templatesTitle => 'Template';

  @override
  String get docs_templatesItem1 =>
      'Gunakan template Karier/Produk/Travel/Finance untuk pra-isi.';

  @override
  String get docs_templatesItem2 =>
      'Edit nilai yang sudah terisi sebelum memberi skor.';

  @override
  String get docs_resultsTitle => 'Hasil';

  @override
  String get docs_resultsItem1 =>
      'Menampilkan opsi terbaik, peringkat dengan skor, dan info meta.';

  @override
  String get docs_resultsItem2 =>
      'Data debug dari Edge Function jika tersedia.';

  @override
  String get docs_historyTitle => 'Riwayat & Pencarian';

  @override
  String get docs_historyItem1 =>
      'Lihat keputusan tersimpan; mobile scroll tanpa batas, web halaman.';

  @override
  String get docs_historyItem2 => 'Cari berdasarkan judul/deskripsi.';

  @override
  String get docs_historyItem3 =>
      'Ketuk untuk melihat hasil (jika sudah dievaluasi) atau edit & evaluasi ulang.';

  @override
  String get docs_historyItem4 => 'Hapus dilakukan secara soft delete.';

  @override
  String get docs_languageTitle => 'Bahasa';

  @override
  String get docs_languageItem1 =>
      'Ganti Inggris/Bahasa lewat ikon header atau Pengaturan.';

  @override
  String get docs_authTitle => 'Autentikasi';

  @override
  String get docs_authItem1 =>
      'Hanya Google Sign-In; logout di header dengan konfirmasi.';

  @override
  String get docs_methodTitle => 'Metode Keputusan';

  @override
  String get docs_methodItem1 =>
      'Weighted Sum Model: normalisasi bobot, kalikan skor (1–10), jumlahkan dan urutkan.';

  @override
  String get docs_methodItem2 =>
      'Dihitung di Supabase Edge Function `evaluate_decision`.';
}
