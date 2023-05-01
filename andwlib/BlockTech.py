import hashlib
import json
import requests

from urllib.parse import urlparse
from time import time
from uuid import uuid4

class BlockChain:
    difficulty_target_atauKesulitanTarget = "2001"

    @property
    def last_block(self):
        return self.chain[-1]

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
        myblock = {
            'index' : len(self.chain),
            'timestamp' : time(),
            'transaction' : self.current_transactions,
            'nonce' : nonce,
            'hash_prev_block' : hash_prev_block,
        }

        print("myblock : ")
        print(myblock)

        self.chain.append(myblock)
        self.current_transactions = []

        print("self.chain : ")
        print(self.chain)

        return myblock


    def proof_of_work(self, index, hash_prev_block, transaction):
        nonce = 0

        while self.not_valid_proof(index, hash_prev_block, transaction, nonce):
            nonce = nonce + 1

        return nonce


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
    
    def add_transaction(self, sender, reception, amount):
        self.current_transactions.append({
            'amount' : amount,
            'reception' : reception,
            'sender' : sender
        })

        return self.last_block['index'] + 1
    

class Address:
    
    def __init__(self):
        self.add = str(uuid4()).replace('-', "")

    def get(self):
        return self.add