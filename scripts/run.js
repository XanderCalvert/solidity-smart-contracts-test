const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    // Builds files under /artifacts
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    //creates a new block chain for testing
    const waveContract = await waveContractFactory.deploy();
    // When run it means our constructor can run
    await waveContract.deployed();
  
    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);
  
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
  
    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();

    waveTxn = await waveContract.connect(randomPerson).wave();
    await waveTxn.wait();
  
    waveCount = await waveContract.getTotalWaves(); 
    
    // let waveArray = await waveContract.arrayAddressWavers(); 
    // await waveArray.wait();
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