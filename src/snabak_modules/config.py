import os
from .constants import *
from configparser import ConfigParser, Error


def list_configs():
    """returns a list of existing configurations"""
    _, _, filenames = next(os.walk(CONF_DIR))
    return filenames


def list_snapshots(config):
    snapdir = (os.path.join(config.main.snapshots, config.name))
    _, dirs, _ = next(os.walk(snapdir))
    return dirs


class Config:
    """wraps access to config file with .ini syntax"""

    def __init__(self, name):
        self.name = name
        self.filename = f"{CONF_DIR}/{name}"
        self.cp = ConfigParser()
        try:
            self.loaded = len(self.cp.read(self.filename)) == 1
        except Error:
            pass

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
            except Error:
                return Config.Section.Item('')

    def __getattr__(self, item):
        return Config.Section(self.cp, item)
