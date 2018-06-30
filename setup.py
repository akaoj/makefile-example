import setuptools

install_requires = [
    "flask",
]

setuptools.setup(
    name="api",
    version="1.0",
    description="Simple API",

    packages=setuptools.find_packages(),

    install_requires=install_requires,

    entry_points={
        "console_scripts": [
            "api = api.__main__:main",
        ],
    },
)
