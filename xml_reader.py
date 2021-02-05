import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup, NavigableString
import csv
import re

data = '''<Node id="1578"/>Agassiz<Node id="1585"/>'''

directory = '/Users/anastasiabernat/Desktop/xml_files/'
file = directory + '2021 - The Scope of Ecology.xml'

# Part 1: Parse XML document.
tree = ET.parse(file)
root = tree.getroot()

print(40*'-', ' Metadata ', 40*'-')
for i in range(0,len(root)):
	print("   ", root[i].tag)

print(40*'-', ' Annotation Keys ', 40*'-')

ann_start_dict = {}
ann_end_dict = {}
a = 1
for x in root[3]:
	a += 1
	print("   ", x.tag, x.attrib)
	key_list = list(x.attrib.values())
	Type = key_list[1]
	StartNode = key_list[2]
	EndNode = key_list[3]

	if StartNode not in ann_start_dict:
		ann_start_dict[StartNode] = [Type, EndNode, a]

	if EndNode not in ann_end_dict:
		ann_end_dict[EndNode] = [Type, StartNode, a]

# Part 2: Beautiful Soup
print(40*'-', ' CSV File ', 40*'-')

soup = BeautifulSoup(open(file), features="lxml")
file_text = soup.prettify()

csv_list = []

for k in ann_start_dict.keys():
	
	row = {}

	ann_start = k 
	ann_end = ann_start_dict[k][1]
	s = [m.end(0) for m in re.finditer(ann_start, file_text)]
	e = [m.start(0) for m in re.finditer(ann_end, file_text)]

	annotation = file_text[(s[0]+19):(e[0]-15)]
	temp = annotation.replace('</node>', '').replace('\n', '')
	temp2 = re.sub(' +', ' ', temp)
	temp3 = re.sub(r'<.+?>', '', temp2)
	final_annotation = re.sub(' +', ' ', temp3)

	row["tag"] = ann_start_dict[k][0]
	row["annotation"] = final_annotation
	csv_list.append(row)

print("   " + directory + "annotation_summary.csv\n")
with open(directory + "annotation_summary.csv", "w") as csv_file:
	writer = csv.DictWriter(csv_file, fieldnames = csv_list[1].keys()) # supposed to be 0?
	writer.writeheader()
	for row in csv_list:
		writer.writerow(row)
	

