input_file = "bird.txt"

with open(input_file, "r") as infile:
    binary_data = infile.read().replace("\n", "")
    segments = [binary_data[i : i + 3] for i in range(0, len(binary_data), 3)]

with open(input_file, "w") as outfile:
    outfile.write("\n".join(segments))
