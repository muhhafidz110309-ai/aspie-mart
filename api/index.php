<?php
/**
 * Front controller untuk Vercel.
 * Meneruskan URL seperti /login.php atau /admin/produk.php ke file PHP aslinya,
 * supaya semua path relatif di aplikasi tetap bekerja seperti di XAMPP.
 */
$root = realpath(__DIR__ . '/..');

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?: '/';
$path = rawurldecode($path);

if ($path === '/' || $path === '') {
    header('Location: /login.php');
    exit;
}

// Hanya file .php yang boleh diakses, dan bukan folder internal
if (
    !preg_match('#\.php$#i', $path) ||
    preg_match('#^/(vendor|config|includes|api|public)/#i', $path) ||
    strpos($path, '..') !== false
) {
    http_response_code(404);
    echo '404 Not Found';
    exit;
}

$file = realpath($root . $path);

// Fallback: /user/struk.php atau /admin/struk.php -> struk.php di root
if (!$file && preg_match('#^/(user|admin)/struk\.php$#i', $path)) {
    $path = '/struk.php';
    $file = realpath($root . $path);
}

if (!$file || strpos($file, $root . DIRECTORY_SEPARATOR) !== 0 || !is_file($file)) {
    http_response_code(404);
    echo '404 Not Found';
    exit;
}

$_SERVER['PHP_SELF']        = $path;
$_SERVER['SCRIPT_NAME']     = $path;
$_SERVER['SCRIPT_FILENAME'] = $file;

set_include_path($root . PATH_SEPARATOR . get_include_path());
chdir(dirname($file));

require $file;
