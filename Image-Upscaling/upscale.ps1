Get-ChildItem "faces" | 
Foreach-Object {
    $imageFile = $_.fullName
	Add-Type -AssemblyName System.Drawing
	$image = New-Object System.Drawing.Bitmap $imageFile
	#change path
	$cmd = 'C:\!School Modules\semester_3\DIGCRE\Project\Data Samples\upscale-tool\waifu2x-ncnn-vulkan.exe'
	$allArgs = @('-i', $_.fullname, '-o', -join("upscaled_faces/", $_.name), '-n', '2', '-s')
	
	#$argI = $_.fullname
	#$argO = -join("upscaled_faces/", $_.name)
	#$argN = -n  
	#$argS = -s
	
    #& $cmd $allArgs $argN
	#pause
	
	if($image.Width -le 512 -AND $image.Width -ge 256 ) {& $cmd $allArgs 2} #echo $image.Width "upscale * 2" 
	elseif($image.Width -le 255 -AND $image.Width -ge 128) {& $cmd $allArgs 4} #echo $image.Width "upscale * 4"
	elseif($image.Width -le 127 -AND $image.Width -ge 64) {& $cmd $allArgs 8} #echo $image.Width "upscale * 8"
	elseif($image.Width -le 63 -AND $image.Width -ge 32) {& $cmd $allArgs 16} #echo $image.Width "upscale * 16"
	elseif($image.Width -le 31 -AND $image.Width -ge 1) {& $cmd $allArg 32} #echo $image.Width "upscale * 32"
}