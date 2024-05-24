from setuptools import setup, find_packages

__version__ = "0.0.0"

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

with open("requirements.txt", "r") as f:
     requirements = f.read().splitlines()


setup(
    name="WAPB",
    author="Pierrick Meaux",
    version=__version__,
    description="Algebraic Immunity on fixed Hamming Weight",
    long_description=long_description,
    long_description_content_type="text/markdown",
    packages=find_packages(where=".", include=["WAPB*"]),
    zip_safe=False
)