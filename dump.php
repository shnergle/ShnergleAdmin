<?php
// http://daipratt.co.uk/exporting-data-sql-server-2005-express-csv-php-sqlsrv/
//sqlsrv connection string details.
require_once 'configs/config.php';
session_start();
if (empty($_SESSION['auth'])) return;
$coninfo = array('Database' => DB_DB, 'UID' => DB_USER, 'PWD' => DB_PASS);
$db = sqlsrv_connect(DB_SERVER, $coninfo);
$sql = "SELECT * FROM ".$_GET['table'];
$results = sqlsrv_query($db, $sql);
$out = '';
//Generate CSV file - Set as sqlsrv_ASSOC as you don't need the numeric values.
while ($l = sqlsrv_fetch_array($results, SQLSRV_FETCH_ASSOC)) {
    foreach($l AS $key => $value){
        //If the character " exists, then escape it, otherwise the csv file will be invalid.
        $pos = strpos($value, '"');
        $pos1 = strpos($value, ',');
        if ($pos !== false) {
            $value = str_replace('"', '\"', $value);
        }
        if ($pos1 !== false) {
            $value = str_replace(',', '\,', $value);
        }
        $out .= '"'.$value.'",';
    }
    $out .= "\n";
}
sqlsrv_free_stmt($results);
sqlsrv_close($db);
// Output to browser with the CSV mime type
header("Content-type: text/x-csv");
header("Content-Disposition: attachment; filename=table_dump.csv");
echo $out;
?>