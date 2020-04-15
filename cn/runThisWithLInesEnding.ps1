$preStr = "https://ipfs.io/ipfs/bafykbzaced4xstofs4tc5q4irede6uzaz3qzcdvcb2eedxgfakzwdyjnxgohq/"

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



foreach($line in $allLines){
    $compiledString = $preStr + $line
    $compiledString 
    
    Invoke-WebRequest $compiledString 
    pause
}