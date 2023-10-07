import { Perpustakaan } from '../typechain';
import { ethers } from 'hardhat';

async function main() {
    // contract instance
    const perpus = await ethers.getContract<Perpustakaan>('PerpustakaanOutDeploy');
    
    // get signers
    const [admin, pengunjung1, pengunjung2] = await ethers.getSigners();

    const storeDataBuku = await perpus
    .connect(admin)
    .store("BK-001", "Sejarah Yogyakarta", 2017, "Rudi Halim", {
        gasPrice: 2000000000, // 2 gwei
        gasLimit: 500000, // max: 19,000,000 gas
    });
    
    await storeDataBuku.wait();

    const storeDataBuku2 = await perpus
    .connect(admin)
    .store("BK-002", "Pembuatan Rumah Murah", 2019, "Saliman", {
        gasPrice: 2000000000, // 2 gwei
        gasLimit: 500000, // max: 19,000,000 gas
    });
    
    await storeDataBuku2.wait();

    const detailBuku = await perpus.books("BK-001");
    console.log('detailBuku =', detailBuku);
}


main().catch( (err) => {
    console.log("Error : ", err);
    process.exitCode = 1;
});