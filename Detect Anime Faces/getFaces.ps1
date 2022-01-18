# change path to image folder
Get-ChildItem "danbooru2020\512px\0033" | 
Foreach-Object {
    python detect.py $_.Name
}

echo "finished"
pause