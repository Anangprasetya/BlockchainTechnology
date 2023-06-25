// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract VotingKetuaCont {
    struct Pemilih {
        uint weigth;
        bool vooted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        string name;
        uint voteCount;
    }

    address public ketuaPemilu;

    mapping (address => Pemilih) public voters;

    Proposal [] public proposals;

    constructor(string[] memory namaProposal) {
        ketuaPemilu = msg.sender;
        voters[ketuaPemilu].weigth = 1;

        for (uint i; i < namaProposal.length; i++) 
        {
         proposals.push(Proposal({
             name: namaProposal[i],
             voteCount: 0
         }));   
        }
    }

    function addressIkutVote(address voter) public {
        require(
            msg.sender == ketuaPemilu, 
            "Hanya ketua pemilu yang dapat memberikan akses siapa yang dapat memilih."
        );

        require(
            !voters[voter].vooted, 
            "Pemilih ini sudah ikut vote sebelumnya"
        );

        require(voters[voter].weigth == 0);
        voters[voter].weigth = 1;
    }

    function vote(uint proposal) public {
        Pemilih storage sender = voters[msg.sender];
        require(sender.weigth != 0, "Tidak memiliki hak untuk memilih");
        require(!sender.vooted, "Sudah memilih");
        sender.vooted = true;
        sender.vote = proposal;

        proposals[proposal].voteCount += sender.weigth;
    }

    function pemenangProposal() public view returns (uint) {
        uint pemenang = 0;
        uint tmp = 0;
        for (uint i = 0; i < proposals.length; i++) 
        {
            if (proposals[i].voteCount > pemenang) {
                pemenang = proposals[i].voteCount;
                tmp = i;
            }
        }

        return tmp;
    }

    function pemenangVoting() public view returns (string memory){
        return proposals[pemenangProposal()].name;
    }
}