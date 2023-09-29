from PIL import Image
import os


def adjust_rgb(value):
    if value < 128:
        return 0
    else:
        return 255


# Input and output folder paths
input_folder = "images"
output_folder = "converted images"

# Ensure the output folder exists
if not os.path.exists(output_folder):
    os.makedirs(output_folder)

# Get a list of image files in the input folder
image_files = [
    f for f in os.listdir(input_folder) if f.lower().endswith((".png", ".jpg", ".jpeg"))
]

for image_file in image_files:
    # Open an image
    image_path = os.path.join(input_folder, image_file)
    image = Image.open(image_path)

    # Get the dimensions of the image
    width, height = image.size

    # Create a new image object to store the modified pixels
    new_image = Image.new("RGB", (width, height))

    # Create a list to store pixel values
    pixel_values = []

    # Loop through each pixel and modify the RGB values
    for y in range(height):
        for x in range(width):
            r, g, b = image.getpixel((x, y))  # Get RGB values of the pixel

            # Store original and modified RGB values
            modified_rgb = (
                adjust_rgb(r) / 255,
                adjust_rgb(g) / 255,
                adjust_rgb(b) / 255,
            )
            pixel_values.append(modified_rgb)

            # new_image.putpixel((x, y), modified_rgb)  # Update the pixel in the new image

    # Save the modified image to the output folder
    # output_image_path = os.path.join(output_folder, f"{image_file}_modified")
    # new_image.save(output_image_path)

    # Write pixel values to a text file in the output folder
    pixel_values_path = os.path.join(output_folder, f"{image_file}.txt")
    with open(pixel_values_path, "w") as f:
        for mod in pixel_values:
            f.write(str(int(mod[0])) + str(int(mod[1])) + str(int(mod[2])))
