SELECT e.name
FROM Employee e
INNER JOIN Employee m ON e.id = m.managerId
GROUP BY e.id
HAVING COUNT(m.id) >= 5;

--Penjelasan:
--1. INNER JOIN: Menggabungkan tabel Employee dengan dirinya sendiri berdasarkan kolom id dan managerId.
--2. GROUP BY: Mengelompokkan hasil berdasarkan kolom id (kolom manager).
--3. HAVING: Memfilter hasil yang dikelompokkan, hanya menampilkan manager dengan jumlah bawahan (dihitung dengan COUNT(m.id)) minimal 5.
