const { ConstructorFragment } = require("ethers/lib/utils");

const main = async () => {
    // Builds files under /artifacts
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    //creates a new block chain for testing
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther( "0.1" ),
    });
    // When run it means our constructor can run
    await waveContract.deployed();
    console.log( "Contract address; ", waveContract.address );

    // Contract Balance
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log(
        "Contract balance: ", hre.ethers.utils.formatEther( contractBalance )
    );

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log( waveCount.toNumber() );

    let waveTxn = await waveContract.wave( "A message from a fan!" );
    await waveTxn.wait(); // wait for the transaction to be mined

    let waveTxn2 = await waveContract.wave( "A message from another fan!" );
    await waveTxn2.wait(); // wait for the transaction to be mined

    contractBalance = await hre.ethers.provider.getBalance( waveContract.address );
    console.log(
        "Contract balance: ", hre.ethers.utils.formatEther( contractBalance )
    );

    // const [ _, randomPerson ] = await hre.ethers.getSigners();
    // waveTxn = await waveContract.connect( randomPerson ).wave( "Another message form a fan!" );
    // await waveTxn.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log( allWaves );

};
  
const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};
  
runMain();