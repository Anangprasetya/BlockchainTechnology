from flask import Flask
from flask.globals import request
from flask.json import jsonify

from andwlib.BlockTech import BlockChain

if __name__ == "__main__":
    a = BlockChain()