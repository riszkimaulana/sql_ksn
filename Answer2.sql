WITH first_login AS (
  SELECT player_id, MIN(event_date) AS first_login_date
  FROM Activity
  GROUP BY player_id
)
SELECT 
  COUNT(DISTINCT l.player_id) / COUNT(DISTINCT f.player_id) AS fraction
FROM first_login f
LEFT JOIN Activity l ON f.player_id = l.player_id
  AND l.event_date = f.first_login_date + INTERVAL 1 DAY
ROUND(fraction, 2);

-- Penjelasan:

-- 1. first_login CTE (Common Table Expression): CTE ini untuk menemukan tanggal login pertama untuk setiap pemain. Kita menggunakan fungsi MIN(event_date) untuk mendapatkan tanggal minimal (tanggal login pertama).
-- 2. Penggabungan (Join): Perintah LEFT JOIN digunakan untuk menggabungkan tabel Activity dengan CTE first_login berdasarkan kolom player_id.
-- 3. Kondisi Penggabungan: Selain penggabungan berdasarkan player_id, kondisi join juga memfilter tabel Activity untuk memilih baris dimana event_date (tanggal aktivitas) adalah satu hari setelah first_login_date (tanggal login pertama).
-- 4. Perhitungan Rasio: Kita hitung rasio pemain yang login pada dua hari berturut-turut dibagi dengan total pemain.
--   a. COUNT(DISTINCT l.player_id) menghitung jumlah pemain unik yang login pada hari setelah login pertama mereka (berdasarkan tabel Activity yang sudah difilter).
--   b. COUNT(DISTINCT f.player_id) menghitung jumlah pemain unik secara keseluruhan (berdasarkan tabel first_login).
-- 5. Pembulatan Hasil: Terakhir, hasil perhitungan rasio dibulatkan menjadi dua angka desimal menggunakan fungsi ROUND(fraction, 2).
