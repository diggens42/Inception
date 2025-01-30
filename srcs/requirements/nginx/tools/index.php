<?php
// Test PHP Version
echo "<p>PHP Version: " . phpversion() . "</p>";

// Test File Uploads
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_FILES['file'])) {
    $upload_dir = 'uploads/';
    $upload_file = $upload_dir . basename($_FILES['file']['name']);

    if (move_uploaded_file($_FILES['file']['tmp_name'], $upload_file)) {
        echo "<p>File uploaded successfully: " . htmlspecialchars(basename($_FILES['file']['name'])) . "</p>";
    } else {
        echo "<p>Error uploading file.</p>";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Test Index</title>
</head>
<body>
    <h1>Welcome to the PHP Test Site!</h1>

    <h2>Test File Upload</h2>
    <form action="" method="post" enctype="multipart/form-data">
        <label for="file">Choose a file to upload:</label>
        <input type="file" name="file" id="file">
        <input type="submit" value="Upload File">
    </form>

    <h2>Test PHP Version</h2>
    <p>This page is running PHP version: <?php echo phpversion(); ?></p>

</body>
</html>
