from os import walk
from .constants import *
from configparser import ConfigParser, NoOptionError, NoSectionError


def list_configs():
    """returns a list of existing configurations"""
    _, _, filenames = next(walk(CONF_DIR))
    return filenames


class Config:
    """wraps access to config file with .ini syntax"""

    def __init__(self, name):
        self.name = name
        self.filename = f"{CONF_DIR}/{name}"
        self.cp = ConfigParser()
        self.cp.read(self.filename)

    class Section:
        """Helper class for getattr trick to use nested object notation"""

        def __init__(self, cp, sect):
            self.cp = cp
            self.sect = sect

        def __getattr__(self, item):
            try:
                return self.cp.get(self.sect, item)
            except (NoOptionError, NoSectionError):
                return ''

    def __getattr__(self, item):
        return Config.Section(self.cp, item)
