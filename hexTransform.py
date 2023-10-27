import os

def hex_string_to_file(input_hex, output_bin):
    try:
        # Remove any non-hex characters from the string
        hex_string = ''.join(c for c in input_hex if c in '0123456789abcdefABCDEF')

        # Convert the hex string to bytes
        hex_bytes = bytes.fromhex(hex_string)

        with open(output_bin, 'wb') as output_file:
            output_file.write(hex_bytes)

        print(f"Conversion successful for {input_hex}!")
    except Exception as e:
        print("Error:", e)

def process_hex_files_in_folder():
    for filename in os.listdir("."):
        if filename.endswith(".hex"):
            input_hex_file = filename
            output_bin_file = filename.replace(".hex", ".bin")
            with open(input_hex_file, 'r') as input_file:
                hex_string = input_file.read().strip()
                hex_string_to_file(hex_string, output_bin_file)

if __name__ == "__main__":
    process_hex_files_in_folder()