#!/bin/bash

# Set 42's header by a shell script like below :
# /*****************************************************************************/
# /*                                                                           */
# /*                                                       :::      ::::::::   */
# /*   filename ${filename}                              :+:      :+:    :+:   */
# /*                                                   +:+ +:+         +:+     */
# /*   by: ${author_name} <${author_mail}>           +#+  +:+        +#+       */
# /*                                               +#+#+#+#+#+    +#+          */
# /*   Created: yyyy/mm/dd hh:mm:ss by ${author_name}   #+#     #+#            */
# /*   Updated: yyyy/mm/dd hh:mm:ss by                 ###   ########.fr       */
# /*                                                                           */
# /*****************************************************************************/

slash="/"
star="*"
space=" "
plus="+"
sha="#"
colon=":"
start_comment="${slash}${star}"
end_comment="${star}${slash}"

function get_nchar()
{
	let "i=0"
	let "number_of_car=$1"
	while [[ $i -lt ${number_of_car} ]]
	do
		echo -n "$2"
		let i++
	done
}

read -p "What is the filename to generate (42 car max) ? " filename
read -p "What is the author's name (18 car max) ? " author_name
read -p "What is the author's mail (24 car max, more if name is smaller than 18 car) ? " author_mail

author_mail="<${author_mail}>"
length_filename="${#filename}"
length_auth_name="${#author_name}"
length_auth_mail="${#author_mail}" 
let length_space_4=42-${length_filename} # Usually there are 43 spaces here
let length_space_6=42-${length_auth_name}-${length_auth_mail} # Usually, there are 44 spaces here
let length_space_8=18-${length_auth_name} # Usually, there are 19 spaces here

# Later, here, check the length of the filename, author's name and mail. If they
# are longer than the gap of the line where they are supposed to be placed,
# please re-ask for the correspondant value that is too much big.
# For the moment, I suppose to be the only one who are using the script, so I
# must remember that I have not make the test for these lengths and be vigilant
# for how long my words will be...

# First line
first_line="${slash}"`get_nchar 78 "${star}"`"${slash}"
echo "$first_line" >> ${filename}
# We get here the accesstime because it is here where the file is created first,
# after we only get the modify time and we don't want this information, Linux
# don't keep the creation time, we have to do it like this
accesstime_filename=`stat "${filename}" | grep Modify | awk 'BEGIN {FS="[: .-]"} {print $3"/"$4"/"$5" "$6":"$7":"$8}'`

# Second line
second_line="${start_comment}"`get_nchar 76 "${space}"`"${end_comment}"
echo "${second_line}" >> ${filename}

# Third line
third_line="${start_comment}"`get_nchar 56 "${space}"``get_nchar 3 "${colon}"`
third_line="${third_line}"`get_nchar 6 "${space}"``get_nchar 8 "${colon}"`
third_line="${third_line}"`get_nchar 3 "${space}"`"${end_comment}"
echo "${third_line}" >> ${filename}

# Fourth line
fourth_line="${start_comment}"`get_nchar 3 "${space}"`"filename ${filename}"
fourth_line="${fourth_line}"`get_nchar ${length_space_4} "${space}"`
fourth_line="${fourth_line}"`get_nchar 1 "${colon}${plus}${colon}"``get_nchar 6 "${space}"`
fourth_line="${fourth_line}"`get_nchar 1 "${colon}${plus}${colon}"``get_nchar 4 "${space}"`
fourth_line="${fourth_line}"`get_nchar 1 "${colon}${plus}${colon}"``get_nchar 3 "${space}"`
fourth_line="${fourth_line}${end_comment}"
echo "${fourth_line}" >> ${filename}

# Fifth line
fifth_line="${start_comment}"`get_nchar 52 "${space}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 1 "${colon}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 1 "${space}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 1 "${colon}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 9 "${space}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 1 "${colon}"``get_nchar 1 "${plus}"`
fifth_line="${fifth_line}"`get_nchar 5 "${space}"`"${end_comment}"
echo "${fifth_line}" >> ${filename}

# Sixth line
sixth_line="${start_comment}"`get_nchar 3 "${space}"`"by: ${author_name} ${author_mail}"
sixth_line="${sixth_line}"`get_nchar ${length_space_6} "${space}"`
sixth_line="${sixth_line}"`get_nchar 1 "${plus}${sha}${plus}"``get_nchar 2 "${space}"`
sixth_line="${sixth_line}"`get_nchar 1 "${plus}${colon}${plus}"``get_nchar 8 "${space}"`
sixth_line="${sixth_line}"`get_nchar 1 "${plus}${sha}${plus}"``get_nchar 7 "${space}"`
sixth_line="${sixth_line}${end_comment}"
echo "${sixth_line}" >> ${filename}

# Seventh line
seventh_line="${start_comment}"`get_nchar 48 "${space}"``get_nchar 1 "${plus}"`
let "i=0"
while [[ $i -lt 5 ]]
do
	seventh_line="${seventh_line}"`get_nchar 1 "${sha}"``get_nchar 1 "${plus}"`
	let i++
done
seventh_line="${seventh_line}"`get_nchar 4 "${space}"``get_nchar 1 "${plus}"`
seventh_line="${seventh_line}"`get_nchar 1 "${sha}"``get_nchar 1 "${plus}"`
seventh_line="${seventh_line}"`get_nchar 10 "${space}"`"${end_comment}"
echo "${seventh_line}" >> ${filename}

# Eighth line
eighth_line="${start_comment}   Created: ${accesstime_filename} by ${author_name}"
eighth_line="${eighth_line}"`get_nchar ${length_space_8} "${space}"`
eighth_line="${eighth_line}"`get_nchar 1 "${sha}${plus}${sha}"`
eighth_line="${eighth_line}"`get_nchar 5 "${space}"``get_nchar 1 "${sha}${plus}${sha}"`
eighth_line="${eighth_line}`get_nchar 12 "${space}"`${end_comment}"
echo "${eighth_line}" >> ${filename}

# Ninth line
# Logically, this line is here if the file was modified, but like the file is
# new , no need to fill it regularly
ninth_line="${start_comment}   Updated: yyyy/mm/dd hh:mm:ss by"`get_nchar 18 "${space}"`
ninth_line="${ninth_line}"`get_nchar 3 "${sha}"``get_nchar 3 "${space}"`
ninth_line="${ninth_line}"`get_nchar 8 "${sha}"`".fr"`get_nchar 7 "${space}"`
ninth_line="${ninth_line}${end_comment}"
echo "${ninth_line}" >> ${filename}

# Tenth line
tenth_line="${second_line}"
echo "${tenth_line}" >> ${filename}

# Eleventh line
eleventh_line="${first_line}"
echo "${eleventh_line}" >> ${filename}

# Open the file that was created with header
vim +11 ${filename}
