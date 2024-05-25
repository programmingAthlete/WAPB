from setuptools import setup, find_packages
from parse_to_python import convert_sage_files_to_python

__version__ = "0.0.0"

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

convert_sage_files_to_python("WAPB")


setup(
    name="WAPB",
    author="Pierrick Meaux",
    version=__version__,
    description="Algebraic Immunity on fixed Hamming Weight",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/programmingAthlete/WAPB.git",
    packages=find_packages(where=".", include=["WAPB*"]),
    zip_safe=False
)