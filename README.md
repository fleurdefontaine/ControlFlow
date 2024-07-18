# Control Flow Obfuscation

## Deskripsi

Fungsi `cControlFlow` adalah sebuah alat obfuskasi kode yang dirancang untuk mempersulit analisis dan reverse engineering pada kode Lua. Fungsi ini menghasilkan struktur kontrol aliran yang kompleks dan tidak terduga, sambil menyisipkan kode asli di dalamnya.

## Cara Kerja

1. Fungsi ini menggunakan rekursi untuk membuat struktur bersarang yang dalam.
2. Code akan membuat loop `while` dan pernyataan `if` berdasarkan perbandingan nilai `n` dan `a`.
3. Kode asli disisipkan ke dalam struktur yang dihasilkan pada kedalaman yang berbeda.
4. Variabel `N_1_`, `A_1_`, dan `B_1_` dimanipulasi di seluruh kode yang dihasilkan.
5. Nilai acak digunakan untuk menambah variabilitas pada hasil obfuskasi.

### Fungsi

```lua
cControlFlow(code, n, a, depth, depthValues)
```

### Parameter

- `code`: Tabel berisi potongan kode asli yang akan disisipkan.
- `n`: (Opsional) Nilai awal untuk N_1_. Jika tidak disediakan, akan dihasilkan secara acak.
- `a`: (Opsional) Nilai awal untuk A_1_. Jika tidak disediakan, akan dihasilkan secara acak.
- `depth`: (Opsional) Kedalaman rekursi saat ini. Biasanya dimulai dari 0.
- `depthValues`: (Opsional) Tabel untuk menyimpan nilai pada kedalaman berbeda.

### Contoh Penggunaan

```lua
local src = {
    'print("Hello, World!")',
    'local x = 10',
    'local y = x * 2',
    'print("Result:", y)'
}

local res = cControlFlow(src)
print(res)
```

### Output

Output akan berupa string yang berisi kode Lua yang diobfuskasi. Kode ini akan mencakup loop `while` bersarang, pernyataan `if`, dan manipulasi variabel, dengan kode asli yang disisipkan di dalamnya.

## Catatan Penting

- Kode yang dihasilkan mungkin sangat kompleks dan sulit dibaca.
- Meskipun obfuskasi membuat kode lebih sulit dianalisis, ini bukan metode enkripsi dan tidak menjamin keamanan absolut.
- Gunakan dengan hati-hati, karena kode yang sangat diobfuskasi dapat mempengaruhi kinerja dan kemampuan debug.

## Kustomisasi

Anda dapat memodifikasi fungsi ini untuk:
- Menambahkan lebih banyak jenis struktur kontrol.
- Mengubah cara kode asli disisipkan.
- Menambahkan lapisan obfuskasi tambahan.