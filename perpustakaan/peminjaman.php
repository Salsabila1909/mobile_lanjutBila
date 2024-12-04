<?php
require 'config.php';

// Set header agar API bisa diakses dari luar
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type");

$method = $_SERVER['REQUEST_METHOD'];
$Path_Info = isset($_SERVER['PATH_INFO']) ? $_SERVER['PATH_INFO'] : (isset($_SERVER['ORIG_PATH_INFO']) ? $_SERVER['ORIG_PATH_INFO'] : '');
$request = explode('/', trim($Path_Info, '/'));
$id = isset($request[1]) ? (int)$request[1] : null;

switch ($method) {
    case 'GET':
        if ($id) {
            // GET Peminjaman by ID
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                echo json_encode($peminjaman);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
            // GET All Peminjaman
            $stmt = $pdo->query("SELECT * FROM peminjaman");
            $peminjamanList = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($peminjamanList);
        }
        break;
        
    case 'POST':
        // Create new peminjaman
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!empty($data['kodeanggota']) && !empty($data['tgl_pinjam']) && !empty($data['tgl_kembali']) && !empty($data['kodebuku'])) {
            $stmt = $pdo->prepare("INSERT INTO peminjaman (kodeanggota, tgl_pinjam, tgl_kembali, kodebuku) VALUES (?, ?, ?, ?)");
            $stmt->execute([$data['kodeanggota'], $data['tgl_pinjam'], $data['tgl_kembali'], $data['kodebuku']]);
            echo json_encode(["message" => "Peminjaman created", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data"]);
        }
        break;
        
    case 'PUT':
        // Update peminjaman by ID
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);
            
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                $kodeanggota = $data['kodeanggota'] ?? $peminjaman['kodeanggota'];
                $tgl_pinjam = $data['tgl_pinjam'] ?? $peminjaman['tgl_pinjam'];
                $tgl_kembali = $data['tgl_kembali'] ?? $peminjaman['tgl_kembali'];
                $kodebuku = $data['kodebuku'] ?? $peminjaman['kodebuku'];
                
                $stmt = $pdo->prepare("UPDATE peminjaman SET kodeanggota = ?, tgl_pinjam = ?, tgl_kembali = ?, kodebuku = ? WHERE id = ?");
                $stmt->execute([$kodeanggota, $tgl_pinjam, $tgl_kembali, $kodebuku, $id]);
                echo json_encode(["message" => "Peminjaman updated"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    case 'DELETE':
        // Delete peminjaman by ID
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM peminjaman WHERE id = ?");
            $stmt->execute([$id]);
            $peminjaman = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($peminjaman) {
                $stmt = $pdo->prepare("DELETE FROM peminjaman WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Peminjaman deleted"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Peminjaman not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    default:
        http_response_code(405);
        echo json_encode(["message" => "Method not allowed"]);
        break;
}
?>
