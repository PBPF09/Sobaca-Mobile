
# **SOBACA Mobile (Sobat Membaca Mobile)**
[Klik Disini untuk melihat Sobaca Mobile](https://)

Sobaca Mobile merupakan platform aplikasi mobile yang siap untuk menemani sobat membaca yang gemar dalam dunia literasi. Sobaca Mobile terinspirasi dari aplikasi Django kami yang memiliki nama Sobaca. Sobaca Mobile dibuat oleh tim F09 yang beranggotakan:
* Aaron Mario Lin - 2206082341
* Anastasia Keisha Bella Arianne Pepe - 2206082272
* Kelvin Saputra - 2206027186
* Tajri Mintahtihal Anhaar - 2206030312 
* Tegar Wahyu Khisbulloh - 2206082032


---

##    Fitur Sobaca Mobile
Pada project ini, kami memutuskan untuk meneruskan ide dan tema dari aplikasi Django kami, yakni Sobaca, pada framework Flutter. Secara keseluruhan, modul-modul yang telah kami implementasikan di Django akan mempertahankan fungsionalitasnya, hanya saja kami ubah untuk lebih cocok pada perangkat mobile. Berikut adalah penjelasan dan pembagian modul yang akan kami implementasi pada Sobaca Mobile.

| No  | Nama Modul| Penjelasan Fitur | Penanggung Jawab |
| --- | --------- | ---------------- | ----------|
| 1.  | Modul Utama dan Modul Objectives | Pada modul utama akan ditampilkan home page dari Sobaca. Akan ada beberapa opsi untuk melihat katalog buku, melakukan login, atau membuat akun baru. Memilih salah satu fitur akan mengarahkan pengguna ke modul berikutnya. Pada modul objectives, pengguna dapat membuat semacam target mereka yang dapat disimpan dan diedit di aplikasi. | Aaron Mario Lin |
| 2.  | Modul User Registered | Pada modul ini, pengguna dapat mengedit profil dan melihat yang mereka sudah daftarkan. Di dalam modul ini juga terdapat rak buku login user yang menampilkan buku-buku yang sedang dan telah dibaca. Selain itu, terdapat fitur wishlist yang menampilkan buku-buku yang ingin dibaca oleh pengguna.| Anastasia Keisha Bella Arianne Pepe |
| 3.  | Modul Diskusi Buku | Pada modul ini pengguna dapat membuat thread terhadap suatu buku. Selanjutnya, fitur yang dapat digunakan oleh pengguna dalam modul ini adalah membalas diskusi dari pengguna lain, sehingga modul ini dapat dijadikan media diskusi buku yang terkait. | Kelvin Saputra | 
| 4.  | Modul Pencarian Buku | Modul ini digunakan untuk melakukan pencarian terhadap suatu buku berdasarkan nama buku, penulis buku, dan genre buku dengan kriteria *ascending*, dan *descending* serta menyaring buku sesuai genre. Selain itu, user juga dapat memberikan masukan untuk buku yang ingin ditambahkan jika pencarian buku tidak ditemukan di Sobaca. | Tajri Mintahtihal Anhaar |
| 5.  | Modul Data Buku | Modul ini mengatur seluruh data buku yang ada, seperti penambahan dan pengurangan buku ke dalam katalog buku. Modul ini juga digunakan untuk menampilkan rincian masing-masing buku seperti judul, penulis, dan tanggal terbit dan juga fitur review buku. | Tegar Wahyu Khisbulloh |


##    User Role Sobaca Mobile
Dalam pembagian role, kami juga mempertahankan role-role yang telah ada pada Sobaca, pada Sobaca Mobile.

* **Guest** 
**Guest** merupakan pengguna yang tidak melakukan registrasi/login. Secara singkat, _priviledge_ yang dimiliki oleh **Guest** hanya untuk mengakses dan menavigasi dalam homepage situs web tanpa hak akses atau izin lebih lanjut untuk menjelajahi, mengedit, atau mengakses fitur, halaman, atau konten lain yang ada.

* **User**
User adalah pengguna aplikasi yang telah melakukan registrasi/login. **User** dapat melakukan registrasi serta autentikasi profil **User**. Selain itu, ia juga mendapatkan akses ke mayoritas fitur yang dimiliki Sobaca seperti pencarian buku, mengulas buku, menambahkan buku ke dalam rak buku user, dan mengakses rincian buku yang tersedia di Sobaca. Suatu user juga memiliki rak buku sendiri, yang dapat ia isi dengan buku yang sedang dia baca, sudah selesai baca, atau sedang ingin dibaca.

* **Admin**
Peran dari admin adalah sebagai pengatur dan penanggung-jawab dari aplikasi Sobaca. Ia memiliki peran dan tanggung jawab meng-update katalog buku yang ada di Sobaca dari dataset yang digunakan lengkap dengan data-datanya, serta otentikasi dan otorisasi akses yang didapatkan oleh **User**.


##    Integrasi Terhadap *website Sobaca*
Selain itu, Sobaca Mobile juga akan terintegrasi dengan Sobaca, supaya pengguna-pengguna yang telah memiliki akun di Sobaca turut dapat menggunakan Sobaca Mobile. Hal tersebut kami implementasikan dengan cara berikut:

1. Website Sobaca yang sudah dibuat sebelumnya memiliki beberapa fungsi yang dapat menampilkan data-data dalam bentuk JSON.
2. Selanjutnya, pada project flutter ini, kami akan membuat file bernama fetch.dart di dalam folder utils untuk mengambil data-data yang terdapat aplikasi web tersebut secara asynchronous.
3. File fetch.dart dilengkapi dengan suatu fungsi yang dapat dipanggil dari luar file yang kemudian dapat melakukan return data dalam bentuk list.
4. Fungsi-fungsi yang terdapat pada fetch.dart memiliki sambungan url yang dapat digunakan sebagai endpoint JSON.
5. Selanjutnya fungsi-fungsi yang sudah terhubung dapat digunakan untuk berbagai kegiatan sesuai dengan kebutuhan fungsionalitas.

## Berita Acara pembuatan aplikasi
[Link Akses Berita Acara](https://docs.google.com/spreadsheets/d/1vQlOEZ4l_aohvcd3fCuHrFk5nsEkrvih/edit?usp=sharing&ouid=109455504393646931649&rtpof=true&sd=true)