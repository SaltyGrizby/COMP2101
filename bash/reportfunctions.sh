# Function Library created for sysinfo.sh script

lshwOutput=$(lshw)
lscpuOutput=$(lscpu)
dmidecodeOutput=$(dmidecode)
lsblkOutput=$(lsblk)

function cpureport {
# CPU Information 

#lscpu command is used which gives CPU information
#grep is used to get 'Model name:' field, while 
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpumodel=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,*Model name: *//')
if [ -z "$cpumodel" ]; then
	cpumodel='"Error!!! Data is unavailable'
else cpumodel=$(echo "$lscpuOutput" | grep 'Model name:' | sed 's/,*Model name: *//')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'Architecture:' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuArch=$(echo "$lscpuOutput" | grep 'Architecture:' | awk '{print $2}')
if [ -z "$cpuArch" ]; then
	cpuArch='"Error!!! Data is unavailable'
else cpuArch=$(echo "$lscpuOutput" | grep 'Architecture:' | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'CPU(s):' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCore=$(echo "$lscpuOutput" | grep 'CPU(s):' | head -1 | awk '{print $2}')
if [ -z "$cpuCore" ]; then
	cpuCore='"Error!!! Data is unavailable'
else cpuCore=$(echo "$lscpuOutput" | grep 'CPU(s):' | head -1 | awk '{print $2}')
fi

#lshw command used with class "cpu" to filter cpu hardware
#grep is used to get 'capacity::' field, while awk is used to print the 2nd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuMaxSpeed=$(echo "$lshwOutput" -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
if [ -z "$cpuMaxSpeed" ]; then
	cpuMaxSpeed='"Error!!! Data is unavailable'
else cpuMaxSpeed=$(echo "$lshwOutput" -class cpu | grep 'capacity:' | head -1 | awk '{print $2}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1d' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1D=$(echo "$lscpuOutput" | grep 'L1d' | awk '{print $3}')
if [ -z "$cpuCacheL1D" ]; then
	cpuCacheL1D='"Error!!! Data is unavailable'
else cpuCacheL1D=$(echo "$lscpuOutput" | grep 'L1d' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L1i' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL1I=$(echo "$lscpuOutput" | grep 'L1i' | awk '{print $3}')
if [ -z "$cpuCacheL1I" ]; then
	cpuCacheL1I='"Error!!! Data is unavailable'
else cpuCacheL1I=$(echo "$lscpuOutput" | grep 'L1i' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L2' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
if [ -z "$cpuCacheL2" ]; then
	cpuCacheL2='"Error!!! Data is unavailable'
else cpuCacheL2=$(echo "$lscpuOutput" | grep 'L2' | awk '{print $3}')
fi

#lscpu command is used which gives CPU information
#grep is used to get 'L3' field, while awk is used to print the 3rd field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
cpuCacheL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
if [ -z "$cpuCacheL3" ]; then
	cpuCacheL3='"Error!!! Data is unavailable'
else cpuCacheL3=$(echo "$lscpuOutput" | grep 'L3' | awk '{print $3}')
fi

# if all data items in a section are unavailable, then an error is printed
if [[ "$cpumodel" == "$cpuArch" ]] && [[ "$cpuArch"  == "$cpuCore" ]] && [[ "$cpuCore" == "$cpuMaxSpeed" ]] && [[ "$cpuMaxSpeed"  == "$cpuCacheL1D" ]] && [[ "$cpuCacheL1D" == "$cpuCacheL1I" ]] && [[ "$cpuCacheL1I"  == "$cpuCacheL2" ]] && [[ "$cpuCacheL2" == "$cpuCacheL3" ]]; then
	cpuinfo='     Error!!!, Section Unavailable     '
else cpuinfo="
CPU Model: $cpumodel
CPU Architecture: $cpuArch
CPU core count: $cpuCore
CPU Maximum speed: $cpuMaxSpeed
Size of cache(L1d): $cpuCacheL1D
Size of cache(L1i): $cpuCacheL1I
Size of cache(L2): $cpuCacheL2
Size of cache(L3): $cpuCacheL3"
fi

cat << EOF

-----------CPU Information--------------
$cpuinfo

EOF
}

function computerreport {
################ System Description ######################

#lshw command used with class "system" to filter system hardware
#grep is used to get 'description' field, while awk is used to print the 2nd itme field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compDescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
if [ -z "$compDescription" ]; then 
	compDescription='"Error!!!" Data is unavailable'
else compDescription=$(echo "$lshwOutput" -class system | grep -m1 -i 'description:' | awk '{print $2}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'vendor' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
compManufacture=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
if [ -z "$compManufacture" ]; then
	compManufacture='"Error!!!" Data is unavailable'
else compManufacture=$(echo "$lshwOutput" -class system | grep 'vendor:' | head -1 | awk '{$1=""; print $0}')
fi

#lshw command used with class "system" to filter system hardware
#grep is used to get 'serial:' field, while awk is used to print all the fields after field 1
#-z test command is used to check if the data is available or not' by testing the variable and checking if it's empty or not. If empty an error is displayed
compSerial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial:' | awk '{$1=""; print $0}')
if [ -z "$compSerial" ]; then
	compSerial='"Error!!!" Data is unavailable'
else compSerial=$(echo "$lshwOutput" -class system | grep -m1 -i 'serial:' | awk '{$1=""; print $0}')
fi

# if all data items in a section are unavailable, then an error is printed
if [[  "$compManufacture" == "$compDescription" ]] && [[ "$compDescription"  == "$compSerial" ]]; then
	sysDesc='     Error!!!, Section Unavailable     '
else sysDesc="
Computer Manufacturer: $compManufacture
Computer description or model: $compDescription
Computer Serial Number: $compSerial"
fi

cat << EOF

-----------System Description-----------
$sysDesc

EOF
}

function osreport {
# OS Information 

#hostnamectl command to display OS info with awk command to only get the required data in all the fields after field 1 exclusive
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
distroVer=$(hostnamectl | grep 'Kernel:' | awk '{$1=""; print $0}') 
if [ -z "$distroVer" ]; then
	distroVer='"Error!!!" Data is unavailable'
else distroVer=$(hostnamectl | grep 'Kernel:' | awk '{$1=""; print $0}') 
fi

#hostnamectl command to display OS info with awk command to only get the required data
#FNR == 7 is used for selecting the line 7 and print $3, $4, $5 is used to print the 3rd, 4th, and 5th item field
#-z test command is used to check if the data is available or not by testing the variable and checking if it's empty or not. If empty an error is displayed
os=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')
if [ -z "$os" ]; then
	os='"Error!!!" Data is unavailable'
else os=$(hostnamectl | awk 'FNR == 7 {print $3, $4, $5}')
fi

# if all data items in a section are unavailable, then an error is printed
if [[  "$os" == "$distroVer" ]]; then
	osinfo='     Error!!!, Section Unavailable     '
else osinfo="
Linux Distro: $os
Distro version: $distroVer"
fi

cat << EOF
========================================

------------OS Information--------------
$osinfo

EOF
}

function ramreport {
#  RAM INFORMATION 
#

ramManufacturer=$(echo "$dmidecodeOutput" | grep -m1 -i "manufacturer" | awk '{$1=""; print $0}')
if [ -z "$ramManufacturer" ]; then
	ramManufacturer='"Error!!! Data is unavailable'
else ramManufacturer=$(echo "$dmidecodeOutput" | grep -m1 -i "manufacturer" | awk '{$1=""; print $0}')
fi

ramProductName=$(echo "$dmidecodeOutput" | grep -m1 -i "Product name" | awk '{$1=""; $2=""; print $0}')
if [ -z "$ramProductName" ]; then
	ramProductName='"Error!!! Data is unavailable'
else ramProductName=$(echo "$dmidecodeOutput" | grep -m1 -i "Product name" | awk '{$1=""; $2=""; print $0}')
fi

ramSerialNum=$(echo "$dmidecodeOutput" | grep -m1 -i "serial number" | awk '{$1=""; $2=""; print $0}')
if [ -z "$ramSerialNum" ]; then
	ramSerialNum='"Error!!! Data is unavailable'
else ramSerialNum=$(echo "$dmidecodeOutput" | grep -m1 -i "serial number" | awk '{$1=""; $2=""; print $0}')
fi

ramSize=$(echo "$lshwOutput" | grep -A10 "\-memory" | grep 'size:' | awk 'FNR == 2 {$1=""; print $0}')
if [ -z "$ramSize" ]; then
	ramSize='"Error!!! Data is unavailable'
else ramSize=$(echo "$lshwOutput" | grep -A10 "\-memory" | grep 'size:' | awk 'FNR == 2 {$1=""; print $0}')
fi

ramSpeed=$(echo "$dmidecodeOutput" --type 17 | grep -m1 Speed | awk '{ $1=""; print $0 }')
if [ -z "$ramSpeed" ]; then
	ramSpeed='"Error!!! Data is unavailable'
else ramSpeed=$(echo "$dmidecodeOutput" --type 17 | grep -m1 Speed | awk '{ $1=""; print $0 }')
fi

ramLocation=$(echo "$lshwOutput" | grep -m1 'slot: RAM' | awk '{$1=""; $2=""; print $0}')
if [ -z "$ramLocation" ]; then
	ramLocation='"Error!!! Data is unavailable'
else ramLocation=$(echo "$lshwOutput" | grep -m1 'slot: RAM' | awk '{$1=""; $2=""; print $0}')
fi

totalSize=$(echo "$lshwOutput" | grep -A5 "\-memory" | grep -m1 'size:' | awk '{$1=""; print $0}')
if [ -z "$totalSize" ]; then
	totalSize='"Error!!! Data is unavailable'
else totalSize=$(echo "$lshwOutput" | grep -A5 "\-memory" | grep -m1 'size:' | awk '{$1=""; print $0}')
fi

# if all data items in a section are unavailable, then an error is printed
if [[ "$ramManufacturer" == "$ramProductName" ]] && [[ "$ramProductName"  == "$ramSerialNum" ]] && [[ "$ramSerialNum" == "$ramSize" ]] && [[ "$ramSize"  == "$ramSpeed" ]]; then
	ramtable='     Error!!!, Section Unavailable     '
else ramtable=$(paste -d ';' <(echo "$ramManufacturer") <(echo "$ramProductName") <(
echo "$ramSerialNum") <(echo "$ramSize") <(echo "$ramSpeed") <(echo "$ramLocation") <(
echo "$totalSize") | column -N Manufacturer,Model,'Serial Num',Size,Speed,Location,'Total Size' -s ';' -o ' | ' -t)
fi

cat << EOF
========================================

-----------RAM Information--------------
$ramtable

EOF
}

function videoreport {
############################ VIDEO REPORT #################################

videoCardManufacturer=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep "vendor:" | awk '{print $2}')
if [ -z "$videoCardManufacturer" ]; then
	videoCardManufacturer='"Error!!! Data is unavailable'
else videoCardManufacturer=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep "vendor:" | awk '{print $2}')
fi

videoCardModel=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep "product" | awk '{$1=""; print $0}')
if [ -z "$videoCardModel" ]; then
	videoCardModel='"Error!!! Data is unavailable'
else videoCardModel=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep "product" | awk '{$1=""; print $0}')
fi

videoCardDescription=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep  "description" | awk '{$1=""; print $0}')
if [ -z "$videoCardDescription" ]; then
	videoCardDescription='"Error!!! Data is unavailable'
else videoCardDescription=$(echo "$lshwOutput" | grep -A10 "\*\-display" | grep  "description" | awk '{$1=""; print $0}')
fi

# if all data items in a section are unavailable, then an error is printed
if [[  "$videoCardManufacturer" == "$videoCardModel" ]] && [[ "$videoCardModel"  == "$videoCardDescription" ]]; then
	videoDesc='     Error!!!, Section Unavailable     '
else videoDesc="
Video Card Manufacturer: $videoCardManufacturer
Video Card description:  $videoCardModel
Video Card or model: $videoCardDescription"
fi

cat << EOF
=========================================

----------Video Report-------------------
$videoDesc
EOF
}

function diskreport {
#  STORAGE INFORMATION  
#
driveManufacturer0=$(echo "$lshwOutput" | grep -A10 '\*\-disk' | grep 'vendor:' | awk '{print $2}')
if [ -z "$driveManufacturer0" ]; then
	driveManufacturer0='"Error!!! Data is unavailable'
else driveManufacturer0=$(echo "$lshwOutput" | grep -A10 '\*\-disk' | grep 'vendor:' | awk '{print $2}')
fi

driveVendor1=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:0" | grep "vendor:" | awk '{$1=""; print $0}')
if [ -z "$driveVendor1" ]; then
	driveVendor1='"Error!!! Data is unavailable'
else driveVendor1=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:0" | grep "vendor:" | awk '{$1=""; print $0}')
fi

driveVendor2=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:1" | grep "vendor:" | awk '{$1=""; print $0}')
if [ -z "$driveVendor2" ]; then
	driveVendor2='"Error!!! Data is unavailable'
else driveVendor2=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:1" | grep "vendor:" | awk '{$1=""; print $0}')
fi

driveVendor3=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:2" | grep "vendor:" | awk '{$1=""; print $0}')
if [ -z "$driveVendor3" ]; then
	driveVendor3='"Error!!! Data is unavailable'
else driveVendor3=$(echo "$lshwOutput" | grep -m1 -A8 "\-volume:2" | grep "vendor:" | awk '{$1=""; print $0}')
fi


driveModel=$(echo "$lshwOutput" | grep -m1 -A10 "\-disk" | grep "product:" | awk '{$1=""; print $0}')
if [ -z "$driveModel" ]; then
	driveModel='"Error!!! Data is unavailable'
else driveModel=$(echo "$lshwOutput" | grep -m1 -A10 "\-disk" | grep "product:" | awk '{$1=""; print $0}')

fi

driveSize0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $4"B"}')
if [ -z "$driveSize0" ]; then
	driveSize0='"Error!!! Data is unavailable'
else driveSize0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $4"B"}')
fi

driveSize1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $4"B"}')
if [ -z "$driveSize1" ]; then
	driveSize1='"Error!!! Data is unavailable'
else driveSize1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $4"B"}')
fi

driveSize2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $4"B"}')
if [ -z "$driveSize2" ]; then
	driveSize2='"Error!!! Data is unavailable'
else driveSize2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $4"B"}')
fi

driveSize3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $4"B"}')
if [ -z "$driveSize3" ]; then
	driveSize3='"Error!!! Data is unavailable'
else driveSize3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $4"B"}')
fi



drivePartition0=$(echo "$lsblkOutput" | grep -w "sda" | awk '{print $1}')
if [ -z "$drivePartition0" ]; then
	drivePartition0='"Error!!! Data is unavailable'
else drivePartition0=$(echo "$lsblkOutput" | grep -w "sda" | awk '{print $1}')
fi

drivePartition1=$(echo "$lsblkOutput" | grep -w "sda1" | awk '{print $1}' | tail -c 5)
if [ -z "$drivePartition1" ]; then
	drivePartition1='"Error!!! Data is unavailable'
else drivePartition1=$(echo "$lsblkOutput" | grep -w "sda1" | awk '{print $1}' | tail -c 5)
fi

drivePartition2=$(echo "$lsblkOutput" | grep -w "sda2" | awk '{print $1}' | tail -c 5)
if [ -z "$drivePartition2" ]; then
	drivePartition2='"Error!!! Data is unavailable'
else drivePartition2=$(echo "$lsblkOutput" | grep -w "sda2" | awk '{print $1}' | tail -c 5)
fi

drivePartition3=$(echo "$lsblkOutput" | grep -w "sda3" | awk '{print $1}' | tail -c 5)
if [ -z "$drivePartition3" ]; then
	drivePartition3='"Error!!! Data is unavailable'
else drivePartition3=$(echo "$lsblkOutput" | grep -w "sda3" | awk '{print $1}' | tail -c 5)
fi

driveMountPoint0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $7}')
if [ -z "$driveMountPoint0" ]; then
	driveMountPoint0='"Error!!! Data is unavailable'
else driveMountPoint0=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==1 {print $7}')
fi

driveMountPoint1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $7}')
if [ -z "$driveMountPoint1" ]; then
	driveMountPoint1='"Error!!! Data is unavailable'
else driveMountPoint1=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==2 {print $7}')
fi

driveMountPoint2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $7}')
if [ -z "$driveMountPoint2" ]; then
	driveMountPoint2='"Error!!! Data is unavailable'
else driveMountPoint2=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==3 {print $7}')
fi

driveMountPoint3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $7}')
if [ -z "$driveMountPoint3" ]; then
	driveMountPoint3='"Error!!! Data is unavailable'
else driveMountPoint3=$(echo "$lsblkOutput" | grep "sda" | awk 'FNR==4 {print $7}')
fi

driveFilesystemSizeSDA2=$(df -h | grep "sda2" | awk '{print $2"B"}')
if [ -z "$driveFilesystemSizeSDA2" ]; then
	driveFilesystemSizeSDA2='"Error!!! Data is unavailable'
else driveFilesystemSizeSDA2=$(df -h | grep "sda2" | awk '{print $2"B"}')
fi

driveFilesystemSizeSDA3=$(df -h | grep "sda3" | awk '{print $2"B"}')
if [ -z "$driveFilesystemSizeSDA3" ]; then
	driveFilesystemSizeSDA3='"Error!!! Data is unavailable'
else driveFilesystemSizeSDA3=$(df -h | grep "sda3" | awk '{print $2"B"}')
fi


driveFilesystemFreeSDA2=$(df -h | grep "sda2" | awk '{print $4"B"}')
if [ -z "$driveFilesystemFreeSDA2" ]; then
	driveFilesystemFreeSDA2='"Error!!! Data is unavailable'
else driveFilesystemFreeSDA2=$(df -h | grep "sda2" | awk '{print $4"B"}')
fi

driveFilesystemFreeSDA3=$(df -h | grep "sda3" | awk '{print $4"B"}')
if [ -z "$driveFilesystemFreeSDA3" ]; then
	driveFilesystemFreeSDA3='"Error!!! Data is unavailable'
else driveFilesystemFreeSDA3=$(df -h | grep "sda3" | awk '{print $4"B"}')
fi


 diskTable=$(paste -d ';' <(echo "$drivePartition0" ; echo "$drivePartition1" ; echo "$drivePartition2" ; echo "$drivePartition3" ) <( 
echo "$driveManufacturer0" ; echo "$driveVendor1" ; echo "$driveVendor2" ; echo "$driveVendor3" ) <( 
echo "$driveModel" ; echo "N/A" ; echo "N/A" ; echo "N/A") <( 
echo "$driveSize0" ; echo "$driveSize1" ; echo "$driveSize2" ; echo "$driveSize3" ) <( 
echo "N/A" ; echo "N/A" ; echo "$driveFilesystemSizeSDA2" ; echo "$driveFilesystemSizeSDA3" ) <( 
echo "N/A" ; echo "N/A" ; echo "$driveFilesystemFreeSDA2" ; echo "$driveFilesystemFreeSDA3" ) <( 
echo "$driveMountPoint0" ; echo "$driveMountPoint1" ; echo "$driveMountPoint2" ; echo "$driveMountPoint3" ) | column -N 'Partition Name',Vendor,Model,Size,'Filesystem Size','Filesystem Free Space','Mount Point' -s ';' -o ' | ' -t)


cat << EOF
========================================

--------Disk Storage Information--------
$diskTable

EOF
}
function networkreport {
# NETWORK INFORMATION 

#
networkManu=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "vendor:" | awk '{$1=""; print $0}')
if [ -z "$networkManu" ]; then
	networkManu='"Error!!! Data is unavailable'
else networkManu=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "vendor:" | awk '{$1=""; print $0}')
fi

networkModel=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "product:" | awk '{$1=""; print $0}')
if [ -z "$networkModel" ]; then
	networkModel='"Error!!! Data is unavailable'
else networkModel=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "product:" | awk '{$1=""; print $0}')
fi

networkDesc=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "description:" | awk '{$1=""; print $0}')
if [ -z "$networkDesc" ]; then
	networkDesc='"Error!!! Data is unavailable'
else networkDesc=$(echo "$lshwOutput" | grep -A10 "\*\-network" | grep "description:" | awk '{$1=""; print $0}')
fi

interfaceLinkState=$(ip link show | grep "2:" | awk '{print $9}')
if [ -z "$interfaceLinkState" ]; then
	interfaceLinkState='"Error!!! Data is unavailable'
else interfaceLinkState=$(ip link show | grep "2:" | awk '{print $9}')
fi

interfaceSpeed=$(ethtool "*" | grep "Speed:" | awk '{print $2}')
if [ -z "$interfaceSpeed" ]; then
	interfaceSpeed='"Error!!! Data is unavailable'
else interfaceSpeed=$(ethtool "*" | grep "Speed:" | awk '{print $2}')
fi

interfaceIPAddr=$(ip addr | grep -A5 "2:" | grep -w "inet" | awk '{print $2}')
if [ -z "$interfaceIPAddr" ]; then
	interfaceIPAddr='"Error!!! Data is unavailable'
else interfaceIPAddr=$(ip addr | grep -A5 "2:" | grep -w "inet" | awk '{print $2}')
fi


if [[ "$networkManu" == "$networkModel" ]] && [[ "$networkModel"  == "$networkDesc" ]] && [[ "$networkDesc" == "$interfaceLinkState" ]] && [[ "$interfaceLinkState"  == "$interfaceSpeed" ]] && [[ "$interfaceSpeed"  == "$interfaceIPAddr" ]]; then
	interfaceTable='     Error!!!, Section Unavailable     '
else interfaceTable=$(paste -d ';' <(echo "$networkManu") <(echo "$networkModel") <(echo "$networkDesc") <(echo "$interfaceLinkState") <(echo "$interfaceSpeed") <(echo "$interfaceIPAddr") | column -N Manufacturer,Model,Description,'Interface Link State','Interface Speed','Interface IP Address' -s ';' -o ' | ' -t)

fi

cat << EOF
=========================================

----------Network Information------------
$interfaceTable

EOF
}

function errorMessage {
	local timeStamp
	timeStamp=$(date +"%Y-%a-%d %T")
	local message
	message="$1"
	local logFile
	logFile=/var/log/systeminfo.sh
	if [ -f $logFile ]; then 
		echo "[$timeStamp] $message" >> /var/log/systeminfo.sh
	else touch /var/log/systeminfo.sh || echo "[$timeStamp] $message" >> /var/log/systeminfo.sh
	fi
	
	if [[ "$verbose" == true ]]; then
        echo "Error has occurred at [$timeStamp] for invalid option: $message ; Refer to help section (sysinfo.sh --help)"
	fi
	}
	
function displayHelp {
cat << EOF
	------sysinfo.sh Help------
	
	Usage: sysinfo.sh [Options]
	
	Options Dexriptions
	-h | --help: (display help)
	-v | --verbose: (runs your script verbosely, showing any errors to user)
	-s | --system: (runs computerreport, osreport, cpureport, ramreport, and videoreport)
	-d | --disk: (runs only the diskreport)
	-n | --network: (runs only the networkreport)
EOF
}


