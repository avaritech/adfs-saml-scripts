$preStr = "https://ipfs.io/ipfs/bafykbzaced4xstofs4tc5q4irede6uzaz3qzcdvcb2eedxgfakzwdyjnxgohq/"
$downloadDir = "T:\CN-investigation\pdfs\"
$allLines = gc linesEnding

add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@

[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$i=0

foreach($line in $allLines){
$i++
    $compiledString = $preStr + $line
    #$compiledString 
    $pdfName = $line.substring(5)
    $pdfName
    Invoke-WebRequest $compiledString -outFile "$downloadDir$pdfName"

}