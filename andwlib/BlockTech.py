import sys
import hashlib
import json
import requests

from urllib.parse import urlparse
from time import time
from uuid import uuid4

class BlockChain:
    difficulty_target_atauKesulitanTarget = "2001"

    def __init__(self):
        self.chain = []
        self.current_transactions = []

        genesis_hash = self.hash_block("root blockchain by Anang Nur Prasetya")
        print("genesis_hash : ")
        print(genesis_hash)

        self.append_block(
            hash_prev_block = genesis_hash,
            nonce = self.proof_of_work(0, genesis_hash, [])
        )


    def hash_block(self, block):
        block_encode = json.dumps(block, sort_keys=True).encode()
        print("block encode : ")
        print(block_encode)
        return hashlib.sha256(block_encode).hexdigest()

    
    def append_block(self, hash_prev_block, nonce):
        pass


    def proof_of_work(self, index, hash_prev_block, transaction):
        nonce = 0

        while self.not_valid_proof(index, hash_prev_block, transaction, nonce):
            nonce = nonce + 1


    def not_valid_proof(self, index, hash_prev_block, transaction, nonce):
        konten = f'{index};{hash_prev_block};{transaction};{nonce}'
        print("konten : ")
        print(konten)

        konten = konten.encode()
        print("konten : ")
        print(konten)

        enckrip_konten = hashlib.sha256(konten).hexdigest()
        print("enckrip_konten : ")
        print(enckrip_konten)

        if enckrip_konten[:len(self.difficulty_target_atauKesulitanTarget)] == self.difficulty_target_atauKesulitanTarget:
            return False
        
        return True