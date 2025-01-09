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
           
            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($pengembalian) {
                echo json_encode($pengembalian);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian not found"]);
            }
        } else {
            
            $stmt = $pdo->query("SELECT * FROM pengembalian");
            $pengembalianList = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode($pengembalianList);
        }
        break;
        
    case 'POST':
       
        $data = json_decode(file_get_contents("php://input"), true);
        
        if (!empty($data['kodeanggota']) && isset($data['denda']) && !empty($data['kodebuku'])) {
            $stmt = $pdo->prepare("INSERT INTO pengembalian (kodeanggota, denda, kodebuku) VALUES (?, ?, ?)");
            $stmt->execute([$data['kodeanggota'], $data['denda'], $data['kodebuku']]);
            echo json_encode(["message" => "Pengembalian created", "id" => $pdo->lastInsertId()]);
        } else {
            http_response_code(400);
            echo json_encode(["message" => "Invalid data"]);
        }
        break;
        
    case 'PUT':
       
        if ($id) {
            $data = json_decode(file_get_contents("php://input"), true);
            
            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($pengembalian) {
                $kodeanggota = $data['kodeanggota'] ?? $pengembalian['kodeanggota'];
                $denda = $data['denda'] ?? $pengembalian['denda'];
                $kodebuku = $data['kodebuku'] ?? $pengembalian['kodebuku'];
                
                $stmt = $pdo->prepare("UPDATE pengembalian SET kodeanggota = ?, denda = ?, kodebuku = ? WHERE id = ?");
                $stmt->execute([$kodeanggota, $denda, $kodebuku, $id]);
                echo json_encode(["message" => "Pengembalian updated"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian not found"]);
            }
        } else {
            http_response_code(400);
            echo json_encode(["message" => "ID not provided"]);
        }
        break;
        
    case 'DELETE':
        
        if ($id) {
            $stmt = $pdo->prepare("SELECT * FROM pengembalian WHERE id = ?");
            $stmt->execute([$id]);
            $pengembalian = $stmt->fetch(PDO::FETCH_ASSOC);
            
            if ($pengembalian) {
                $stmt = $pdo->prepare("DELETE FROM pengembalian WHERE id = ?");
                $stmt->execute([$id]);
                echo json_encode(["message" => "Pengembalian deleted"]);
            } else {
                http_response_code(404);
                echo json_encode(["message" => "Pengembalian not found"]);
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
