#! /usr/bin/python3 

count_line = 0 

with open("dat.txt", "r") as f: 
	for line in f: 
		zero = line.count("0")
		uno = line.count("1") 
		
		if(zero % 3 ==0) or (uno %2 ==0):
			count_line += 1


print(count_line)