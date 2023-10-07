import { HardhatEthersSigner } from '@nomicfoundation/hardhat-ethers/signers';
import { Perpustakaan } from '../typechain';
import chai from 'chai';
import { ethers, network, deployments } from 'hardhat';

const { expect } = chai;

describe('Perpustakaan Testing Contract', () => {
    let perpustakaan: Perpustakaan;
    let admin: HardhatEthersSigner;
    let pengunjung1: HardhatEthersSigner;
    let pengunjung2: HardhatEthersSigner;

    beforeEach(async () => {
        // get signers
        const accounts = await ethers.getSigners();
        admin = accounts[0];
        pengunjung1 = accounts[1];
        pengunjung2 = accounts[2];


        // deploy with script
        perpustakaan = await (await ethers.getContractFactory('Perpustakaan'))
        .connect(admin)
        .deploy();


        // add employee1
        await perpustakaan
        .connect(admin)
        .store("BK-010", "Sejarah Yogyakarta", 2017, "Rudi Halim");

        // add employee1
        await perpustakaan
        .connect(admin)
        .store("BK-011", "Pembuatan Rumah Murah", 2019, "Saliman");
    });


    describe("Store Function", () => {
        it("Berhasil : Role Admin", async () => {
            const prosesStore = perpustakaan.connect(admin).store("BK-012", "Tutorial Memasak", 2019, "Bu Siti");
            await expect(prosesStore).to.not.be.reverted;
        });

        it("Gagal : Bukan Role Admin", async () => {
            const prosesStore = perpustakaan.connect(pengunjung1).store("BK-013", "Mata Pelajaran IPA", 2021, "Pemerintah");
            await expect(prosesStore).to.be.revertedWith('Only admin can perform this action');


            const prosesStore2 = perpustakaan.connect(pengunjung2).store("BK-014", "Mata Pelajaran IPS", 2021, "Pemerintah");
            await expect(prosesStore2).to.be.revertedWith('Only admin can perform this action');
        });
    });


    describe("Update Function", () => {
        it("Berhasil : Role Admin", async () => {
            const prosesStore = perpustakaan.connect(admin).update("BK-011", "Tutorial Memasak-diupdate", 2019, "Bu Siti-update");
            await expect(prosesStore).to.not.be.reverted;
        });

        it("Gagal : Bukan Role Admin", async () => {
            const prosesStore = perpustakaan.connect(pengunjung1).update("BK-011", "Mata Pelajaran IPA-diupdate", 2021, "Pemerintah-update");
            await expect(prosesStore).to.be.revertedWith('Only admin can perform this action');


            const prosesStore2 = perpustakaan.connect(pengunjung2).update("BK-011", "Mata Pelajaran IPS-diupdate", 2021, "Pemerintah-update");
            await expect(prosesStore2).to.be.revertedWith('Only admin can perform this action');
        });
    });


    describe("Destroy Function", () => {
        it("Berhasil : Role Admin", async () => {
            const prosesStore = perpustakaan.connect(admin).destroy("BK-011");
            await expect(prosesStore).to.not.be.reverted;
        });

        it("Gagal : Bukan Role Admin", async () => {
            const prosesStore = perpustakaan.connect(pengunjung1).destroy("BK-011");
            await expect(prosesStore).to.be.revertedWith('Only admin can perform this action');


            const prosesStore2 = perpustakaan.connect(pengunjung2).destroy("BK-010");
            await expect(prosesStore2).to.be.revertedWith('Only admin can perform this action');
        });
    });
});


// npx hardhat test test/PerpustakaanTest.ts