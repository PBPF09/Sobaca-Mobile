import 'package:flutter/material.dart';
import 'package:sobaca_mobile/details/deskripsi_screen.dart';

class DetailBuku extends StatelessWidget {
  const DetailBuku({Key? key}) : super(key: key);

  String get deskripsiBuku =>
      "This is the most authoritative and highly literate account of these pernicious people that I have ever read.”—Patrick O'Brian “[A] wonderfully entertaining history of pirates and piracy . . . a rip-roaring read . . . fascinating and unexpected.”—Men's Journal This rollicking account of the golden age of piracy is packed with vivid history and high seas adventure. David Cordingly, an acclaimed expert on pirates, reveals the spellbinding truth behind the legends of Blackbeard, Captain Kidd, Sir Francis Drake, the fierce female brigands Mary Read and Anne Bonny, and others who rode and robbed upon the world's most dangerous waters. Here, in thrilling detail, are the weapons they used, the ships they sailed, and the ways they fought—and were defeated. Under the Black Flag also charts the paths of fictional pirates such as Captain Hook and Long John Silver. The definitive resource on the subject, this book is as captivating as it is supremely entertaining. Praise for Under the Black Flag “[A] lively history . . . If you've ever been seduced by the myth of the cutlass-wielding pirate, consider David Cordingly's Under the Black Flag.”—USA Today, “Best Bets” “Engagingly told . . . a tale of the power of imaginative literature to re-create the past.”—Los Angeles Times “Entirely engaging and informative . . . a witty and spirited book.”—The Washington Post Book World “Plenty of thrills and adventure to satisfy any reader.”—The Philadelphia Inquirer";

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.only(top: 20, bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.chevron_left_rounded,
                      size: 30, color: Colors.white)),
              const Text(
                "Detail Buku",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Icon(Icons.more_vert_rounded, color: Colors.white)
            ],
          ));
    }

    Widget coverBuku() {
      return Container(
          height: 250,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.network(
                      'http://books.google.com/books/content?id=fnoi6SM1u5cC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api')
                  .image,
            ),
          ));
    }

    Widget footer() {
      return Positioned(
        // posisi akan selalu berada di bagian bawah layar
        bottom: 20,
        left: 20,
        right: 20,
        child: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width - 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: const Color(0xFF327957),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Simpan ke Rak Buku',
                            style: TextStyle(color: Color(0xFF327957))),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF327957),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle "Ingin Membaca"
                                  Navigator.pop(context);
                                },
                                child: const Text('Ingin Membaca',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF327957),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle "Sedang Membaca"
                                  Navigator.pop(context);
                                },
                                child: const Text('Sedang Membaca',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF327957),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  // Handle "Sudah Dibaca"
                                  Navigator.pop(context);
                                },
                                child: const Text('Telah Dibaca',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text(
                  'Simpan Buku',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ))),
      );
    }

    Widget favoritButton() {
      return Positioned(
        top: 275,
        right: 30,
        child: Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
              color: Color(0xFF327957),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15)]),
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border_rounded,
                  size: 30, color: Colors.white)),
        ),
      );
    }

    Widget infoDeskripsi() {
      return Container(
        height: 60,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
            color: Color(0xFFECF2F2),
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text('Tahun Terbit',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                SizedBox(height: 2),
                Text('1996',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
            VerticalDivider(color: Colors.black, thickness: 1),
            Column(
              children: [
                Text('Penerbit',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                SizedBox(height: 2),
                Text('Random House',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
            VerticalDivider(color: Colors.black, thickness: 1),
            Column(
              children: [
                Text('ISBN',
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.normal)),
                SizedBox(height: 2),
                Text('0679425608',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      );
    }

    Widget review() {
      return Container(
        height: 200,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: const BoxDecoration(
            color: Color(0xFFECF2F2),
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Review',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text('Lihat Semua',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF327957))),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFF327957), shape: BoxShape.circle),
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John Doe',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text('4.5',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae nisi eget nunc ultricies aliquet. Donec euismod, nisl eget aliquam ultricies, nisl nisl aliquet nisl, quis aliquam nisl nisl eget nisl. Donec euismod, nisl eget aliquam ultricies, nisl nisl aliquet nisl, quis aliquam nisl nisl eget nisl.',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF327957)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      );
    }

    Widget deskripsi() {
      return Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(top: 300),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Under the Black Flag: The Romance and the Reality of Life Among the Pirates',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('David Cordingly',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Color(0xFF327957)))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeskripsiBuku()),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Deskripsi Buku',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Icon(Icons.arrow_right_rounded, color: Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Column(
                children: [
                  Text(
                    deskripsiBuku,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF327957),
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            infoDeskripsi(),
            review(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF327957),
      body: ListView(
        children: [
          Stack(
            children: [
              deskripsi(),
              Column(
                children: [
                  header(),
                  coverBuku(),
                ],
              ),
              favoritButton(),
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: footer(),
      ),
    );
  }
}
