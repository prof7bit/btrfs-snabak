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

        class Item(str):
            def __new__(cls, value):
                return super().__new__(cls, value)

            def as_int(self):
                if self == '':
                    return 0
                else:
                    return int(self)  # can raise ValueError

            def as_bool(self):
                s = self.lower()
                if s in ['0', 'f', 'n', 'no', 'false', 'off']:
                    return False
                elif s in ['1', 't', 'y', 'yes', 'true', 'on']:
                    return True
                else:
                    raise ValueError

            def as_list(self):
                return list(filter(None, self.replace(' ', ',').split(',')))

        def __getattr__(self, item):
            try:
                return Config.Section.Item(self.cp.get(self.sect, item))
            except (NoOptionError, NoSectionError):
                return Config.Section.Item('')

    def __getattr__(self, item):
        return Config.Section(self.cp, item)
