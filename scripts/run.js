const main = async () => {
    // Builds files under /artifacts
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    //creates a new block chain for testing
    const waveContract = await waveContractFactory.deploy();
    // When run it means our constructor can run
    await waveContract.deployed();
    console.log( "Contract adds; ", waveContract.address );

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log( waveCount.toNumber() );

    let waveTxn = await waveContract.wave( "A message from a fan!" );
    await waveTxn.wait(); // wait for the transaction to be mined

    const [ _, randomPerson ] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect( randomPerson ).wave( "Another message form a fan!" );
    await waveTxn.wait();

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