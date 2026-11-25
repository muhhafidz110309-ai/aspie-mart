<?php
date_default_timezone_set('Asia/Jakarta');

$DB_DRIVER = getenv('DB_DRIVER') ?: (getenv('VERCEL') ? 'pgsql' : 'mysql');
$DB_HOST   = getenv('DB_HOST') ?: 'localhost';
$DB_PORT   = getenv('DB_PORT') ?: ($DB_DRIVER === 'pgsql' ? '5432' : '3306');
$DB_NAME   = getenv('DB_NAME') ?: 'mart-aspi';
$DB_USER   = getenv('DB_USER') ?: 'root';
$DB_PASS   = getenv('DB_PASS') ?: '';
$DB_SSL    = getenv('DB_SSL')  ?: ($DB_DRIVER === 'pgsql' ? '1' : '0');

try {
    $opts = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
        PDO::ATTR_TIMEOUT            => 5,
    ];

    if ($DB_DRIVER === 'pgsql') {
        $sslmode = ($DB_SSL === '1') ? 'require' : 'prefer';
        $dsn = "pgsql:host={$DB_HOST};port={$DB_PORT};dbname={$DB_NAME};sslmode={$sslmode};connect_timeout=5";
        $pdo = new PDO($dsn, $DB_USER, $DB_PASS, $opts);
        $pdo->exec("SET TIME ZONE 'Asia/Jakarta'");
    } else {
        if ($DB_SSL === '1') {
            foreach (['/etc/pki/tls/certs/ca-bundle.crt', '/etc/ssl/certs/ca-certificates.crt', '/etc/ssl/cert.pem'] as $ca) {
                if (is_readable($ca)) { $opts[PDO::MYSQL_ATTR_SSL_CA] = $ca; break; }
            }
            if (!isset($opts[PDO::MYSQL_ATTR_SSL_CA])) {
                $opts[PDO::MYSQL_ATTR_SSL_CIPHER] = 'DEFAULT';
            }
            $opts[PDO::MYSQL_ATTR_SSL_VERIFY_SERVER_CERT] = false;
        }
        $dsn = "mysql:host={$DB_HOST};port={$DB_PORT};dbname={$DB_NAME};charset=utf8mb4";
        $pdo = new PDO($dsn, $DB_USER, $DB_PASS, $opts);
        $pdo->exec("SET time_zone = '+07:00'");
    }
} catch (PDOException $e) {
    die('Koneksi database gagal: ' . $e->getMessage());
}

/* ============================================================
   SESSION DI DATABASE (KOMPATIBEL POSTGRESQL & MYSQL)
   ============================================================ */
if (getenv('VERCEL')) {
    if ($DB_DRIVER === 'pgsql') {
        $pdo->exec("CREATE TABLE IF NOT EXISTS php_sessions (
            id VARCHAR(128) NOT NULL PRIMARY KEY,
            data TEXT NOT NULL,
            updated_at BIGINT NOT NULL
        )");
        $pdo->exec("CREATE INDEX IF NOT EXISTS idx_php_sessions_updated_at ON php_sessions (updated_at)");
    } else {
        $pdo->exec("CREATE TABLE IF NOT EXISTS php_sessions (
            id VARCHAR(128) NOT NULL PRIMARY KEY,
            data MEDIUMTEXT NOT NULL,
            updated_at INT UNSIGNED NOT NULL,
            INDEX (updated_at)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
    }

    class DbSessionHandler implements SessionHandlerInterface
    {
        private PDO $pdo;
        private string $driver;
        public function __construct(PDO $pdo, string $driver) {
            $this->pdo = $pdo;
            $this->driver = $driver;
        }
        public function open(string $path, string $name): bool { return true; }
        public function close(): bool { return true; }
        public function read(string $id): string|false
        {
            $s = $this->pdo->prepare('SELECT data FROM php_sessions WHERE id = ?');
            $s->execute([$id]);
            $r = $s->fetchColumn();
            return $r === false ? '' : $r;
        }
        public function write(string $id, string $data): bool
        {
            if ($this->driver === 'pgsql') {
                $s = $this->pdo->prepare(
                    'INSERT INTO php_sessions (id, data, updated_at) VALUES (?, ?, ?)
                     ON CONFLICT (id) DO UPDATE SET data = EXCLUDED.data, updated_at = EXCLUDED.updated_at'
                );
            } else {
                $s = $this->pdo->prepare('REPLACE INTO php_sessions (id, data, updated_at) VALUES (?, ?, ?)');
            }
            return $s->execute([$id, $data, time()]);
        }
        public function destroy(string $id): bool
        {
            return $this->pdo->prepare('DELETE FROM php_sessions WHERE id = ?')->execute([$id]);
        }
        public function gc(int $max): int|false
        {
            $s = $this->pdo->prepare('DELETE FROM php_sessions WHERE updated_at < ?');
            $s->execute([time() - $max]);
            return $s->rowCount();
        }
    }

    session_set_save_handler(new DbSessionHandler($pdo, $DB_DRIVER), true);
    session_set_cookie_params([
        'lifetime' => 0,
        'path'     => '/',
        'secure'   => true,
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
}

session_start();

require_once __DIR__ . '/../includes/functions.php';