import pkginfo
wheel_fname = "wheels/attrdict-2.0.1-py2.py3-none-any.whl"
metadata = pkginfo.get_metadata(wheel_fname)
print(metadata.requires_dist)