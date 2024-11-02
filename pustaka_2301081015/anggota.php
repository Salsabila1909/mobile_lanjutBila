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
// Ambil ID jika ada
$id = isset($request[1]) ? (int)$request[1] : null;

switch ($method) {
    case 'GET':
        if ($id) {
            // GET Student by ID
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($anggota) {
                echo json_encode($sanggota);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota not found"]);
            }
        } else {
            // GET All Students
            $stmt = $pdo->query("SELECT * FROM anggota");
            $anggota = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($anggota);
        }
        break;
        
    case 'POST':
        // Create new student
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!empty($data['nama_anggota']) && !empty($data['kode_anggota']) && !empty($data['alamat'] && !empty($data['jekel']))) {
            $stmt = $pdo->prepare("INSERT INTO anggota (nama_anggota, kode_anggota, alamat, jekel) VALUES (?, ?, ?, ?)");
            $stmt->execute([$data['nama_anggota'], $data['kode_anggota'], $data['alamat'], $data['jekel']]);
            echo json_encode(["message" => "Student created", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data"]);
        }
        break;
        
    case 'PUT':
        // Update student by ID
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);
            
            $stmt = $pdo->prepare("SELECT * FROM anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($anggota) {
                $nama_anggota = $data['nama_anggota'] ?? $anggota['nama_anggota'];
                $kode_anggota = $data['kode_anggota'] ?? $anggota['kode_anggota'];
                $alamat = $data['alamat'] ?? $anggota['alamat'];
                $jekel = $data['jekel'] ?? $anggota['jekel'];
                
                $stmt = $pdo->prepare("UPDATE anggota SET nama_anggota = ?, kode_anggota = ?, alamat = ? , jekel = ? WHERE id = ?");
                $stmt->execute([$nama_anggota, $kode_anggota, $alamat, $jekel, $id]);
                echo json_encode(["message" => "Anggota updated"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    case 'DELETE':
        // Delete student by ID
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM Anggota WHERE id = ?");
            $stmt->execute([$id]);
            $anggota = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($anggota) {
                $stmt = $pdo->prepare("DELETE FROM anggota WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Anggota deleted"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Anggota not found"]);
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