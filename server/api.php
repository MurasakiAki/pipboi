<?php

// Set headers to allow cross-origin requests (CORS)
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Check if the HTTP method is GET
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Read the JSON file
    $data = file_get_contents('data.json');

    // Decode JSON data
    $jsonData = json_decode($data, true);

    // If decoding was successful, return the data as JSON response
    if ($jsonData !== null) {
        echo json_encode($jsonData);
    } else {
        // If decoding failed, return an error message
        http_response_code(500);
        echo json_encode(array("message" => "Failed to decode JSON."));
    }
} else {
    // If the request method is not GET, return an error message
    http_response_code(405); // Method Not Allowed
    echo json_encode(array("message" => "Only GET method is allowed."));
}
?>
