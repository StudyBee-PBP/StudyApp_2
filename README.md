# Proyek Akhir Semester 

## Nama-nama anggota kelompok:
- Ardian - 2106638173
- I Dewa Putu Aditya Rahman - 2106650456
- Khairinka Rania Lizadhi - 2006597254
- Prudita Victory - 2006486071 
- Anandafa Syukur Rizky - 2106655040
- Muhammad Nabil Mahardika - 2106751871

--------

## Deskripsi aplikasi dan Daftar modul yang akan diimplementasikan
StudyBee adalah sebuah website aplikasi yang berguna bagi para pelajar dan mahasiswa dalam memudahkan mereka dalam memantau dan mengatur jadwal belajar mereka. Aplikasi ini menawarkan berbagai fitur yang berguna seperti daftar studi, forum diskusi tugas, jadwal semester, kalkulator nilai dan bobot, form diary, dan catatan kelas. Semua fitur tersebut dapat diakses secara online dan gratis.
Dengan menggunakan aplikasi ini, pengguna dapat mengoptimalkan waktu belajar mereka dan meningkatkan prestasi akademik mereka.

Daftar modul atau fitur-fitur yang akan diimplementasikan pada website StudyBee adalah sebagai berikut:

- Study List: Modul ini akan memungkinkan pengguna untuk mencatat dan mengatur daftar mata pelajaran dan tugas-tugas yang harus mereka selesaikan. Dengan modul ini, pengguna dapat memantau dan mengingatkan diri mereka sendiri tentang tugas-tugas yang harus diselesaikan.

- Forum Diskusi Tugas: Modul ini akan memungkinkan pengguna untuk berdiskusi dengan teman-teman mereka tentang tugas dan proyek tertentu. Hal ini akan membantu pengguna dalam memahami materi pelajaran dan mendapatkan ide-ide baru dari teman-teman mereka.

- Jadwal Semester: Modul ini akan memungkinkan pengguna untuk mengatur jadwal kuliah dan ujian mereka sehingga mereka dapat mengalokasikan waktu belajar mereka secara efisien.

- Kalkulator Nilai (Nilai & bobot): Modul ini akan membantu pengguna dalam menghitung nilai mereka dan bobot tugas mereka. Fitur ini akan membantu pengguna untuk memperkirakan nilai mereka dan memahami bagaimana bobot tugas tertentu dapat mempengaruhi nilai akhir mereka.

- Form Diary : Modul ini memungkinkan pengguna untuk menceritakan keluh kesah suka mau-pun duka dalam kegiatan sehari-harinya

- Class Notes: Modul ini akan memungkinkan pengguna untuk membuat catatan kelas mereka dan memperbaiki pemahaman mereka tentang materi pelajaran.

--------

## Alur pengintegrasian dengan web service untuk terhubung dengan aplikasi web yang sudah dibuat saat Proyek Tengah Semester
### django project
1. Membuat django-app bernama authentication
2. Menambahkan authentication ke INSTALLED_APPS pada django_tutorial/settings.py
3. Menjalankan perintah ```pip install django-cors-headers``` untuk menginstal library
4. Menambahkan corsheaders ke INSTALLED_APPS pada django_tutorial/settings.py
5. Menambahkan corsheaders.middleware.CorsMiddleware ke MIDDLEWARE pada django_tutorial/settings.py
6. Membuat sebuah variabel baru di django_tutorial/settings.py dengan nama CORS_ALLOW_ALL_ORIGINS dengan nilai True
7. Membuat sebuah variabel baru di django_tutorial/settings.py dengan nama CORS_ALLOW_CREDENTIALS dengan nilai True
8. Menambahkan variabel CSRF_COOKIE_SECURE dan SESSION_COOKIE_SECURE dengan nilai True pada keduanya pada django_tutorial/settings.py
9. Menambahkan variabel CSRF_COOKIE_SAMESITE dan SESSION_COOKIE_SAMESITE dengan nilai 'None' pada keduanya pada django_tutorial/settings.py
10. Membuat sebuah metode view untuk login pada authentication/views.py, yang menerima request POST username dan password dan mengautentikasi kedua variabel tersebut, lalu mengembalikan json response
11. Membuat file urls.py pada folder authentication dan menambahkan path login pada urlpatterns-nya
12. Menambahkan path('auth/', include('authentication.urls')), pada file django_tutorial/urls.py.
13. Membuat sebuah metode view untuk logout pada authentication/views.py, yang menerima request POST username dan melakukan logout user dengan username tersebut, lalu mengembalikan json response
14. Menambahkan path logout pada urlpatterns pada authentication/urls.py
15. Pada tiap views.py dari tiap app, menambahkan metode view create, yang menerima request post dengan format data json, dan membuat objek baru berdasarkan model dari masing-masing app
16. Menambahkan path metode view tersebut pada masing-masing urls.py app
17. Membuat sebuah metode view untuk register pada authentication/views.py, yang menerima request post dengan format data json, dan membuat objek User
18. Menambahkan path register pada urlpatterns pada authentication/urls.py
### main.dart
19. Menginstall provider package untuk menyebarkan informasi CookieRequest ke LoginApp
20. Menginstal pbp_django_auth yang dapat dipakai untuk melakukan kontak dengan web service Django (termasuk operasi GET dan POST) --> melakukan CookieRequest
21. Wrap MaterialApp Widget dengan Provider, lalu pada provider, buat variable CookieRequest. Hal tersebut bertujuan untuk membuat objek Provider baru yang akan membagikan instance CookieRequest dengan semua komponen yang ada di aplikasi, yang membolehkan request ke metode views django yang terautentikasi dengan @login_required decorator
22. Mengganti home dari ```MyHomePage()``` menjadi ``LoginApp()``
### login.dart 
23. Membuat file ```login.dart```
24. Membuat class ``LoginApp()`` yang akan menerima input dari user dengan TextField yang akan menerima username dan password. username dan password tersebut nantinya akan dikirim (POST) ke url dari metode view login di django yang telah kita buat sebelumnya dan akan dicek kredensialnya. Jika login berhasil, flutter akan mengarahkan ke ``MyHomePage()`` dan menampilkan snackbar. Sebaliknya, jika login gagal, alert dialog akan ditampilkan
### main.dart
25. Mengganti home menjadi ``LoginApp()``
### menu.dart
26.  Mengubah perintah onTap pada grid logout menjadi perintah logout dengan mengarahkan ke url dari metode view logout di django yang telah kita buat sebelumnya
### file yang menampilkan data
27. Membuat file pada masing-masing app yang akan menampilkan data yang telah dikonversi ke aplikasi dengan FutureBuilder dari masing-masing django app
### file yang mengintegrasi layanan form
28. Membuat file pada masing-masing app yang akan mengonversi data dalam bentuk json dan melakukan post ke django
