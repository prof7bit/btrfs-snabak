import json


class Command:
    def __init__(self, cmd, config, number=None):
        self.cmd = cmd
        self.config = config
        self.number = number

    @classmethod
    def from_json(cls, js):
        o = json.loads(js)
        return cls(o["cmd"], o["config"], o["number"])

    def serialize(self):
        return json.dumps(self.__dict__).encode()
