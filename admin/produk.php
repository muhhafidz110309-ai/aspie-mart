<?php
// Pastikan TIDAK ADA spasi atau baris kosong sebelum tag <?php di atas!
require_once '../config/database.php';
requireLogin();

/* ============================================================
   HELPER GAMBAR: UPLOAD FILE (BASE64) ATAU LINK URL
   ============================================================ */
function parseUploadGambarBase64(array $file): ?string
{
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_NO_FILE) {
        return null;
    }

    if (($file['error'] ?? UPLOAD_ERR_OK) !== UPLOAD_ERR_OK || empty($file['tmp_name'])) {
        return null;
    }

    if (($file['size'] ?? 0) > 1 * 1024 * 1024) {
        return null;
    }

    $mime = mime_content_type($file['tmp_name']) ?: '';
    $allowed = ['image/jpeg', 'image/png', 'image/gif', 'image/webp'];
    if (!in_array($mime, $allowed, true)) {
        return null;
    }

    $raw = file_get_contents($file['tmp_name']);
    if ($raw === false) {
        return null;
    }

    return 'data:' . $mime . ';base64,' . base64_encode($raw);
}

function normalisasiLinkGambar(?string $url): ?string
{
    $clean = trim((string)$url);
    if ($clean === '') {
        return null;
    }

    if (!filter_var($clean, FILTER_VALIDATE_URL)) {
        return null;
    }

    $scheme = strtolower((string)parse_url($clean, PHP_URL_SCHEME));
    if (!in_array($scheme, ['http', 'https'], true)) {
        return null;
    }

    return $clean;
}

/* ============================================================
   HANDLE SIMPAN / UPDATE
   ============================================================ */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['act'] ?? '') === 'save') {
    $id            = (int)($_POST['id'] ?? 0);
    $nama          = trim($_POST['nama'] ?? '');
    $kategori      = trim($_POST['kategori'] ?? '');

    // Bersihkan format titik dari harga
    $hargaBeli_raw = $_POST['harga_beli'] ?? '0';
    $hargaJual_raw = $_POST['harga_jual'] ?? '0';
    $hargaBeli     = (float)str_replace('.', '', $hargaBeli_raw);
    $hargaJual     = (float)str_replace('.', '', $hargaJual_raw);

    $stok          = (int)($_POST['stok'] ?? 0);
    $satuan        = trim($_POST['satuan'] ?? 'pcs');
    $satuanBeli    = trim($_POST['satuan_beli'] ?? 'pcs');

    // Isi per satuan: Jika kosong atau 0, otomatis jadi 1
    $isiPerSatuan  = (int)($_POST['isi_per_satuan'] ?? 1);
    if ($isiPerSatuan < 1) $isiPerSatuan = 1;

    $deskripsi     = trim($_POST['deskripsi'] ?? '');
    $gambarLama    = trim($_POST['gambar_lama'] ?? '') ?: null;
    $gambarInput   = trim($_POST['gambar_url'] ?? '');

    // Harga beli per pcs (untuk validasi margin)
    $hargaBeliPcs = $hargaBeli / $isiPerSatuan;

    // Validasi
    if ($nama === '') {
        flash('error', 'Nama produk wajib diisi.');
        redirect('produk.php' . ($id ? '?edit=' . $id : ''));
    }
    if ($hargaJual < 0 || $hargaBeli < 0 || $stok < 0) {
        flash('error', 'Harga dan stok tidak boleh negatif.');
        redirect('produk.php' . ($id ? '?edit=' . $id : ''));
    }
    if ($hargaJual < $hargaBeliPcs && $hargaBeliPcs > 0) {
        flash('error', 'Harga jual per pcs (Rp ' . number_format($hargaJual, 0, ',', '.') . ') tidak boleh lebih rendah dari harga beli per pcs (Rp ' . number_format($hargaBeliPcs, 0, ',', '.') . ').');
        redirect('produk.php' . ($id ? '?edit=' . $id : ''));
    }

    // Prioritas: 1. File upload baru -> 2. Link URL baru -> 3. Gambar lama
    $gambarDariFile = parseUploadGambarBase64($_FILES['gambar'] ?? []);
    $gambarDariUrl  = null;

    if ($gambarDariFile === null && $gambarInput !== '') {
        $gambarDariUrl = normalisasiLinkGambar($gambarInput);
        if ($gambarDariUrl === null) {
            flash('error', 'Link gambar tidak valid. Gunakan URL http:// atau https://.');
            redirect('produk.php' . ($id ? '?edit=' . $id : ''));
        }
    }

    $gambar = $gambarDariFile ?? $gambarDariUrl ?? $gambarLama;

    // Handle hapus gambar via tombol
    if (($_POST['hapus_gambar'] ?? '0') === '1') {
        $gambar = null;
    }

    try {
        if ($id > 0) {
            // === UPDATE ===
            $stmt = $pdo->prepare("UPDATE produk
                                   SET nama=?, kategori=?, harga_beli=?, harga_jual=?,
                                       stok=?, satuan=?, satuan_beli=?, isi_per_satuan=?,
                                       gambar=?, deskripsi=?
                                   WHERE id=?");
            $stmt->execute([
                $nama, $kategori, $hargaBeli, $hargaJual,
                $stok, $satuan, $satuanBeli, $isiPerSatuan,
                $gambar, $deskripsi, $id
            ]);
            flash('success', 'Produk "' . $nama . '" berhasil diperbarui.');
        } else {
            // === INSERT ===
            $kode = 'PRD' . str_pad((string)random_int(1, 9999), 4, '0', STR_PAD_LEFT);
            while ((int)$pdo->query("SELECT COUNT(*) FROM produk WHERE kode='" . $kode . "'")->fetchColumn() > 0) {
                $kode = 'PRD' . str_pad((string)random_int(1, 9999), 4, '0', STR_PAD_LEFT);
            }
            $stmt = $pdo->prepare("INSERT INTO produk
                                   (kode, nama, kategori, harga_beli, harga_jual, stok, satuan, satuan_beli, isi_per_satuan, gambar, deskripsi)
                                   VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            $stmt->execute([
                $kode, $nama, $kategori, $hargaBeli, $hargaJual,
                $stok, $satuan, $satuanBeli, $isiPerSatuan,
                $gambar, $deskripsi
            ]);
            flash('success', 'Produk baru "' . $nama . '" berhasil ditambahkan.');
        }
    } catch (PDOException $e) {
        flash('error', 'Gagal menyimpan produk: ' . $e->getMessage());
    }
    redirect('produk.php');
}

/* ============================================================
   HANDLE HAPUS (1 PRODUK)
   ============================================================ */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['act'] ?? '') === 'delete') {
    $id = (int)($_POST['id'] ?? 0);
    if ($id <= 0) redirect('produk.php');

    try {
        $pdo->beginTransaction();

        $stmt = $pdo->prepare("SELECT nama FROM produk WHERE id = ?");
        $stmt->execute([$id]);
        $p = $stmt->fetch();

        if ($p) {
            $pdo->prepare("DELETE FROM produk WHERE id = ?")->execute([$id]);
            flash('success', 'Produk "' . $p['nama'] . '" berhasil dihapus.');
        }

        $pdo->commit();
    } catch (Exception $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        flash('error', 'Gagal menghapus: ' . $e->getMessage());
    }
    redirect('produk.php');
}

/* ============================================================
   HANDLE HAPUS SEMUA PRODUK
   ============================================================ */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['act'] ?? '') === 'delete_all') {
    try {
        $pdo->beginTransaction();
        $pdo->exec("DELETE FROM produk");
        $pdo->commit();
        flash('success', 'Semua produk berhasil dihapus permanen.');
    } catch (Exception $e) {
        if ($pdo->inTransaction()) $pdo->rollBack();
        flash('error', 'Gagal menghapus: ' . $e->getMessage());
    }
    redirect('produk.php');
}

/* ============================================================
   HANDLE DUPLIKAT
   ============================================================ */
if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['act'] ?? '') === 'duplicate') {
    $id = (int)($_POST['id'] ?? 0);
    try {
        $stmt = $pdo->prepare("SELECT * FROM produk WHERE id = ?");
        $stmt->execute([$id]);
        $p = $stmt->fetch();

        if ($p) {
            $kode = 'PRD' . str_pad((string)random_int(1, 9999), 4, '0', STR_PAD_LEFT);
            while ((int)$pdo->query("SELECT COUNT(*) FROM produk WHERE kode='$kode'")->fetchColumn() > 0) {
                $kode = 'PRD' . str_pad((string)random_int(1, 9999), 4, '0', STR_PAD_LEFT);
            }
            $stmt = $pdo->prepare("INSERT INTO produk
                                   (kode, nama, kategori, harga_beli, harga_jual, stok, satuan, satuan_beli, isi_per_satuan, gambar, deskripsi)
                                   VALUES (?,?,?,?,?,?,?,?,?,?,?)");
            $stmt->execute([
                $kode,
                $p['nama'] . ' (Copy)',
                $p['kategori'],
                $p['harga_beli'],
                $p['harga_jual'],
                0,
                $p['satuan'],
                $p['satuan_beli'] ?? 'pcs',
                $p['isi_per_satuan'] ?? 1,
                $p['gambar'],
                $p['deskripsi'],
            ]);
            flash('success', 'Produk berhasil diduplikasi. Silakan edit untuk penyesuaian.');
        }
    } catch (PDOException $e) {
        flash('error', 'Gagal menduplikasi produk: ' . $e->getMessage());
    }
    redirect('produk.php');
}

/* ============================================================
   DATA UNTUK EDIT
   ============================================================ */
$edit = null;
if (!empty($_GET['edit'])) {
    $stmt = $pdo->prepare("SELECT * FROM produk WHERE id = ?");
    $stmt->execute([(int)$_GET['edit']]);
    $edit = $stmt->fetch();

    if (!$edit) {
        flash('error', 'Produk tidak ditemukan.');
        redirect('produk.php');
    }
}

/* ============================================================
   DATA LIST PRODUK (DENGAN SEARCH & COUNT KATEGORI)
   ============================================================ */
$kategori_filter = trim($_GET['kategori'] ?? '');
$search_filter   = trim($_GET['q'] ?? '');

$sql = "SELECT * FROM produk WHERE 1=1";
$params = [];

if ($kategori_filter !== '') {
    $sql .= " AND kategori = ?";
    $params[] = $kategori_filter;
}

if ($search_filter !== '') {
    $sql .= " AND (nama ILIKE ? OR kode ILIKE ?)";
    $params[] = "%$search_filter%";
    $params[] = "%$search_filter%";
}

$sql .= " ORDER BY nama ASC";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$list = $stmt->fetchAll();

$counts = [];
$countStmt = $pdo->query("SELECT kategori, COUNT(*) as total FROM produk GROUP BY kategori");
while ($row = $countStmt->fetch()) {
    $counts[$row['kategori']] = $row['total'];
}
$totalAll = array_sum($counts);

$kategorisDB = $pdo->query("SELECT DISTINCT kategori FROM produk WHERE kategori IS NOT NULL AND kategori != '' ORDER BY kategori")->fetchAll(PDO::FETCH_COLUMN);
$kategoriBawaan = ['Minuman', 'Makanan', 'ATK', 'Es Krim'];
$kategoris = array_values(array_unique(array_merge($kategoriBawaan, $kategorisDB)));
sort($kategoris);

$kategoriTerpilih = $edit['kategori'] ?? '';
$nilaiLinkGambar  = (!empty($edit['gambar']) && preg_match('#^https?://#i', $edit['gambar'])) ? $edit['gambar'] : '';

$pageTitle = 'Data Produk';
$pageSubtitle = 'Manajemen barang / produk BMT';
require_once '../includes/header.php';
?>

<style>
  .form-grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 12px; }
  .margin-info { background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 8px; padding: 10px 14px; margin-bottom: 12px; font-size: 13px; color: #065f46; }
  .margin-info strong { color: #047857; }
  .info-badge { display: inline-block; background: #fef3c7; color: #92400e; padding: 2px 8px; border-radius: 6px; font-size: 11px; font-weight: 600; margin-left: 6px; }
  .konversi-info { background: #eff6ff; border-left: 3px solid #3b82f6; padding: 6px 10px; border-radius: 4px; font-size: 12px; color: #1e40af; margin-top: 6px; }

  .kategori-pills { display: flex; flex-wrap: wrap; gap: 8px; margin-top: 6px; }
  .kategori-pill { display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px; border-radius: 999px; border: 1.5px solid #d1d5db; background: #fff; color: #374151; font-size: 13px; font-weight: 600; cursor: pointer; transition: all .2s ease; user-select: none; line-height: 1; }
  .kategori-pill:hover { border-color: var(--g500, #10b981); background: #f0fdf4; color: var(--g700, #047857); transform: translateY(-1px); box-shadow: 0 2px 6px rgba(16, 185, 129, 0.15); }
  .kategori-pill.active { background: var(--g500, #10b981); border-color: var(--g500, #10b981); color: #fff; box-shadow: 0 2px 8px rgba(16, 185, 129, 0.35); }
  .kategori-pill.active::before { content: '✓'; font-size: 11px; font-weight: 700; }
  .kategori-pill .pill-icon { font-size: 14px; line-height: 1; }
  .kategori-pill .badge-count { background: #f3f4f6; color: #6b7280; font-size: 10px; padding: 2px 6px; border-radius: 10px; margin-left: 4px; font-weight: 700; }
  .kategori-pill.active .badge-count { background: rgba(255,255,255,0.3); color: #fff; }
  .kategori-custom-wrap { margin-top: 8px; display: none; }
  .kategori-custom-wrap.show { display: block; }

  .detail-only { display: none; animation: fadeIn 0.3s ease; }
  #formProduk.show-detail .detail-only { display: block; }
  @keyframes fadeIn { from { opacity: 0; transform: translateY(-5px); } to { opacity: 1; transform: translateY(0); } }
  .toggle-mode-btn { font-size: 12px; padding: 6px 14px; border-radius: 8px; cursor: pointer; background: #f3f4f6; border: 1px solid #d1d5db; color: #4b5563; transition: all 0.2s; font-weight: 600; }
  .toggle-mode-btn:hover { background: #e5e7eb; }
  .toggle-mode-btn.active { background: #e0f2fe; border-color: #7dd3fc; color: #0369a1; }

  .filter-bar { padding: 10px 16px; display: flex; gap: 8px; flex-wrap: wrap; border-bottom: 1px solid #e5e7eb; align-items: center; }
  .filter-bar .btn-filter { font-size: 12px; padding: 5px 12px; white-space: nowrap; }
  .filter-bar .btn-filter .badge-count { background: rgba(0,0,0,0.1); padding: 1px 5px; border-radius: 6px; font-size: 10px; margin-left: 4px; }
  .filter-bar .btn-primary .badge-count { background: rgba(255,255,255,0.3); }

  .search-wrap { padding: 0 16px 10px 16px; position: relative; }
  .search-wrap .search-form { display: flex; gap: 8px; align-items: center; }
  .search-wrap .search-input-group { position: relative; flex: 1; }
  .search-wrap input[type="text"] { width: 100%; padding: 8px 12px 8px 36px; border: 1px solid #d1d5db; border-radius: 8px; font-size: 13px; transition: border-color 0.2s; }
  .search-wrap input[type="text"]:focus { outline: none; border-color: #10b981; box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.15); }
  .search-wrap .search-icon { position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #9ca3af; font-size: 14px; pointer-events: none; }
  .search-wrap .btn-search { white-space: nowrap; padding: 8px 16px; font-size: 13px; }
  .search-wrap .btn-reset-search { white-space: nowrap; padding: 8px 12px; font-size: 13px; }

  @media (max-width: 768px) {
    .form-grid-3 { grid-template-columns: 1fr; }
    .kategori-pill { padding: 7px 12px; font-size: 12px; }
    .search-wrap .btn-search span.btn-text { display: none; }
    .search-wrap .btn-reset-search span.btn-text { display: none; }
  }
</style>

<div class="grid-2">

  <!-- =====================================================
       FORM TAMBAH / EDIT PRODUK
       ===================================================== -->
  <div class="card">
    <div class="card-head" style="display:flex; justify-content:space-between; align-items:center;">
      <h2><?= $edit ? '✏️ Edit Produk' : '➕ Tambah Produk' ?></h2>

      <?php if ($edit): ?>
        <span class="tag tag-gray"><?= e($edit['kode']) ?></span>
      <?php endif; ?>
    </div>
    <div class="card-body">
      <form method="post" enctype="multipart/form-data" id="formProduk">
        <input type="hidden" name="act" value="save">
        <input type="hidden" name="id" value="<?= (int)($edit['id'] ?? 0) ?>">
        <input type="hidden" name="gambar_lama" value="<?= e($edit['gambar'] ?? '') ?>">

        <!-- NAMA PRODUK -->
        <div class="form-group" style="margin-bottom:12px">
          <label>Nama Produk <span class="req">*</span></label>
          <input type="text" name="nama" value="<?= e($edit['nama'] ?? '') ?>"
                 placeholder="Contoh: Oasis 600ml" required autofocus>
        </div>

        <!-- KATEGORI -->
        <div class="form-group" style="margin-bottom:12px">
          <label>Kategori</label>
          <input type="hidden" name="kategori" id="kategoriInput" value="<?= e($kategoriTerpilih) ?>">

          <div class="kategori-pills" id="kategoriPills">
            <?php foreach ($kategoris as $k): ?>
              <button type="button"
                      class="kategori-pill <?= ($kategoriTerpilih === $k) ? 'active' : '' ?>"
                      data-kategori="<?= e($k) ?>">
                <?= e($k) ?>
              </button>
            <?php endforeach; ?>

            <button type="button" class="kategori-pill" id="btnKategoriCustom"
                    style="border-style:dashed; color:#6b7280;">
              <span class="pill-icon">＋</span> Lainnya
            </button>
          </div>

          <div class="kategori-custom-wrap" id="kategoriCustomWrap">
            <input type="text" id="kategoriCustomInput"
                   placeholder="Ketik nama kategori baru..."
                   maxlength="50">
            <div style="display:flex; gap:8px; margin-top:6px;">
              <button type="button" class="btn btn-outline btn-sm" id="btnBatalCustom">Batal</button>
            </div>
          </div>
        </div>

        <!-- HARGA JUAL -->
        <div class="form-group" style="margin-bottom:12px">
          <label>
            Harga Jual (per pcs) <span class="req">*</span>
            <span class="info-badge" style="background:#dbeafe;color:#1e40af">Eceran</span>
          </label>
          <input type="text" name="harga_jual" id="hargaJual"
                 value="<?= !empty($edit['harga_jual']) ? number_format($edit['harga_jual'], 0, ',', '.') : '' ?>"
                 inputmode="numeric" required placeholder="2.000" autocomplete="off">
        </div>

        <!-- STOK & SATUAN JUAL -->
        <div class="form-grid" style="grid-template-columns:1fr 1fr;margin-bottom:12px">
          <div class="form-group">
            <label>Stok (dalam pcs)</label>
            <input type="number" name="stok" value="<?= (int)($edit['stok'] ?? 0) ?>" min="0" placeholder="24">
          </div>
          <div class="form-group">
            <label>Satuan Jual</label>
            <input type="text" name="satuan" value="<?= e($edit['satuan'] ?? 'pcs') ?>" placeholder="pcs / botol / kg">
          </div>
        </div>

        <!-- FIELD DETAIL -->
        <div class="form-group detail-only" style="margin-bottom:6px">
          <label>
            Harga Beli (per satuan beli)
            <span class="info-badge">Dus / Box / Pack</span>
          </label>
          <div class="form-grid-3">
            <div class="form-group">
              <label style="font-size:12px;color:#6b7280;font-weight:400">Harga Total</label>
              <input type="text" name="harga_beli" id="hargaBeli"
                     value="<?= !empty($edit['harga_beli']) ? number_format($edit['harga_beli'], 0, ',', '.') : '' ?>"
                     inputmode="numeric" placeholder="35.000" autocomplete="off">
            </div>
            <div class="form-group">
              <label style="font-size:12px;color:#6b7280;font-weight:400">Satuan Beli</label>
              <input type="text" name="satuan_beli" id="satuanBeli"
                     value="<?= e($edit['satuan_beli'] ?? 'dus') ?>"
                     placeholder="dus / box / pack">
            </div>
            <div class="form-group">
              <label style="font-size:12px;color:#6b7280;font-weight:400">Isi per Satuan</label>
              <input type="number" name="isi_per_satuan" id="isiPerSatuan"
                     value="<?= !empty($edit['isi_per_satuan']) ? (int)$edit['isi_per_satuan'] : '' ?>"
                     placeholder="24">
            </div>
          </div>
          <div class="konversi-info" id="konversiInfo" style="display:none">
            💡 1 <span id="labelSatuanBeli">dus</span> = <strong id="labelIsi">24</strong> pcs ·
            Harga beli per pcs: <strong id="labelHargaPcs">Rp 1.458</strong>
          </div>
        </div>

        <div class="margin-info detail-only" id="marginInfo" style="display:none">
          <span>
            💰 Margin per pcs: <strong id="marginText">Rp 0</strong>
            &nbsp;·&nbsp;
            Harga beli per pcs: <strong id="hargaBeliPcs">Rp 0</strong>
          </span>
        </div>

        <!-- UPLOAD GAMBAR ATAU TAUTKAN LINK -->
        <div class="form-group" style="margin-bottom:12px; margin-top:12px;">
          <label>Gambar Produk (Upload atau Link)</label>
          <div class="upload-area" id="uploadArea">
            <div class="upload-preview" id="previewBox">
              <img src="<?= e(produkImage($edit['gambar'] ?? null)) ?>"
                   alt="Preview" id="previewImg">
            </div>
            <div class="upload-info" style="flex:1">
              <input type="file" name="gambar" id="inputGambar" accept="image/jpeg, image/png, image/gif, image/webp">
              <small class="text-muted" style="display:block; margin-bottom:8px;">
                Upload: JPG, PNG, GIF, WEBP · Maks 1MB
              </small>

              <input type="url" name="gambar_url" id="inputLinkGambar"
                     value="<?= e($nilaiLinkGambar) ?>"
                     placeholder="Atau tempel link gambar langsung (https://...)"
                     style="width:100%; padding:8px 10px; border:1px solid #d1d5db; border-radius:8px; font-size:13px;">
              <small class="text-muted" style="display:block; margin-top:4px;" id="statusPreviewGambar">
                Gunakan link langsung ke file gambar (bukan link halaman/shortlink)
              </small>

              <?php if (!empty($edit['gambar'])): ?>
                <button type="button" class="btn btn-outline btn-sm" style="margin-top:6px"
                        onclick="hapusGambarUI()">
                  Hapus Gambar
                </button>
              <?php endif; ?>
              <input type="hidden" name="hapus_gambar" id="hapusGambarFlag" value="0">
            </div>
          </div>
        </div>

        <div class="form-group detail-only">
          <label>Deskripsi</label>
          <textarea name="deskripsi" placeholder="Opsional..."><?= e($edit['deskripsi'] ?? '') ?></textarea>
        </div>

        <!-- FORM ACTIONS + TOMBOL MODE DETAIL -->
        <div class="form-actions" style="margin-top: 16px; display:flex; gap:8px; align-items:center; flex-wrap:wrap;">
          <button class="btn btn-primary" type="submit">
            <?= $edit ? 'Perbarui Produk' : 'Simpan Produk' ?>
          </button>
          <?php if ($edit): ?>
            <a href="produk.php" class="btn btn-outline">Batal</a>
          <?php endif; ?>

          <button type="button" class="toggle-mode-btn" id="btnToggleMode"
                  onclick="toggleMode()" style="margin-left:auto;">
            ⚙️ Mode Detail
          </button>
        </div>
      </form>
    </div>
  </div>

  <!-- =====================================================
       DAFTAR PRODUK
       ===================================================== -->
  <div class="card">
    <div class="card-head">
      <h2>Daftar Produk (<?= count($list) ?>)</h2>
      <div style="display:flex;gap:8px;align-items:center" class="no-print">
        <?php if ($list): ?>
        <button type="button" class="btn btn-danger btn-sm"
                onclick="konfirmasiHapusSemuaProduk(<?= count($list) ?>)">
          🗑️ Hapus Semua
        </button>
        <?php endif; ?>
      </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="search-wrap">
      <form method="get" action="produk.php" id="searchForm" class="search-form">
        <?php if ($kategori_filter): ?>
          <input type="hidden" name="kategori" value="<?= e($kategori_filter) ?>">
        <?php endif; ?>
        <div class="search-input-group">
          <span class="search-icon">🔍</span>
          <input type="text" name="q" id="searchInput"
                 value="<?= e($search_filter) ?>"
                 placeholder="Cari nama produk atau kode..."
                 autocomplete="off">
        </div>
        <button type="submit" class="btn btn-primary btn-search">
          🔍 <span class="btn-text">Cari</span>
        </button>
        <?php if ($search_filter): ?>
          <a href="produk.php<?= $kategori_filter ? '?kategori=' . urlencode($kategori_filter) : '' ?>"
             class="btn btn-outline btn-reset-search"
             title="Reset pencarian">
            ✕ <span class="btn-text">Reset</span>
          </a>
        <?php endif; ?>
      </form>
    </div>

    <!-- QUICK FILTER KATEGORI + COUNT -->
    <div class="filter-bar">
      <a href="produk.php?<?= $search_filter ? 'q=' . urlencode($search_filter) : '' ?>"
         class="btn btn-sm btn-filter <?= $kategori_filter === '' ? 'btn-primary' : 'btn-outline' ?>">
        Semua <span class="badge-count"><?= $totalAll ?></span>
      </a>
      <?php foreach (['Minuman', 'Makanan', 'ATK', 'Es Krim'] as $kb):
        $count = $counts[$kb] ?? 0;
        $url = 'produk.php?kategori=' . urlencode($kb);
        if ($search_filter) $url .= '&q=' . urlencode($search_filter);
      ?>
        <a href="<?= $url ?>"
           class="btn btn-sm btn-filter <?= $kategori_filter === $kb ? 'btn-primary' : 'btn-outline' ?>">
          <?= e($kb) ?> <span class="badge-count"><?= $count ?></span>
        </a>
      <?php endforeach; ?>
    </div>

    <div class="table-wrap" style="max-height:640px;overflow-y:auto">
      <table>
        <thead>
          <tr>
            <th>Produk</th>
            <th class="text-right">Harga</th>
            <th class="text-center">Stok</th>
            <th class="text-center">Aksi</th>
          </tr>
        </thead>
        <tbody>
        <?php if (!$list): ?>
          <tr>
            <td colspan="4" class="empty">
              <?php if ($search_filter): ?>
                Tidak ada produk yang cocok dengan "<strong><?= e($search_filter) ?></strong>".
              <?php else: ?>
                Belum ada produk.
              <?php endif; ?>
            </td>
          </tr>
        <?php else: foreach ($list as $p):
          $isi  = max(1, (int)($p['isi_per_satuan'] ?? 1));
          $beli = (float)$p['harga_beli'];
          $beliPcs = $beli / $isi;
        ?>
          <tr>
            <td>
              <div class="thumb-wrap">
                <img src="<?= e(produkImage($p['gambar'])) ?>" alt="<?= e($p['nama']) ?>" class="thumb">
                <div>
                  <div class="strong"><?= e($p['nama']) ?></div>
                  <small class="text-muted">
                    <?= e($p['kode']) ?> · <?= e($p['kategori'] ?: '-') ?>
                    <?php if ($isi > 1): ?>
                      · 1 <?= e($p['satuan_beli'] ?? 'dus') ?> = <?= $isi ?> <?= e($p['satuan']) ?>
                    <?php endif; ?>
                  </small>
                </div>
              </div>
            </td>
            <td class="text-right">
              <div class="strong"><?= rupiah($p['harga_jual']) ?></div>
              <small class="text-muted">
                Beli: <?= rupiah($beliPcs) ?>/<?= e($p['satuan']) ?>
                <?php if ($isi > 1): ?>
                  <br><span style="color:#9ca3af">(<?= rupiah($beli) ?>/<?= e($p['satuan_beli'] ?? 'dus') ?>)</span>
                <?php endif; ?>
              </small>
            </td>
            <td class="text-center">
              <span class="tag <?= $p['stok'] <= 10 ? 'tag-red' : 'tag-green' ?>">
                <?= (int)$p['stok'] ?> <?= e($p['satuan']) ?>
              </span>
            </td>
            <td class="text-center" style="white-space:nowrap">
              <a href="produk.php?edit=<?= (int)$p['id'] ?>" class="btn btn-outline btn-sm" title="Edit">Edit</a>
              <form method="post" style="display:inline">
                <input type="hidden" name="act" value="duplicate">
                <input type="hidden" name="id" value="<?= (int)$p['id'] ?>">
                <button class="btn btn-outline btn-sm" title="Duplikat">Copy</button>
              </form>
              <button type="button" class="btn btn-danger btn-sm" title="Hapus Produk"
                      onclick="bukaHapusProduk(<?= (int)$p['id'] ?>, '<?= e(addslashes($p['nama'])) ?>', '<?= e(addslashes($p['kode'])) ?>', '<?= e(addslashes($p['kategori'] ?: '-')) ?>')">
                Hapus
              </button>
            </td>
          </tr>
        <?php endforeach; endif; ?>
        </tbody>
      </table>
    </div>
  </div>

</div>

<!-- ===== MODAL HAPUS SEMUA PRODUK ===== -->
<div class="modal-overlay no-print" id="modalHapusSemuaProduk">
  <div class="modal-box">
    <div class="modal-head">
      <h3>⚠️ Hapus Semua Produk?</h3>
      <button type="button" class="modal-close" onclick="tutupModalSemuaProduk()">×</button>
    </div>
    <div class="modal-body">
      <p>Anda akan menghapus <strong>semua produk</strong> dari database:</p>
      <div class="modal-info">
        <div><span>Total Produk</span><strong id="modalProdukJml">0</strong></div>
      </div>
      <p class="modal-warn">
        ⚠️ <strong>PERINGATAN:</strong> Produk yang sudah dipakai pada transaksi
        <strong>tidak akan dihapus</strong> (untuk menjaga integritas data).
        Produk yang belum pernah dipakai akan dihapus permanen.
      </p>
    </div>
    <div class="modal-foot">
      <button type="button" class="btn btn-outline" onclick="tutupModalSemuaProduk()">Batal</button>
      <form method="post" style="display:inline">
        <input type="hidden" name="act" value="delete_all">
        <button type="submit" class="btn btn-danger">Ya, Hapus Semua</button>
      </form>
    </div>
  </div>
</div>

<!-- ===== MODAL HAPUS 1 PRODUK ===== -->
<div class="modal-overlay no-print" id="modalHapusProduk">
  <div class="modal-box">
    <div class="modal-head">
      <h3 style="color: var(--danger);">Hapus Produk?</h3>
      <button type="button" class="modal-close" onclick="tutupModalHapusProduk()">×</button>
    </div>
    <div class="modal-body">
      <p>Anda akan menghapus produk berikut dari database:</p>
      <div class="modal-info" style="margin-top: 12px;">
        <div style="display:flex; flex-direction:column; gap:4px;">
          <span>Nama Produk:</span>
          <strong id="modalHapusNamaProduk" style="font-size: 16px;">-</strong>
        </div>
        <div style="margin-top: 8px;">
          <span id="modalHapusDetailProduk">-</span>
        </div>
      </div>
      <p class="modal-warn" style="color: #b91c1c; background: #fef2f2; border-color: #fecaca;">
        ⚠️ <strong>PERINGATAN:</strong> Data yang dihapus tidak dapat dikembalikan. Jika produk ini sudah pernah dipakai di transaksi, penghapusan akan gagal.
      </p>
    </div>
    <div class="modal-foot">
      <button type="button" class="btn btn-outline" onclick="tutupModalHapusProduk()">Batal</button>
      <form method="post" style="display:inline" id="formHapusProduk">
        <input type="hidden" name="act" value="delete">
        <input type="hidden" name="id" id="hapusProdukIdInput">
        <button type="submit" class="btn btn-danger">Ya, Hapus</button>
      </form>
    </div>
  </div>
</div>

<script>
const searchInput = document.getElementById('searchInput');
const searchForm  = document.getElementById('searchForm');

if (searchInput && searchForm) {
  searchInput.addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      searchForm.submit();
    }
  });
}

function toggleMode() {
  const form = document.getElementById('formProduk');
  const btn = document.getElementById('btnToggleMode');

  form.classList.toggle('show-detail');

  if (form.classList.contains('show-detail')) {
    btn.classList.add('active');
    btn.innerHTML = '⚙️ Mode Simple';
  } else {
    btn.classList.remove('active');
    btn.innerHTML = '⚙️ Mode Detail';
  }
}

document.addEventListener('DOMContentLoaded', function() {
    const isiPerSatuan = document.getElementById('isiPerSatuan');
    const deskripsi = document.querySelector('textarea[name="deskripsi"]');
    const hargaBeli = document.getElementById('hargaBeli');

    let needDetail = false;
    if (isiPerSatuan && parseInt(isiPerSatuan.value) > 1) needDetail = true;
    if (deskripsi && deskripsi.value.trim() !== '') needDetail = true;
    if (hargaBeli && hargaBeli.value.trim() !== '' && hargaBeli.value !== '0') needDetail = true;

    const gambarLama = document.querySelector('input[name="gambar_lama"]');
    if (gambarLama && gambarLama.value !== '') needDetail = true;

    if (needDetail) {
        toggleMode();
    }
});

const inputGambar     = document.getElementById('inputGambar');
const inputLinkGambar = document.getElementById('inputLinkGambar');
const previewImg      = document.getElementById('previewImg');
const statusPreview   = document.getElementById('statusPreviewGambar');
const defaultSvg      = 'data:image/svg+xml;utf8,' + encodeURIComponent(
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">' +
  '<rect width="100" height="100" fill="#ecfdf5"/>' +
  '<path d="M25 65l15-20 12 15 8-10 15 15H25z" fill="#10b981"/>' +
  '<circle cx="35" cy="35" r="7" fill="#d4af37"/></svg>'
);

if (previewImg) {
  previewImg.addEventListener('error', function () {
    if (this.src !== defaultSvg) {
      this.src = defaultSvg;
      if (statusPreview) {
        statusPreview.textContent = 'Link/gambar tidak bisa dimuat sebagai gambar langsung.';
      }
    }
  });

  previewImg.addEventListener('load', function () {
    if (this.src !== defaultSvg && statusPreview) {
      statusPreview.textContent = 'Preview gambar siap.';
    }
  });
}

if (inputGambar && previewImg) {
  inputGambar.addEventListener('change', function () {
    const file = this.files && this.files[0];
    if (!file) return;

    if (file.size > 1 * 1024 * 1024) {
      alert('Ukuran gambar maksimal 1MB.');
      this.value = '';
      return;
    }

    if (inputLinkGambar) inputLinkGambar.value = '';

    const reader = new FileReader();
    reader.onload = e => {
      previewImg.src = e.target.result;
      if (statusPreview) statusPreview.textContent = 'Menggunakan file upload: ' + file.name;
    };
    reader.readAsDataURL(file);

    const flag = document.getElementById('hapusGambarFlag');
    if (flag) flag.value = '0';
  });
}

if (inputLinkGambar && previewImg) {
  inputLinkGambar.addEventListener('input', function () {
    const url = this.value.trim();
    if (inputGambar) inputGambar.value = '';

    if (/^https?:\/\/.+/i.test(url)) {
      previewImg.src = url;
    } else if (url === '') {
      const lama = document.querySelector('input[name="gambar_lama"]')?.value || '';
      previewImg.src = /^https?:\/\/.+/i.test(lama) || /^data:image\//i.test(lama) ? lama : defaultSvg;
      if (statusPreview) {
        statusPreview.textContent = 'Gunakan link langsung ke file gambar (bukan link halaman/shortlink)';
      }
    }

    const flag = document.getElementById('hapusGambarFlag');
    if (flag) flag.value = '0';
  });
}

function hapusGambarUI() {
  if (!confirm('Hapus gambar produk ini?')) return;

  previewImg.src = defaultSvg;

  const flag = document.getElementById('hapusGambarFlag');
  if (flag) flag.value = '1';

  if (inputGambar) inputGambar.value = '';
  if (inputLinkGambar) inputLinkGambar.value = '';
  if (statusPreview) statusPreview.textContent = 'Gambar akan dihapus saat disimpan.';
}

const kategoriInput      = document.getElementById('kategoriInput');
const kategoriPills      = document.getElementById('kategoriPills');
const btnKategoriCustom  = document.getElementById('btnKategoriCustom');
const kategoriCustomWrap = document.getElementById('kategoriCustomWrap');
const kategoriCustomInput= document.getElementById('kategoriCustomInput');
const btnBatalCustom     = document.getElementById('btnBatalCustom');

kategoriPills.addEventListener('click', function (e) {
  const pill = e.target.closest('.kategori-pill');
  if (!pill) return;
  if (pill === btnKategoriCustom) return;

  kategoriPills.querySelectorAll('.kategori-pill').forEach(p => p.classList.remove('active'));
  pill.classList.add('active');
  kategoriInput.value = pill.dataset.kategori;
  kategoriCustomWrap.classList.remove('show');
  kategoriCustomInput.value = '';
});

btnKategoriCustom.addEventListener('click', function () {
  kategoriCustomWrap.classList.add('show');
  kategoriCustomInput.focus();
});

btnBatalCustom.addEventListener('click', function () {
  kategoriCustomWrap.classList.remove('show');
  kategoriCustomInput.value = '';
});

kategoriCustomInput.addEventListener('input', function () {
  const val = this.value.trim();
  kategoriPills.querySelectorAll('.kategori-pill').forEach(p => p.classList.remove('active'));

  if (val === '') {
    kategoriInput.value = '';
    return;
  }

  const existing = Array.from(kategoriPills.querySelectorAll('.kategori-pill'))
    .find(p => p.dataset.kategori && p.dataset.kategori.toLowerCase() === val.toLowerCase());

  if (existing) {
    existing.classList.add('active');
  }
  kategoriInput.value = val;
});

kategoriCustomInput.addEventListener('keydown', function (e) {
  if (e.key === 'Enter') {
    e.preventDefault();
    this.blur();
    kategoriCustomWrap.classList.remove('show');
  }
});

const hb            = document.getElementById('hargaBeli');
const hj            = document.getElementById('hargaJual');
const satuanBeli    = document.getElementById('satuanBeli');
const isiPerSatuan  = document.getElementById('isiPerSatuan');
const marginInfo    = document.getElementById('marginInfo');
const marginText    = document.getElementById('marginText');
const hargaBeliPcs  = document.getElementById('hargaBeliPcs');
const konversiInfo  = document.getElementById('konversiInfo');
const labelSatuanBeli = document.getElementById('labelSatuanBeli');
const labelIsi        = document.getElementById('labelIsi');
const labelHargaPcs   = document.getElementById('labelHargaPcs');

function formatRupiah(n) {
  return 'Rp ' + Math.round(n).toLocaleString('id-ID');
}

function formatAngka(angka) {
  let val = angka.toString().replace(/\D/g, '');
  if (val === '') return '';
  return parseInt(val, 10).toLocaleString('id-ID');
}

function getAngkaMurni(str) {
  if (!str) return 0;
  return parseFloat(str.replace(/\./g, '')) || 0;
}

if (hb) {
  hb.addEventListener('input', function() {
    this.value = formatAngka(this.value);
    hitungMargin();
  });
}
if (hj) {
  hj.addEventListener('input', function() {
    this.value = formatAngka(this.value);
    hitungMargin();
  });
}

function hitungMargin() {
  if (!hb || !hj) return;

  const beliTotal = getAngkaMurni(hb.value);
  const jual      = getAngkaMurni(hj.value);
  const isi       = parseInt(isiPerSatuan?.value) || 1;
  const sBeli     = satuanBeli?.value || 'dus';

  const beliPerPcs = isi > 0 ? (beliTotal / isi) : beliTotal;

  if (beliTotal > 0 && isi > 1) {
    if (labelSatuanBeli) labelSatuanBeli.textContent = sBeli;
    if (labelIsi)        labelIsi.textContent = isi;
    if (labelHargaPcs)   labelHargaPcs.textContent = formatRupiah(beliPerPcs);
    if (konversiInfo)    konversiInfo.style.display = 'block';
  } else if (konversiInfo) {
    konversiInfo.style.display = 'none';
  }

  if (beliTotal > 0 && jual > 0) {
    const margin = jual - beliPerPcs;
    const persen = beliPerPcs > 0 ? (margin / beliPerPcs * 100).toFixed(1) : '0.0';

    if (marginText) marginText.textContent = formatRupiah(margin) + ' (' + persen + '%)';
    if (marginText) marginText.style.color = margin < 0 ? '#dc2626' : '#047857';
    if (hargaBeliPcs) hargaBeliPcs.textContent = formatRupiah(beliPerPcs);
    if (marginInfo) marginInfo.style.display = 'block';
  } else {
    if (marginInfo) marginInfo.style.display = 'none';
  }
}

if (hb && hj) {
  if (isiPerSatuan) isiPerSatuan.addEventListener('input', hitungMargin);
  if (satuanBeli)   satuanBeli.addEventListener('input', hitungMargin);
  hitungMargin();
}

function konfirmasiHapusSemuaProduk(jml) {
  document.getElementById('modalProdukJml').textContent = jml;
  document.getElementById('modalHapusSemuaProduk').classList.add('show');
}

function tutupModalSemuaProduk() {
  document.getElementById('modalHapusSemuaProduk').classList.remove('show');
}

document.getElementById('modalHapusSemuaProduk').addEventListener('click', function (e) {
  if (e.target === this) tutupModalSemuaProduk();
});

function bukaHapusProduk(id, nama, kode, kategori) {
  document.getElementById('modalHapusNamaProduk').textContent = nama;
  document.getElementById('modalHapusDetailProduk').innerHTML = 'Kode: <strong>' + kode + '</strong> | Kategori: <strong>' + kategori + '</strong>';
  document.getElementById('hapusProdukIdInput').value = id;
  document.getElementById('modalHapusProduk').classList.add('show');
}

function tutupModalHapusProduk() {
  document.getElementById('modalHapusProduk').classList.remove('show');
}

document.getElementById('modalHapusProduk').addEventListener('click', function (e) {
  if (e.target === this) tutupModalHapusProduk();
});

document.addEventListener('keydown', function (e) {
  if (e.key === 'Escape') {
    tutupModalSemuaProduk();
    tutupModalHapusProduk();
  }
});
</script>

<?php require_once '../includes/footer.php'; ?>