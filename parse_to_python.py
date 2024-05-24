import os


def convert_sage_files_to_python(directory):
    for root, dirs, files in os.walk(directory):
        for filename in files:
            if filename.endswith(".sage"):
                sage_file = os.path.join(root, filename)
                py_file = os.path.join(root, f"parsed_{filename.strip('.sage')}" + ".py")
                os.system(f"sage --preparse {sage_file}")
                os.rename(sage_file + ".py", py_file)


if __name__ == "__main__":
    convert_sage_files_to_python("WAPB")
