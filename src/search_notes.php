<?php
// Add error reporting for debugging
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Start session and include database connection
session_start();
require 'db_connection.php';

// Set content type to JSON
header('Content-Type: application/json');

// Check authentication
if (!isset($_SESSION["logged_in"]) || $_SESSION["logged_in"] !== true) {
    echo json_encode(["success" => false, "error" => "Unauthorized"]);
    exit();
}

// Get user ID and search query
$user_id = $_SESSION["user_id"] ?? 0;
$query = $_POST['query'] ?? '';

// Log info for debugging (you can remove this later)
file_put_contents('search_debug.log', 
    date('Y-m-d H:i:s') . " - Search request: User: $user_id, Query: '$query'\n", 
    FILE_APPEND);

try {
    // Test database connection first
    $pdo->query("SELECT 1");
    
    // Prepare search query with error handling
    $sql = "
        SELECT note_id, title, content, images, pinned_at, updated_at, is_locked, note_color, font_size
        FROM notes
        WHERE user_id = :id AND (title LIKE :query OR content LIKE :query)
        ORDER BY pinned_at DESC, updated_at DESC
    ";
    
    $stmt = $pdo->prepare($sql);
    if (!$stmt) {
        throw new PDOException("Failed to prepare query: " . $pdo->errorInfo()[2]);
    }
    
    // Execute search with proper parameters
    $searchTerm = '%' . $query . '%';
    $result = $stmt->execute(['id' => $user_id, 'query' => $searchTerm]);
    
    if (!$result) {
        throw new PDOException("Failed to execute query: " . $stmt->errorInfo()[2]);
    }
    
    // Fetch results
    $notes = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Process and sanitize notes
    $processedNotes = [];
    foreach ($notes as $note) {
        $processedNotes[] = [
            'note_id' => (int)$note['note_id'],
            'title' => $note['title'] ?? '',
            'content' => $note['content'] ?? '',
            'images' => $note['images'] ?? '',
            'pinned_at' => $note['pinned_at'],
            'is_locked' => (bool)($note['is_locked'] ?? false),
            'note_color' => $note['note_color'] ?? '#ffffff',
            'font_size' => $note['font_size'] ?? '1rem'
        ];
    }
    
    // Return successful response
    echo json_encode([
        "success" => true,
        "notes" => $processedNotes,
        "count" => count($processedNotes)
    ]);
    
} catch (PDOException $e) {
    // Log the detailed error
    file_put_contents('search_error.log', 
        date('Y-m-d H:i:s') . " - Database error: " . $e->getMessage() . "\n", 
        FILE_APPEND);
    
    // Return error response
    echo json_encode([
        "success" => false, 
        "error" => "Database error: " . $e->getMessage()
    ]);
} catch (Exception $e) {
    // Log any other errors
    file_put_contents('search_error.log', 
        date('Y-m-d H:i:s') . " - General error: " . $e->getMessage() . "\n", 
        FILE_APPEND);
    
    // Return error response
    echo json_encode([
        "success" => false, 
        "error" => "Error: " . $e->getMessage()
    ]);
}
?>