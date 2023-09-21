# Define the printer details
$printerName = 'Printer Nam'
$printerPort = 'IP_10.X.X.X'
$printerIP = '10.X.X.X'
$infPath = "$PSScriptRoot\HPUniversal\pcl6\hpcu270u.inf"

# Check if the printer already exists
if (Get-Printer | Where-Object { $_.Name -eq $printerName }) {
    Write-Host "Printer $printerName already installed."
    exit
}

# Check if the printer port exists
if (!(Get-PrinterPort | Where-Object { $_.Name -eq $printerPort })) {
    # Create the TCP/IP printer port
    Add-PrinterPort -Name $printerPort -PrinterHostAddress $printerIP
}

# Install the printer driver using rundll32
$driverCommand = "rundll32 printui.dll,PrintUIEntry /if /b `"$printerName`" /f `"$infPath`" /r `"$printerPort`" /m `"HP Universal Printing PCL 6`""
Invoke-Expression $driverCommand

# Add the printer using the installed driver and port
Add-Printer -Name $printerName -DriverName 'HP Universal Printing PCL 6' -PortName $printerPort

# Check if the printer was added successfully
if (Get-Printer | Where-Object { $_.Name -eq $printerName }) {
    Write-Host "Printer $printerName installed successfully."
} else {
    Write-Host "Failed to install printer $printerName."
}
