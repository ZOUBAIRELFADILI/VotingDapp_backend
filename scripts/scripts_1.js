async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Owner address: " + deployer.address);

    const Voting = await ethers.getContractFactory("Voting");
    const votingDeploy = await Voting.deploy();

    await votingDeploy.deployed();
    console.log("Contract deployed successfully at address: " + votingDeploy.address);

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
