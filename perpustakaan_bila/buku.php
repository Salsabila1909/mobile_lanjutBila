<?php
require 'config.php';


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
            
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($buku) {
                echo json_encode($buku);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Buku not found"]);
            }
        } else {
            
            $stmt = $pdo->query("SELECT * FROM buku");
            $bukuList = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($bukuList);
        }
        break;
        
    case 'POST':
        
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!empty($data['kode_buku']) && !empty($data['judul']) && !empty($data['penerbit']) && !empty($data['pengarang']) && !empty($data['tahun_terbit'])) {
            $stmt = $pdo->prepare("INSERT INTO buku (kode_buku, judul, penerbit, pengarang, tahun_terbit) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$data['kode_buku'], $data['judul'], $data['penerbit'], $data['pengarang'], $data['tahun_terbit']]);
            echo json_encode(["message" => "Buku created", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data"]);
        }
        break;
        
    case 'PUT':
       
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);
            
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($buku) {
                $kode_buku = $data['kode_buku'] ?? $buku['kode_buku'];
                $judul = $data['judul'] ?? $buku['judul'];
                $penerbit = $data['penerbit'] ?? $buku['penerbit'];
                $pengarang = $data['pengarang'] ?? $buku['pengarang'];
                $tahun_terbit = $data['tahun_terbit'] ?? $buku['tahun_terbit'];
                
                $stmt = $pdo->prepare("UPDATE buku SET kode_buku = ?, judul = ?, penerbit = ?, pengarang = ?, tahun_terbit = ? WHERE id = ?");
                $stmt->execute([$kode_buku, $judul, $penerbit, $pengarang, $tahun_terbit, $id]);
                echo json_encode(["message" => "Buku updated"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Buku not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    case 'DELETE':
        
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM buku WHERE id = ?");
            $stmt->execute([$id]);
            $buku = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($buku) {
                $stmt = $pdo->prepare("DELETE FROM buku WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Buku deleted"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Buku not found"]);
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
