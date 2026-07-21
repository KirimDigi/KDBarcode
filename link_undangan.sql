-- ====================================================================
-- SQL SCRIPT UNTUK MEMBUAT TABEL: link_undangan (VERSI POLICY AKTIF)
-- ====================================================================
-- Salin seluruh kode di bawah ini dan jalankan di SQL Editor Supabase Anda.
-- Ini akan membuat tabel link_undangan dan memberikan hak akses publik penuh
-- agar semua perangkat bisa membaca dan menyimpan pengaturan link dasar secara langsung.

-- 1. Hapus tabel lama jika ada
DROP TABLE IF EXISTS link_undangan CASCADE;

-- 2. Buat tabel 'link_undangan'
CREATE TABLE link_undangan (
    wedding_id TEXT PRIMARY KEY REFERENCES weddings(id) ON DELETE CASCADE,
    invitation_url TEXT,
    invitation_text TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Aktifkan RLS (Row Level Security)
ALTER TABLE link_undangan ENABLE ROW LEVEL SECURITY;

-- 4. Buat Kebijakan Akses Publik (Policy) agar client-side API (Anon Key) diizinkan melakukan operasi ALL (Select, Insert, Update, Delete)
CREATE POLICY "Akses Publik Link Undangan" ON link_undangan FOR ALL USING (true) WITH CHECK (true);

-- 5. Aktifkan Fitur Supabase Realtime agar perubahan link langsung terupdate di device lain tanpa refresh
alter publication supabase_realtime add table link_undangan;
