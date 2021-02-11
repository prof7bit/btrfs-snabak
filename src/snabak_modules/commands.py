import json


class Command:
    def __init__(self, cmd, config):
        self.cmd = cmd
        self.config = config

    @classmethod
    def from_json(cls, js):
        o = json.loads(js)
        return cls(o["cmd"], o["config"])

    def serialize(self):
        return json.dumps(self.__dict__).encode()
