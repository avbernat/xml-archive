import re
import os
import csv

import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup, NavigableString

dir_path = '/Users/anastasiabernat/Desktop/git_repositories/xml-archive/'
xml_path = dir_path + 'xml_files/'
dir_list = sorted(os.listdir(xml_path))

csv_list = []

for file in dir_list:

	#************************************************************************************
	# PART 1: PARSE XML DOCUMENT.
	#
	# Use an XML parser and maker library, xml.etree.ElementTree (ET in short). Most 
	# XMLs are represented in a hierarchical data format. In those cases, the most 
	# natural way to represent an XML file is with a tree. However, that is not what 
	# how GATE annotated XML files are structured. Unlike a hierarchical format, our XML 
	# files have annotations embedded into other annotations and has only 3 main 
	# categories (<AnnotationSet> will always be empty): 
	#
	#		<GateDocumentFeatures> 	
	#				This tells you meta-information about the doc (e.g. title, location).
	#		<TextWithNodes>								
	#				This are where all the annotaitons you wrote are in HTML tags 
	#				called <Nodes id=####>.
	#		<AnnotationSet Name="Original markups">	 	
	#				This has the GATE tagnames you assigned to each annotation. It also 
	#				has the id of where each annotation starts and ends. For example,
	#				
	#				<Annotation Id="126" Type="history" StartNode="1454" EndNode="1708">
	#				</Annotation>
	#
	#************************************************************************************

	print('\n', file)
	tree = ET.parse(xml_path + file)
	root = tree.getroot() # returns the root element for the tree

	print(40*'-', ' Metadata ', 40*'-')
	for i in range(0,len(root)):
		print("   ", root[i].tag) # prints the main-tags of the XML file

	print(40*'-', ' Annotation Keys ', 40*'-')
	
	a = 1
	ann_start_dict = {}
	
	for x in root[3]: # iterate over the annotations in <AnnotationSet Name="Original markups">
		a += 1 # keep a running count of the annotations
		print("   ", x.tag, x.attrib) 
		key_list = list(x.attrib.values())
		Type = key_list[1] 			# GATE tagname
		StartNode = key_list[2] 	# where annotation starts
		EndNode = key_list[3] 		# where annotation ends

		if StartNode not in ann_start_dict:
			ann_start_dict[StartNode] = [Type, EndNode, a]

	#************************************************************************************
	# PART 2: BEAUTIFUL SOUP AND REGEX (regular expressions).
	#
	# Similar to xml.etree.ElementTree, Beautiful Soup pulls out data from HTML and XML 
	# files. I switched over to beautiful soup here because of the prettify() function
	# that turns the XML file into one big string. Then I use regular expressions, which
	# has string matching and modifying functions, in order to pull out each annotation
	# in its string form. Finally, I generate the summary CSV file with all the 
	# annotations for each file.
	#
	#************************************************************************************

	soup = BeautifulSoup(open(xml_path + file), features="lxml")
	file_text = soup.prettify() # spits out document text as one big string

	for ann_start in ann_start_dict.keys(): # iterate over annotations
		
		row = {}

		ann_end = ann_start_dict[ann_start][1]
		s = [m.end(0) for m in re.finditer(ann_start, file_text)] # search for index where annotation starts
		e = [m.start(0) for m in re.finditer(ann_end, file_text)] # search for index where annotation ends

		annotation = file_text[(s[0]+19):(e[0]-15)] # pull out annotation based on indicies

		# clean up the annotation to remove extra spaces or tags
		temp = annotation.replace('</node>', '').replace('\n', '') 
		temp2 = re.sub(' +', ' ', temp)
		temp3 = re.sub(r'<.+?>', '', temp2)
		final_annotation = re.sub(' +', ' ', temp3)

		# add file name, GATE tag and annotation to summary csv file
		row["doc"] = file
		row["tag"] = ann_start_dict[ann_start][0]
		row["annotation"] = final_annotation
		csv_list.append(row)

print("   " + dir_path + "annotation_summary.csv\n")
with open(dir_path + "annotation_summary.csv", "w") as csv_file:
	writer = csv.DictWriter(csv_file, fieldnames = csv_list[0].keys()) 
	writer.writeheader()
	for row in csv_list:
		writer.writerow(row)
	

