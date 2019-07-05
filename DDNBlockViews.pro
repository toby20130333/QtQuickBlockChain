TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS = hash \
                   src
src.depends = hash

