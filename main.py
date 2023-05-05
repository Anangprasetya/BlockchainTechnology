import sys

from flask import Flask
from flask.globals import request
from flask.json import jsonify

from andwlib.BlockTech import BlockChain, Address

blockchainWebApp = Flask(__name__)

add = Address()
node_identifier = add.get()

blockchain = BlockChain()

@blockchainWebApp.route('/blockchain', methods=['GET'])
def select_all():
    resp = {
        'chain' : blockchain.chain,
        'length' : len(blockchain.chain)
    }

    return jsonify(resp), 200



@blockchainWebApp.route('/mine', methods=['GET'])
def tambang_block():
    blockchain.add_transaction(
        sender="server",
        reception=node_identifier,
        amount=1
    )

    last_block = blockchain.hash_block(blockchain.last_block)
    index = len(blockchain.chain)
    nonce_ge = blockchain.proof_of_work(index, last_block, blockchain.current_transactions)
    block = blockchain.append_block(
        hash_prev_block=last_block,
        nonce=nonce_ge
        )
    
    resp = {
        'pesan' : 'Block baru telah ditambahkan (berhasil melakukan mining data)',
        'index' : block['index'],
        'hash_prev_block' : block['hash_prev_block'],
        'nonce' : block['nonce'],
        'transaction' : block['transaction']
    }

    return jsonify(resp), 200


@blockchainWebApp.route('/transaction/new', methods=['POST'])
def transaksi_baru():
    value = request.get_json()

    required_field = ['sender', 'reception', 'amount']

    for r in required_field:
        if r not in value:
            return jsonify({
                'pesan' : f'Field {r} tidak boleh kosong !'
            }), 500
        
    index = blockchain.add_transaction(value['sender'], value['reception'], value['amount'])

    resp = {
        'pesan' : f'Transaksi akan ditambahkan ke blok {index}'
    }

    return jsonify(resp), 200


@blockchainWebApp.route('/nodes/add_nodes', methods=['POST'])
def addnodes():
    vals = request.get_json()
    nodes = vals.get('nodes')

    if nodes is None:
        return "Error, nodes harus ada", 400
    
    for node in nodes:
        blockchain.add_node(node)

    resp = {
        'pesan' : 'Node baru berhasil ditambah',
        'nodes' : list(blockchain.nodes)
    }
    return jsonify(resp), 200

@blockchainWebApp.route('/nodes/sync', methods=['GET'])
def sync():
    update_data = blockchain.update_blockchain()
    if update_data:
        resp = {
            'pesan' : 'Chain berhasil di update dengan data terbaru',
            'blockchain' : blockchain.chain
        }
    else:
        resp = {
                'pesan' : 'Chain kondisi terbaru',
                'blockchain' : blockchain.chain
            }
        
    return jsonify(resp), 200


if __name__ == "__main__":
    blockchainWebApp.run(host='0.0.0.0', port=int(sys.argv[1]))