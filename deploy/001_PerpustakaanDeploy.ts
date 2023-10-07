import { DeployFunction } from 'hardhat-deploy/dist/types';
import { HardhatRuntimeEnvironment } from 'hardhat/types';

const func: DeployFunction = async({
    deployments,
    ethers,
} : HardhatRuntimeEnvironment) => {

    const { deploy } = deployments;
    const accounts = await ethers.getSigners();

    const deployer = accounts[0];
    console.log('deployer address =', deployer.address);

    const perpus = await deploy('PerpustakaanOutDeploy', {
        contract: 'Perpustakaan',
        from: deployer.address,
        args: [],
        gasLimit: 1000000,
    });
    console.log('perpustakaan deployed at ', perpus.address);

}

func.tags = ['PerpustakaanTag'];

export default func;
