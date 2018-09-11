#! /bin/bash

top_output_dir="/remote_home/baetscer/Desktop/FAOD_Leg_DICOMs/"
output_dir_contents=$(ls /remote_home/baetscer/Desktop/FAOD_Leg_DICOMs/)
years="2016 2017 2018"
months="01 02 03 04 05 06 07 08 09 10 11 12"

cd /dicom/

for year in ${years} ; do
	cd $year
	for month in ${months} ; do
		cd ${month}
		faod_list=$(ls -d *"FAOD"*)
		echo $faod_list
		for faod_item in ${faod_list} ; do
			faod_tmp_id=$(echo $faod_item | grep -o "_[0-2][0-9][0-9]_" | head -1)
			faod_id=$(echo $faod_tmp_id | grep -o "[0-2][0-9][0-9]")
			faod_date=$(echo $faod_item | grep -o "201[6-8][0-1][0-9][0-3][0-9]" | head -1)
			visit_day_dir="${faod_id}-${faod_date}"
			visit_day_path="${top_output_dir}/${visit_day_dir}"
			mkdir ${visit_day_path}
			cp -r --parents "${faod_item}"/*/*3D_GRE* "${visit_day_path}"
			cp -r --parents "${faod_item}"/*/*Dixon_3pt_20_* "${visit_day_path}"
		done
		cd ../
	done
	cd ../
done	
		
			
